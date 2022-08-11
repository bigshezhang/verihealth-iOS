#include "heart_rate_api.h"
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define HR_HALF_UINT16 32768
#define HR_PPG_SAMPLE_RATE 50
#define HR_BUF_TIME_LEN 5

#define PPG_BUF_LEN 52

#define SAMPLE_RATE 50

uint32_t ppg_buf[10000] = {0};
PpgResult heart_rate_calc(uint16_t sec_data[50]){
    PpgResult result;
    #if DEBUG_FLAG == 1
    #endif
    PpgData input_data = {SAMPLE_RATE,sec_data};
    int cnt = 0,time_sec = 0;
    AlgoError ret;
    uint16_t hr_value = 0;
    int i = 0,j = 0;
//    heart_rate_init_api();
//    for(i=0;i<cnt-SAMPLE_RATE; i = i + SAMPLE_RATE){
//        time_sec++;
//        for (j=0;j < SAMPLE_RATE; j++){
//            sec_data[j] = ppg_buf[i+j];
//        }
        ret = heart_rate_process(&input_data,&hr_value);
        if(ret==0){
            printf("%d\n",hr_value);
            result =  heart_rate_result();
            if(result.err == ALGO_NORMAL){
                result.hr = hr_value;
                printf("sdnn:%f",result.sdnn);
            }
        }
//    }

    return result;
}




typedef struct PpgDataset{
    uint16_t full;
    uint16_t size;
    int16_t data[PPG_BUF_LEN];
}PpgDataset;

typedef struct MeanFilter
{
    uint16_t len;
    int16_t cnt;
    int16_t *buf;
    uint8_t buf_full;

} MeanFilter;

typedef struct MeanOutput{
    int16_t raw;
    int16_t filt;
}MeanOutput;

typedef struct BeatCalc
{
    int8_t has_fixed;
    int8_t sign;
    uint16_t data_count;
    int16_t beat_count;
    int16_t seconds;
    int16_t current_pos;
    int8_t diff_data[PPG_BUF_LEN];
    int16_t pos_buffer[5];//save last 5 position
}BeatCalc;
typedef struct RRDetecter
{
    int16_t buf[10];
    int16_t count;
    int16_t avg;
    int8_t full;
}RRDetecter;


/* variables for data and result buffering, and data counting */
static PpgDataset ppg_data_buf = {0,0,{0}};
static MeanFilter mean_filter1 ={0,0,NULL,0};
static MeanFilter mean_filter2 ={0,0,NULL,0};
static MeanOutput mean_output1 ={0,0};
static MeanOutput mean_output2 ={0,0};
static BeatCalc beat_calc = {0,0,0,0,0,0,{0},{0}};
static RRDetecter rr_detecter = {{0},0,0,0};

static uint8_t* rr_result;
static uint16_t* rr_interval_list;

static int rr_detect(int16_t* interval,int16_t interval_size){
    uint16_t i = 0;
    rr_result = (uint8_t*) malloc(interval_size*sizeof(uint8_t));
    
    for (rr_detecter.count = 0; rr_detecter.count < interval_size; rr_detecter.count++){
        if(rr_detecter.count > 1){
            for(i = 0,rr_detecter.avg = 0; i < (rr_detecter.count > 10 ? 10: rr_detecter.count); i++){
                rr_detecter.avg += *(rr_detecter.buf+i);
            }
            rr_detecter.avg = rr_detecter.avg/(rr_detecter.count > 10 ? 10: rr_detecter.count);
            if(*(interval+rr_detecter.count) - rr_detecter.avg>80||*(interval+rr_detecter.count)  - rr_detecter.avg < -80){
                *(rr_result+rr_detecter.count) = 0;
            }else{
                *(rr_result+rr_detecter.count) = 1;
            }
        }else{
            *(rr_result+rr_detecter.count) = 0;
        }
        
        
        *(rr_detecter.buf+rr_detecter.count%10) = *(interval + rr_detecter.count);
        if(rr_detecter.count==10-1)rr_detecter.full=1;
    }
    return ALGO_NORMAL;
}

