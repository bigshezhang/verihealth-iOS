//
//  ResultDataFrame.h
//  BaseFramework
//
//  Created by Alex Lin on 2021/7/22.
//

#ifndef ResultDataFrame_h
#define ResultDataFrame_h

/** @addtogroup DataFrame
 *  @ingroup BaseFramework
 *  @{
 */

#import <BaseFramework/ResultDefine.h>
#import <BaseFramework/VsaErrorDefine.h>

@interface ResultDataFrame : NSObject

@property (nonatomic) uint16_t duration; /**< Duration in seconds */
@property (nonatomic) uint32_t time_stamp; /**< UTC timestamp in second  */
@property (nonatomic) BOOL is_local_algo; /**< Flag of local algorithm processing  */
@property (nonatomic) BOOL is_start; /**< Flag of start, YES for start */
@property (nonatomic) BOOL is_end; /**< Flag of end, YES for end */
@property (nonatomic) BOOL is_encrypted; /**< Flag of encryption */
@property (nonatomic) BOOL is_cached; /**< Flag of cached data, YES for cached data */
@property (nonatomic) BOOL is_test; /**< Flag  of test data , YES for test data */
@property (strong, nonatomic) NSArray *data_fmt; /**< Format of data */
/**
 * Format of sample_size:
 *            ----- @"HR"   ------ NSNumber
 * dict_data  ----- @"RR"   ------ NSNumber
 *            ----- @"SPO2" ------ NSNumber
 *            ----- more
 */
@property (strong, nonatomic) NSDictionary *dict_sample_size;
/**
 * Format of dict_data:
 *            ----- @"HR"   ------ NSData
 * dict_data  ----- @"RR"   ------ NSData
 *            ----- @"SPO2" ------ NSData
 *            ----- more
 */
@property (strong, nonatomic) NSMutableDictionary *dict_data;

/**
 *  @brief Add result data into data object
 *  @param type The type of result data
 *  @param val The value of result data
 *  @return Error code, VSA_SUCCESS for pass @see VsaErrCode
 */
- (int)addResult:(SenResultDataType)type Value:(uint32_t)val;
@end

/** @} */
#endif /* ResultDataFrame_h */
