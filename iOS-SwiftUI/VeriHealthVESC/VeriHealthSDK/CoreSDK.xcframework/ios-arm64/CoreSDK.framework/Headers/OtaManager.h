//
//  OtaManager.h
//  CoreSDK
//
//  Created by Alex Lin on 2021/9/7.
//

#ifndef OtaManager_h
#define OtaManager_h

/** @defgroup OTA OTA
 *  OTA APIs, responsible for OTA management. It encapsulates interfaces such as firmware version check, download, and upgrade, and informs the upper layer of the progress and status of OTA through delegation.
 *  @ingroup CoreSDK
 */

/** @addtogroup OtaManager
 *  @ingroup OTA
 *  @{
 */
#import <BaseFramework/BaseFramework.h>
#import "GlobalOtaDefine.h"

NS_ASSUME_NONNULL_BEGIN
@class OtaManager;

/**
 * Delegate methods for OtaManager delegates
 */
@protocol OtaManagerDelegate <NSObject>
@optional

/**
 * @brief OTA manager delegate for progress updating
 * @param type The progress type @see OtaProgressType
 * @param progress OTA progress value, from 0 to 100
 * @param state State of progress
 * @note Currently only the image download progress is updated.
 */
- (void)otaUpdateProgress:(OtaProgressType)type
                 Progress:(uint8_t)progress
                    State:(OtaProgressState)state;

/**
 * @brief OTA manager delegate for state machine update
 * @param state The new state of state machine
 * @param progress OTA processing progress, from 0 to 100
 * @param error The error code for OtaSmError state
 */
- (void)otaUpdateState:(OtaStateMachineId)state
              Progress:(uint8_t)progress
                 Error:(OtaErrorCode)error;
@end

@interface OtaManager : NSObject

/**
 * @brief Create shared instance for OTA manager
 */
+ (instancetype)sharedInstance;

/**
 * @brief Init OTA manager instance
 */
- (instancetype)init;

/**
 * @brief Check the remote latest OTA info
 * @param otaUrlArray The ota's url array
 * @param complete The block for complete action
 */
- (void)checkRemoteOta:(NSArray<NSString *> *)otaUrlArray
              Complete:
                  (void (^)(NSError *_Nullable error, NSDictionary *_Nullable ota_dict))complete;

/**
 * @brief Download OTA image
 * @param remoteFile The path of file to be downloaded
 * @param localFile The path of local file to be stored
 * @return Error code, VSA_SUCCESS for pass @see VsaErrCode
 */
- (int)downloadImage:(NSString *)remoteFile DestLocation:(NSString *)localFile;

/**
 * @brief Download OTA image with block
 * @param remoteFile The path of file to be downloaded
 * @param name The the name of image
 * @param progress The block for updating progress
 * @param complete The block to nofity the complete
 * @return Error code, VSA_SUCCESS for pass @see VsaErrCode
 */
- (int)downloadImage:(NSString *)remoteFile
            FileName:(NSString *)name
            Progress:(void (^)(float percent))progress
            Complete:(void (^)(NSError *_Nullable error))complete;

/**
 * @brief Start OTA
 * @param file The path & name of image file
 * @return Error code, VSA_SUCCESS for pass @see VsaErrCode
 */
- (int)startOTA:(NSString *)file;

/**
 * @brief Stop/cancel the OTA progress
 * @param file The path & name of image file to be removed
 * @return Error code, VSA_SUCCESS for pass @see VsaErrCode
 */
- (int)stopOTA:(NSString *)file;

/**
 * @brief Add delegate to OTA manager
 * @param otaDelegate Input delegate
 */
- (void)addDelegate:(id<OtaManagerDelegate>)otaDelegate;

/**
 * @brief Remove OTA manager delegate
 * @param otaDelegate Input delegate
 */
- (void)removeDelegate:(id<OtaManagerDelegate>)otaDelegate;

/**
 * @brief Remove all delegates
 */
- (void)removeAllDelegates;
@end

NS_ASSUME_NONNULL_END
/** @} */
#endif /* OtaManager_h */
