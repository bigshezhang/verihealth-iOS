#ifndef __HEART_RATE_API_H_
#define __HEART_RATE_API_H_

#define DEBUG_FLAG 0

#include <stdint.h>

typedef struct PpgData{
    uint32_t data_size;
    uint32_t *data_array;
}PpgData;

typedef struct PpgResult{
    int err;
    double sdnn;
    double hr;
}PpgResult;


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
*@param ppg·the raw ppg·data
*@return return·errornum
*/
int heart_rate_process(PpgData *ppg, uint16_t*heart_rate);
/**
 * @brief get the sdnn by the data after init or reset.
 * @return return PpgResult{int errno;double sdnn;}
 */
PpgResult heart_rate_result();

/**
*@brief reset·algorithm
*@return return·errornum
*/
int heart_rate_reset_api(void);

/**
*@brief exit function
*@return return errornum
*/
int heart_rate_exit_api(void);

PpgResult heart_rate_calc(uint16_t sec_data[50]);

#endif

