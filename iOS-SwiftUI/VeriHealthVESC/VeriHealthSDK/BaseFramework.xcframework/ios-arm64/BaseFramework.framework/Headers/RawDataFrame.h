//
//  RawDataFrame
//  BaseFramework
//
//  Created by Alex Lin on 2021/7/22.
//

#ifndef RawDataFrame_h
#define RawDataFrame_h

/** @addtogroup DataFrame
 *  @ingroup BaseFramework
 *  @{
 */

#import <Foundation/Foundation.h>

@interface RawDataFrame : NSObject

@property (nonatomic) uint8_t sensor_type; /**< Sensor type defined by upper layer */
@property (nonatomic) uint8_t subtype; /**<  Subtype of sensor defined by upper layer */
@property (nonatomic) uint8_t mode; /**< Work mode of sensor  */
@property (nonatomic) uint8_t data_format; /**< Data format of samples  */
@property (nonatomic) uint16_t sample_cnt; /**< Sample count of received raw data  */
@property (nonatomic) uint16_t sample_rate; /**< Sample rate of raw data in Hz */
@property (nonatomic) uint8_t sample_size; /**< Sample size of raw data in Byte */
@property (nonatomic) uint8_t channels; /**< Channel numbers of raw data */
@property (nonatomic) uint16_t collection_id; /**<  Collection ID */
@property (nonatomic) uint64_t time_stamp; /**<  UTC time stamp in  millisecond*/
@property (nonatomic) BOOL is_compressed; /**< Flag of compression, YES for compression */
@property (nonatomic) BOOL is_start; /**< Flag of start, YES for start */
@property (nonatomic) BOOL is_end; /**< Flag of end, YES for end */
@property (nonatomic) BOOL is_msb; /**< Flag of MSB, YES for MSB */
@property (nonatomic) BOOL is_encrypted; /**< Flag of encryption, YES for encryption */
@property (nonatomic) BOOL is_cached; /**< Flag of cached data, YES for cached data */
@property (nonatomic) BOOL is_processed; /**< Flag of processed, YES for processed */
@property (strong, nonatomic) NSData *data; /**<  Object of data in NSData */
@property (strong, nonatomic) NSArray *array_data; /**<  Object of data in Array */
@property (nonatomic) int result_val; /**< Result data which got from algoirthm */

@end
/** @} */
#endif /* RawDataFrame_h */