static int mf_process(MeanFilter*filter,MeanOutput*output,int16_t data){
    uint16_t i = 0,j = 0;
    int32_t tmp_data = 0;
    uint16_t half_len = 0;
    AlgoError ret = ALGO_ERR_GENERIC;
    if(!filter || !output){
        return ALGO_ERR_GENERIC;
    }
    half_len = (filter->len - 1) >> 1;

    if(filter->buf_full==0){
        if(filter->cnt < filter->len){
            filter->buf[filter->cnt] = data;
            filter->cnt++;
            if (filter-> cnt % 2 == 1){
                j=(filter->cnt-1)>>1;
                tmp_data = 0;
                for(i=0;i<filter->cnt;i++){
                    tmp_data += filter->buf[i];
                }
                output->filt = (int16_t)(tmp_data/(filter->cnt));
                output->raw = filter->buf[j];
                ret = ALGO_NORMAL;
            }

            if (filter->cnt >= filter->len)
            {
                filter->buf_full = 1;
                filter->cnt = 0;
            }
        }
    }else{
        if (filter->cnt < filter->len){
            filter->buf[filter->cnt]=data;
            filter->cnt++;
            if(filter->cnt >= filter->len){
                filter->cnt = 0;
            }
        }
        j = (filter->cnt + half_len) % (filter->len);
        tmp_data =0;
        for(i=0;i<filter->len;i++){
            tmp_data += filter->buf[i];
        }
        output->filt = (int16_t)(tmp_data/(filter->len));
        output->raw = filter->buf[j];
        ret =  ALGO_NORMAL;
    }
    return ret;
}

int heart_rate_init_api(void){
    memset(&ppg_data_buf,0,sizeof(ppg_data_buf));
    memset(&mean_filter1, 0, sizeof(MeanFilter));
    memset(&mean_filter2, 0, sizeof (MeanFilter));
    memset(&mean_output1,0,sizeof(MeanOutput));
    memset(&mean_output2,0,sizeof(MeanOutput));
    memset(&beat_calc,0,sizeof(BeatCalc));
    memset(&rr_detecter,0,sizeof(RRDetecter));
    mean_filter1.buf = NULL;
    mean_filter2.buf = NULL;

    mean_filter1.len = 51;
    mean_filter1.buf = (int16_t *)malloc(mean_filter1.len*sizeof(int16_t));
    mean_filter2.len = 5;
    mean_filter2.buf = (int16_t *)malloc(mean_filter2.len*sizeof(int16_t));

    #if DEBUG_FLAG == 1
        rr_interval_list = malloc(10000*sizeof(uint16_t));
    #else
        rr_interval_list = malloc(180*sizeof(uint16_t));
    #endif
    if (!mean_filter1.buf || !mean_filter2.buf){
        return ALGO_ERR_GENERIC;
    }
    return ALGO_NORMAL;
}

int heart_rate_reset_api(void){
    memset(&ppg_data_buf,0,sizeof(PpgDataset));
    memset(&mean_filter1,0,sizeof(MeanFilter));
    memset(&mean_filter2,0,sizeof(MeanFilter));
    memset(&mean_output1,0,sizeof(MeanOutput));
    memset(&mean_output2,0,sizeof(MeanOutput));
    memset(&beat_calc,0,sizeof(BeatCalc));
    memset(&rr_detecter,0,sizeof(RRDetecter));
    #if DEBUG_FLAG == 1
        memset(rr_interval_list,0,10000*sizeof(uint16_t));
    #else
        memset(rr_interval_list,0,180*sizeof(uint16_t));
    #endif
    return ALGO_NORMAL;
}

int heart_rate_exit_api(void){
    if(mean_filter1.buf){
        free(mean_filter1.buf);
        mean_filter1.buf = NULL;
    }
    if(mean_filter2.buf){
        free(mean_filter2.buf);
        mean_filter2.buf = NULL;
    }
    free(rr_interval_list);
    return ALGO_NORMAL;
}

static int hr_preprocess(PpgData *ppg){
    uint16_t i = 0;
    int16_t tmp_data = 0;
    AlgoError ret  =  ALGO_ERR_GENERIC;
    if(!ppg || ppg->data_size == 0){
        return ALGO_ERR_GENERIC;
    }
    for (i = 0; i < ppg->data_size; i++){
        tmp_data = (int16_t)(*(ppg->data_array+i));
        ret = mf_process(&mean_filter1,&mean_output1,tmp_data);
        if(ret == ALGO_NORMAL){
            ret = mf_process(&mean_filter2, &mean_output2, mean_output1.raw - mean_output1.filt);
            if (ret == ALGO_NORMAL){
                if(ppg_data_buf.size < PPG_BUF_LEN){
                    ppg_data_buf.data[ppg_data_buf.size] = mean_output2.filt;
                    ppg_data_buf.size += 1;
                    if(ppg_data_buf.size >= PPG_BUF_LEN){
                        if (ppg_data_buf.full==0)
                        {
                            ppg_data_buf.full=1;
                        }
                        ppg_data_buf.size=0;
                    }
                }
            }
        }
    
    }
    if(ppg_data_buf.full==1){
        return ALGO_NORMAL;
    }else{
        return ALGO_ERR_GENERIC;
    }
}

