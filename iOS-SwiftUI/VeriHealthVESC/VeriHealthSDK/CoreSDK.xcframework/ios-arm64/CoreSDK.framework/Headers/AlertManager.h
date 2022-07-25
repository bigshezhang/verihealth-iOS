//
//  AlertManager.h
//  CoreSDK
//
//  Created by Alex Lin on 2021/11/21.
//

#ifndef AlertManager_h
#define AlertManager_h

/** @defgroup Alert Alert
 *  Alert APIs, responsible for alert management. It defines the alert-related delegate protocol and notifies the delegate implementer.
 *  @ingroup CoreSDK
 */

/** @addtogroup AlertManager
 *  @ingroup Alert
 *  @{
 */

#import <BaseFramework/BaseFramework.h>

NS_ASSUME_NONNULL_BEGIN
@class AlertManager;
/**
 * Delegate methods for AlertManager delegates
 */
@protocol AlertManagerDelegate <NSObject>
@optional
/**
 * @brief Alert manager delegate for wear detection
 *
 * @param device The device instance
 * @param state State of wear
 */
- (void)alertWearUpdate:(VsDevice *)device State:(BOOL)state;
@end

@interface AlertManager : NSObject
@property (nonatomic, readonly) BOOL wear_state; // YES for Wore, NO for took off

/**
 *  @brief Create shared instance for Alert manager
 */
+ (instancetype)sharedInstance;

/**
 *  @brief Init Alert manager instance
 */
- (instancetype)init;

/**
 *  @brief Add delegate to alert manager
 *  @param alertDelegate Input delegate
 */
- (void)addDelegate:(id<AlertManagerDelegate>)alertDelegate;

/**
 *  @brief Remove alert manager delegate
 *  @param alertDelegate Input delegate
 */
- (void)removeDelegate:(id<AlertManagerDelegate>)alertDelegate;

/**
 *  @brief Remove all delegates
 */
- (void)removeAllDelegates;
@end
NS_ASSUME_NONNULL_END
/** @} */
#endif /* AlertManager_h */
