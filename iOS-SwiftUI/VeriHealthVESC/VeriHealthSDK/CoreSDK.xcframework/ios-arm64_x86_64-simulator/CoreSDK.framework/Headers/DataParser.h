//
//  DataParser.h
//  CoreSDK
//
//  Created by Kaili Lu on 2022/5/7.
//

#ifndef DataParser_h
#define DataParser_h

/** @addtogroup DataParser
 *  @ingroup Data
 *  @{
 */

#import <BaseFramework/BaseFramework.h>

/**
 * Delegate methods for DataParser delegates
 */
@protocol DataParserDelegate <NSObject>
@optional

/**
 * @brief Update the statistical data
 * @param type The data type
 * @param valueDic The data dictionary after resultData paser
 */
- (void)DataParserResult:(SenResultDataType)type valueDic:(NSMutableDictionary *)valueDic;

@end

@interface DataParser : NSObject

/**
 *  @brief Create shared instance for DataParser
 */
+ (instancetype)sharedInstance;

/**
 *  @brief Init DataParser instance
 */
- (instancetype)init;

/**
 *  @brief Add delegate to DataParser
 *  @param dataDelegate Input delegate
 */
- (void)addDelegate:(id<DataParserDelegate>)dataDelegate;

/**
 *  @brief Remove data parser delegate
 *  @param dataDelegate Input delegate
 */
- (void)removeDelegate:(id<DataParserDelegate>)dataDelegate;

/**
 *  @brief Remove all delegates
 */
- (void)removeAllDelegates;

@end
/** @} */
#endif /* DataParser_h */
