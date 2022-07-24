//
//  AlgoProcess.h
//  AlgorithmFramework
//
//  Created by Alex Lin on 2021/8/4.
//

#ifndef AlgoProcess_h
#define AlgoProcess_h

#import <BaseFramework/BaseFramework.h>

NS_ASSUME_NONNULL_BEGIN
@class AlgoProcess;

@interface AlgoProcess : NSObject

/**
 *  @brief Init algoProcess instance
 */
- (instancetype)init;

/**
 *  @brief Process raw data by algorithm
 *  @param frame input raw data need to be processed
 */
- (id)processRawData:(RawDataFrame *)frame;
@end
NS_ASSUME_NONNULL_END
#endif /* AlgoProcess_h */
