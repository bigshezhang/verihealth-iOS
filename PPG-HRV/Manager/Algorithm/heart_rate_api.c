#include "heart_rate_api.h"
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define HR_HALF_UINT16 32768
#define HR_PPG_SAMPLE_RATE 50
#define HR_BUF_TIME_LEN 5

#define PPG_BUF_LEN 52


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
    uint16_t buf[10];
    uint16_t count;
    uint16_t avg;
    int8_t full;
}RRDetecter;
typedef struct RRCalc
{
    float avg;
    double square_sum;
    uint16_t valid_count;
    uint16_t i;
}RRCalc;

/* variables for data and result buffering, and data counting */
static PpgDataset ppg_data_buf = {0,0,{0}};
static MeanFilter mean_filter1 ={0,0,NULL,0};
static MeanFilter mean_filter2 ={0,0,NULL,0};
static MeanOutput mean_output1 ={0,0};
static MeanOutput mean_output2 ={0,0};
static BeatCalc beat_calc = {0,0,0,0,0,0,{0},{0}};
static RRDetecter rr_detecter = {{0},0,0,0};
static RRCalc rr_calc = {0,0,0,0};

static int8_t* rr_result;
static uint16_t* rr_interval_list;
static BridgeData bridge_data;
static BridgeResult bridge_result;
static PpgData ppgdata = {
    .sample_rate = 50,
    .data = NULL,
    .size = 0,
    .data_format = 1
};
static int rr_detect(uint16_t* interval,int16_t interval_size){
    
    uint16_t i = 0;
    AlgoError ret = ALGO_ERR_GENERIC;
    for (; rr_detecter.count < interval_size; rr_detecter.count++){
        if(rr_detecter.count > 1){
            for(i = 0,rr_detecter.avg = 0; i < (rr_detecter.count > 10 ? 10: rr_detecter.count); i++){
                rr_detecter.avg += *(rr_detecter.buf+i);
            }
            rr_detecter.avg = rr_detecter.avg/(rr_detecter.count > 10 ? 10: rr_detecter.count);
            if(*(interval+(rr_detecter.count%180)) - rr_detecter.avg>80||*(interval+(rr_detecter.count%180))  - rr_detecter.avg < -80){
                *(rr_result+(rr_detecter.count%180)) = 0;
            }else{
                *(rr_result+(rr_detecter.count%180)) = 1;
                ret = ALGO_NORMAL;
            }
        }else{
            *(rr_result+rr_detecter.count) = 0;
        }
        
        *(rr_detecter.buf+(rr_detecter.count%10)) = *(interval + (rr_detecter.count%180));
        if(rr_detecter.count==10-1)rr_detecter.full=1;
    }
    return ret;
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
    memset(&rr_calc,0,sizeof(RRCalc));
    memset(&bridge_data, 0, sizeof(BridgeData));
    memset(&bridge_result, 0, sizeof(BridgeResult));
    ppgdata.data = malloc(sizeof(uint16_t)*100);
    mean_filter1.buf = NULL;
    mean_filter2.buf = NULL;

    mean_filter1.len = 51;
    mean_filter1.buf = (int16_t *)malloc(mean_filter1.len*sizeof(int16_t));
    mean_filter2.len = 5;
    mean_filter2.buf = (int16_t *)malloc(mean_filter2.len*sizeof(int16_t));
    rr_interval_list = (int16_t*)malloc(180*sizeof(uint16_t));
    rr_result = (int8_t*) malloc(180*sizeof(int8_t));
    
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
    memset(&rr_calc,0,sizeof(RRCalc));
    memset(rr_interval_list,0,180*sizeof(uint16_t));
    memset(rr_result,0,180*sizeof(int8_t));
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
    free(rr_result);
    return ALGO_NORMAL;
}