int heart_rate_process(PpgData *ppg, uint16_t *value){
    #if DEBUG_FLAG == 1
        FILE *pos_file = fopen("data_position.txt","a");
        FILE *mean_file = fopen("data_mean.txt","a");
        FILE *heart_file = fopen("data_heart.txt","a");
        fprintf(heart_file,"%d\n",*value);
    #endif


    AlgoError algo_err;
    uint16_t i = 0;
    uint16_t idx = 0;
    AlgoError ret = ALGO_ERR_GENERIC;
    if(!ppg || ppg->data_size==0){
        return ALGO_ERR_GENERIC; //invalid pointer
    }
    ret = hr_preprocess(ppg);
    
    if(ret == ALGO_NORMAL){
        #if DEBUG_FLAG == 1
        for(i = ppg_data_buf.size; i < ppg_data_buf.size + 50 ;i++){
            idx = i % PPG_BUF_LEN;
            fprintf(mean_file,"%d\n",ppg_data_buf.data[idx]);
        }
        #endif
        for(i = ppg_data_buf.size; i < ppg_data_buf.size + PPG_BUF_LEN;i++){
            idx = i % PPG_BUF_LEN;
            if(ppg_data_buf.data[(i + 1) % PPG_BUF_LEN] - ppg_data_buf.data[idx] > 0){
                beat_calc.sign = 1;
            }else{
                beat_calc.sign = -1;
            }
            beat_calc.diff_data[idx] = beat_calc.sign;
        }
        for(i = ppg_data_buf.size; i < ppg_data_buf.size + ppg->data_size;i++){
            idx = i % PPG_BUF_LEN;
            beat_calc.data_count++;
            beat_calc.diff_data[idx] = beat_calc.diff_data[(i + 1) % PPG_BUF_LEN] - beat_calc.diff_data[idx];
            if(beat_calc.diff_data[idx] == -2 && ppg_data_buf.data[(i + 1) % PPG_BUF_LEN] > 0){
                if(beat_calc.data_count - beat_calc.pos_buffer[4] < 17){//180bpm
                    beat_calc.pos_buffer[4] = beat_calc.data_count;
                }else{
                    memcpy(beat_calc.pos_buffer, beat_calc.pos_buffer+1,4*sizeof(int16_t));
                    beat_calc.pos_buffer[4] = beat_calc.data_count;
                    beat_calc.beat_count++;
                }
                *value = (beat_calc.beat_count > 4 ? 3 : beat_calc.beat_count-1)*60.0*HR_PPG_SAMPLE_RATE/(beat_calc.pos_buffer[3]-beat_calc.pos_buffer[0]);
                if(beat_calc.beat_count >=2){
                    rr_interval_list[beat_calc.beat_count-2] = (beat_calc.pos_buffer[4] - beat_calc.pos_buffer[3])*1000/HR_PPG_SAMPLE_RATE;
                }
                #if DEBUG_FLAG == 1
                fprintf(pos_file,"%d\n",beat_calc.pos_buffer[3]);
                #endif
            }
            
        }
        beat_calc.seconds ++;
        #if DEBUG_FLAG == 1
        fclose(pos_file);
        fclose(mean_file);
        fclose(heart_file);
        #endif
        return ALGO_NORMAL;
    }
    return ALGO_ERR_GENERIC;
}

PpgResult heart_rate_result(){
    #if DEBUG_FLAG == 1
    #endif
    float avg = 0;
    double square_sum = 0;
    uint16_t valid_count = 0;
    uint16_t i = 0;
    rr_detect(rr_interval_list,beat_calc.beat_count-1);
    for(i = 0;i<beat_calc.beat_count-1;i++){
        #if DEBUG_FLAG == 1
        #endif
        if(*(rr_result+i)==1){
            avg+=*(rr_interval_list+i);
            valid_count++;
        }
    }
    avg = avg/(double)valid_count;
    for(i = 0;i<beat_calc.beat_count-1;i++){
        square_sum += ((float)*(rr_interval_list+i)-avg)*((float)*(rr_interval_list+i)-avg);
    }
    square_sum = square_sum/valid_count;
    free(rr_result);
    double sdnn = sqrt(square_sum);
    PpgResult result = {ALGO_NORMAL,sdnn};
    #if DEBUG_FLAG == 1
    #endif
    return result;
}



