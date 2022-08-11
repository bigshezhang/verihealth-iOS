#ifndef __HEART_RATE_API_H_
#define __HEART_RATE_API_H_

#include <stdint.h>

typedef enum PpgDataFormat {
    GREEN_FORMAT = 0, /**< Format: Green, Green, Green */
    RED_IR_FORMAT = 1, /**< Format: Red,IR, Red,IR, Red,IR */
    RED_FORMAT = 2, /**< Format: Red, Red, Red */
    IR_FORMAT = 3, /**< Format: IR, IR, IR */
} PpgDataFormat;

typedef struct PpgData {
    PpgDataFormat data_format;
    uint16_t sample_rate;
    uint16_t size;
    uint16_t *data;
} PpgData;

typedef struct BridgeData{
    uint16_t size;
    uint16_t data[64];
}BridgeData;
typedef struct BridgeResult{
    uint16_t ret;
    uint16_t sdnn;
    uint16_t hr;
}BridgeResult;

typedef enum AlgoError{
    ALGO_ERR_GENERIC = -1,
    ALGO_NORMAL = 0
}AlgoError;
/**
*@brief init function
*@return return errornum
*/
int heart_rate_init_api(void);

/**
*@brief input data and calculate the result of heart_rate algorithm
*@param heart_rate the result of heart_rate per minute (ms)
*@param ppg the raw ppg data
*@return return·errornum
*/
int heart_rate_process(PpgData *ppg, uint16_t*heart_rate);

/**
*@brief input data and calculate the result of sdnn algorithm
*@param ppg the raw ppg data
*@param hrv the sdnn of heart_rate
*@return return errornum(0:success)
*/
int hrv_process(PpgData* ppg, uint16_t* hrv);
/**
*@brief input data and calculate the result of sdnn algorithm
*@param ppg the raw ppg data
*@param hrv the sdnn of heart_rate
*@param hr the heart beat per min
*@return return errornum(0:success)
*/
int hrv_hr_process(PpgData* ppg, uint16_t* hrv,uint16_t* hr);

/**
*@brief reset algorithm
*@return return errornum
*/
int heart_rate_reset_api(void);

/**
*@brief exit function
*@return return errornum
*/
int heart_rate_exit_api(void);
#endif

BridgeResult bridge(BridgeData);