static int hr_preprocess(PpgData *ppg){
    uint16_t i = 0;
    int16_t tmp_data = 0;
    AlgoError ret  =  ALGO_ERR_GENERIC;
    if(!ppg || ppg->size == 0){
        return ALGO_ERR_GENERIC;
    }
    for (i = 0; i < ppg->size; i++){
        tmp_data = (int16_t)(*(ppg->data+i));
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
//    AlgoError algo_err;
    uint16_t i = 0;
    uint16_t idx = 0;
    AlgoError ret = ALGO_ERR_GENERIC;
    if(!ppg || ppg->size==0){
        return ALGO_ERR_GENERIC; //invalid pointer
    }
    ret = hr_preprocess(ppg);
    if(ret == ALGO_NORMAL){
        for(i = ppg_data_buf.size; i < ppg_data_buf.size + PPG_BUF_LEN;i++){
            idx = i % PPG_BUF_LEN;
            if(ppg_data_buf.data[(i + 1) % PPG_BUF_LEN] - ppg_data_buf.data[idx] > 0){
                beat_calc.sign = 1;
            }else{
                beat_calc.sign = -1;
            }
            beat_calc.diff_data[idx] = beat_calc.sign;
        }
        for(i = ppg_data_buf.size; i < ppg_data_buf.size + ppg->size;i++){
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
                if(value!=NULL)*value = (beat_calc.beat_count > 4 ? 3 : beat_calc.beat_count-1)*60.0*HR_PPG_SAMPLE_RATE/(beat_calc.pos_buffer[3]-beat_calc.pos_buffer[0]);
                if(beat_calc.beat_count >=2){
                    *(rr_interval_list+(beat_calc.beat_count-2)%180) = (beat_calc.pos_buffer[4] - beat_calc.pos_buffer[3])*1000/HR_PPG_SAMPLE_RATE;
                }
            }
            
        }
        beat_calc.seconds ++;
        return ALGO_NORMAL;
    }
    return ALGO_ERR_GENERIC;
}
int hrv_hr_process(PpgData* ppg, uint16_t* hrv, uint16_t* hr){
    AlgoError ret;
    ret = heart_rate_process(ppg,hr);
    if(ret == ALGO_NORMAL){
        ret = rr_detect(rr_interval_list,beat_calc.beat_count-1);
        if(ret == ALGO_NORMAL){
            rr_calc.avg = 0;
            rr_calc.square_sum = 0;
            rr_calc.valid_count = 0;
            rr_calc.i=0;
            if(beat_calc.beat_count-1>180){
                for(rr_calc.i = 0;rr_calc.i<180;rr_calc.i++){
                    if(*(rr_result+rr_calc.i)==1){
                        rr_calc.avg+=*(rr_interval_list+rr_calc.i);
                        rr_calc.valid_count++;
                    }
                }
                rr_calc.avg = rr_calc.avg/(double)rr_calc.valid_count;
                for(rr_calc.i = 0;rr_calc.i<180;rr_calc.i++){
                    if(*(rr_result+rr_calc.i)==1){
                        rr_calc.square_sum += ((float)*(rr_interval_list+rr_calc.i)-rr_calc.avg)*((float)*(rr_interval_list+rr_calc.i)-rr_calc.avg);
                    }
                }
                rr_calc.square_sum = rr_calc.square_sum/rr_calc.valid_count;
                *hrv = (uint16_t)sqrt(rr_calc.square_sum);
                return ALGO_NORMAL;
            }else{
                for(rr_calc.i = 0;rr_calc.i<beat_calc.beat_count-1;rr_calc.i++){
                    if(*(rr_result+rr_calc.i)==1){
                        rr_calc.avg+=*(rr_interval_list+rr_calc.i);
                        rr_calc.valid_count++;
                    }
                }
                rr_calc.avg = rr_calc.avg/(double)rr_calc.valid_count;
                for(rr_calc.i = 0;rr_calc.i<beat_calc.beat_count-1;rr_calc.i++){
                    if(*(rr_result+rr_calc.i)==1){
                        rr_calc.square_sum += ((float)*(rr_interval_list+rr_calc.i)-rr_calc.avg)*((float)*(rr_interval_list+rr_calc.i)-rr_calc.avg);
                    }
                }
                rr_calc.square_sum = rr_calc.square_sum/rr_calc.valid_count;
                *hrv = (uint16_t)sqrt(rr_calc.square_sum);
                return ALGO_NORMAL;
            }
            
        }
    }
    *hrv=0;
    return ALGO_ERR_GENERIC;
}
int hrv_process(PpgData *ppg, uint16_t* hrv){
    return hrv_hr_process(ppg,hrv,NULL);
}

BridgeResult bridge(BridgeData data){
    static uint16_t sdnn = 0;
    static uint16_t hr = 0;
    for(int i = 0;i < data.size/2;i++){
        ppgdata.data[i] = data.data[i*2];
    }
    ppgdata.size = data.size/2;
    bridge_result.ret = hrv_hr_process(&ppgdata, &sdnn, &hr);
    bridge_result.hr = hr;
    bridge_result.sdnn = sdnn;
    return bridge_result;
}
