//
//  LogManager.h
//  CoreSDK
//
//  Created by Kaili Lu on 2022/6/21.
//

#ifndef LogManager_h
#define LogManager_h

/** @addtogroup LogManager
 *  About log file for debug
 *  @ingroup CoreSDK
 *  @{
 */

#import <Foundation/Foundation.h>
#import <BaseFramework/VsDevice.h>

NS_ASSUME_NONNULL_BEGIN

@interface LogManager : NSObject

/**
 *  @brief Create shared instance for Log manager
 */
+ (instancetype)sharedInstance;

/**
 *  @brief Init log manager instance
 */
- (instancetype)init;

/**
 *  @brief Save debug log to file
 *  @param device Device instance
 *  @param message Content for log file
 */
- (void)saveLog:(VsDevice *)device Msg:(NSString *)message;

/**
 *  @brief NSData to hex string
 *  @param data NSData for convert
 *  @return Hex string
 */
- (NSString *)DataToHexStr:(NSData *)data;

/**
 *  @brief Alert type Enum to string
 *  @param type Alert type @see AlertTypeEnum
 *  @return Type string description
 */
- (NSString *)AlertType2String:(uint8_t)type;

@end

NS_ASSUME_NONNULL_END

#endif /* LogManager_h */
/** @} */
