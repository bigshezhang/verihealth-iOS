//
//  ConnectionAdapter.h
//  CoreSDK
//
//  Created by Alex Lin on 2021/7/29.
//

#ifndef ConnectionAdapter_h
#define ConnectionAdapter_h

/** @addtogroup Connection
 *  Connection APIs, provides interfaces related to Bluetooth connection management.
 *  @ingroup CoreSDK
 *  @{
 */
#import <BaseFramework/BaseFramework.h>
#import "ConnectionDefine.h"

@class ConnectionAdapter;

/**
 * Delegate methods for ConnectionAdapter delegates
 */
@protocol ConnectionAdapterDelegate <NSObject>
@optional
/**
 * @brief Connection adapter delegate for current device update
 * @param device The new current device
 */
- (void)connectionCurrDeviceUpdate:(VsDevice *)device;

/**
 * @brief Connection adapter delegate for device connection state update
 * @param device The device which has state change
 * @param state The new state of this device
 * @param exist Whether the device is already connected
 */
- (void)connectionUpdate:(VsDevice *)device State:(BOOL)state Exist:(BOOL)exist;

/**
 * @brief Connection adapter delegate for device's ble connection failed
 * @param device The device which connection failed
 */
- (void)connectionFailed:(VsDevice *)device;
@end

@interface ConnectionAdapter : NSObject

@property (assign, nonatomic, readonly) BOOL bIsBackground;
@property (assign, nonatomic, readonly) TransferConnType connectionType;
@property (assign, nonatomic, readonly) BOOL isUpgrading;
@property (strong, nonatomic, readonly) VsDevice *currentDevice;
@property (strong, nonatomic, readonly) NSMutableArray *connectionArray;

/**
 * @brief Singleton of connection adapter
 */
+ (instancetype)sharedInstance;

/**
 * @brief Scan devices
 * @param is_manual Whether scan is started manually
 * @param block The block for completion & error
 *
 */
- (void)startScan:(BOOL)is_manual Block:(void (^)(NSError *error))block;

/**
 * @brief Start to re-scan if no device is connected
 */
- (void)checkToStartScan;

/**
 * @brief Stop Scanning for devices
 * @param is_manual Whether scan is stopped manually
 */
- (void)stopScan:(BOOL)is_manual;

/**
 * @brief Add device into connection list, duplicate device will not be added
 * @param device The device to be added
 */
- (void)add:(VsDevice *)device;

/**
 * @brief Remove device from connection list
 * @param device The device to be removed
 */
- (void)remove:(VsDevice *)device;

/**
 * @brief Connect the device
 * @param device The device to be connected
 */
- (void)connect:(VsDevice *)device;

/**
 * @brief Connect the device by name
 * @param name The name of device to be connected
 */
- (void)connectByName:(NSString *)name;

/**
 * @brief Disconnect device
 * @param device The device to be disconnected
 * @param is_manual Whether is disconnected manaully
 * @param unbind Whether to unbind as well
 */
- (void)disconnect:(VsDevice *)device Manual:(BOOL)is_manual Unbind:(BOOL)unbind;

/**
 * @brief Disconnect device
 * @param name The name of device to be disconnected
 * @param is_manual Whether is disconnected manaully
 * @param unbind Whether to unbind as well
 */
- (void)disconnectByName:(NSString *)name Manual:(BOOL)is_manual Unbind:(BOOL)unbind;

/**
 * @brief Set device to be active one
 * @param currentDevice The device to be actived
 */
- (void)setCurrentDevice:(VsDevice *)currentDevice;

/**
 * @brief Get the connected device by uuid
 * @param name The string of device name
 */
- (VsDevice *)getConnectedDevice:(NSString *)name;

/**
 * @brief Set OTA upgrading state
 * @param isUpgrading New OTA state
 */
- (void)setOtaUpgradingState:(BOOL)isUpgrading;

/**
 *  @brief Add delegate to connection adapter delegate
 *  @param connectDelegate Input delegate
 */
- (void)addDelegate:(id<ConnectionAdapterDelegate>)connectDelegate;

/**
 *  @brief Remove  connection adapter delegate
 *  @param connectDelegate Input delegate
 */
- (void)removeDelegate:(id<ConnectionAdapterDelegate>)connectDelegate;

/**
 *  @brief Remove all delegates
 */
- (void)removeAllDelegates;

- (NSMutableArray *)getDeepCopyInst:(NSMutableArray *)array;
@end
/** @} */
#endif /* ConnectionAdapter_h */
