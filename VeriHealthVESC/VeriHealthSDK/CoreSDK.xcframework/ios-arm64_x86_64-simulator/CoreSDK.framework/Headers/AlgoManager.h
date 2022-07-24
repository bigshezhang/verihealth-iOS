//
//  AlgoManager.h
//  CoreSDK
//
//  Created by Alex Lin on 2021/7/27.
//

#ifndef AlgoManager_h
#define AlgoManager_h

/** @addtogroup Algorithm
 *  Algorithm APIs, responsible for parsing sensor raw data and passing the processing results to the upper layer through delegation.
 *  @ingroup CoreSDK
 *  @{
 */

#import <BaseFramework/BaseFramework.h>
#import <AlgorithmFramework/AlgorithmFramework.h>

NS_ASSUME_NONNULL_BEGIN
@class AlgoManager;

/**
 * Delegate methods for AlgoManager delegates
 */
@protocol AlgoManagerDelegate <NSObject>
@optional
/**
 * @brief Algo manager delegate for processed data
 *
 * @param AlgoManager Algo manager instance
 * @param device The device instance
 * @param frame Frame of processed data
 */
- (void)algoRecvProcessedData:(AlgoManager *)AlgoManager
                       Device:(id)device
                    dataFrame:(RawDataFrame *)frame;

/**
 * @brief Algo manager delegate for processed result data
 *
 * @param AlgoManager Algo manager instance
 * @param device The device instance
 * @param frame Frame of processed result data
 */
- (void)algoRecvResultData:(AlgoManager *)AlgoManager
                    Device:(id)device
                 dataFrame:(ResultDataFrame *)frame;
@end

@interface AlgoManager : NSObject

/**
 *  @brief Create shared instance for Algo manager
 */
+ (instancetype)sharedInstance;

/**
 *  @brief Init Algo manager instance
 */
- (instancetype)init;

/**
 *  @brief Process raw data by algorithm
 *  @param device The device instance
 *  @param frame Input raw data need to be processed
 *  @return Error code @see VsaErrCode
 */
- (int)processRawData:(id)device Frame:(RawDataFrame *)frame;

/**
 *  @brief Add delegate to AlgoManager
 *  @param algoDelegate Input delegate
 */
- (void)addDelegate:(id<AlgoManagerDelegate>)algoDelegate;

/**
 *  @brief Remove algo manager delegate
 *  @param algoDelegate Input delegate
 */
- (void)removeDelegate:(id<AlgoManagerDelegate>)algoDelegate;

/**
 *  @brief Remove all delegates
 */
- (void)removeAllDelegates;

@end

NS_ASSUME_NONNULL_END

/** @} */
#endif /* AlgoManager_h */
