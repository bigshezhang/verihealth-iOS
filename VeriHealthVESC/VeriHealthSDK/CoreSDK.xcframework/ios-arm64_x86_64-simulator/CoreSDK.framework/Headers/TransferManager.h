//
//  TransferManager.h
//  CoreSDK
//
//  Created by Alex Lin on 2021/7/23.
//

#ifndef TransferManager_h
#define TransferManager_h

/** @defgroup CoreSDK CoreSDK
 *  Based on frameworks, CoreSDK encapsulates Managers modules with different functions, including
 * connection management, data transmission, and warning notifications.
 */

/** @defgroup Transfer Transfer
 *  Transfer APIs, responsible for BLE data transfer management. It encapsulates the interface
 * related to device data sending and receiving.
 *  @ingroup CoreSDK
 */

/** @addtogroup TransferManager
 *  @ingroup Transfer
 *  @{
 */
#import <BaseFramework/BaseFramework.h>
#import <ProtocolFramework/ProtocolFramework.h>
#import <BleFramework/BleFramework.h>
#import <BleFramework/BleCentralManager.h>
#import "GlobalTransferDefine.h"

NS_ASSUME_NONNULL_BEGIN
@class TransferManager;

/**
 * Delegate methods for TransferManager delegates
 */
@protocol TransferManagerDelegate <NSObject>
@optional
/**
 * @brief Transfer manager delegate for sensor raw data
 *
 * @param transManager Transfer manager instance
 * @param device The device of data source
 * @param frame Frame of sensor raw data @see RawDataFrame
 */
- (void)transReceiveRawData:(TransferManager *)transManager
                     Device:(id)device
                  dataFrame:(RawDataFrame *)frame;

/**
 * @brief Transfer manager  delegate for result data
 *
 * @param transManager Transfer manager instance
 * @param device The device of data source
 * @param frame Frame of result data @see ResultDataFrame
 */
- (void)transReceiveResultData:(TransferManager *)transManager
                        Device:(id)device
                     dataFrame:(ResultDataFrame *)frame;

/**
 * @brief Transfer manager  delegate for vs message
 *
 * @param transManager Transfer manager instance
 * @param device The device of data source
 * @param frame Frame of vs message @see VsMessageFrame
 */
- (void)transReceiveMessage:(TransferManager *)transManager
                     Device:(id)device
                  dataFrame:(VsMessageFrame *)frame;

/**
 * @brief Transfer manager  delegate for vs message payload
 *
 * @param transManager Transfer manager instance
 * @param device The device of data source
 * @param frame Frame of vs message payload @see PayloadFrame
 */
- (void)transReceiveMessagePayload:(TransferManager *)transManager
                            Device:(id)device
                         dataFrame:(PayloadFrame *)frame;

/**
 * @brief Transfer manager  delegate for custom message
 *
 * @param transManager Transfer manager instance
 * @param device The device of data source
 * @param frame Frame of custom message @see PayloadFrame
 */
- (void)transReceiveCustomMessage:(TransferManager *)transManager
                           Device:(id)device
                        dataFrame:(PayloadFrame *)frame;

/**
 * @brief Transfer manager  delegate for connection
 *
 * @param transManager Transfer manager instance
 * @param device The device whose connection status is updated
 * @param state New connection state
 */
- (void)transUpdateConnectionState:(TransferManager *)transManager
                            Device:(id)device
                          newState:(BOOL)state;

/**
 * @brief Transfer manager delegate for ble connection failed
 *
 * @param transManager Transfer manager instance
 * @param device The device that failed to connect
 */
- (void)transConnectionFailed:(TransferManager *)transManager Device:(id)device;

/**
 * @brief Transfer manager  delegate for alerting
 *
 * @param device The device of data source
 * @param type The type of alerting @see AlertTypeEnum
 * @param param The extra param for alerting
 */
- (void)transReceiveAlerting:(id)device Type:(uint8_t)type Param:(uint32_t)param;

/**
 * @brief Transfer manager  delegate for system messages
 *
 * @param device The device of data source
 * @param msg The message id of system messages
 * @param param The param of the message
 */
- (void)transReceiveSystemMsg:(id)device MsgId:(uint16_t)msg Param:(uint32_t)param;

/**
 * @brief Transfer manager  delegate for system messages
 *
 * @param device The device of data source
 * @param msg The message id of debug messages
 * @param param The param of the debug message
 */
- (void)transReceiveDebugMsg:(id)device MsgId:(uint16_t)msg Param:(NSData *)param;

/**
 * @brief Transfer manager  delegate to show debug print messages
 *
 * @param device The device of data source
 * @param isError Indicate it's an error message
 * @param onTop Indicate the position for message
 * @param info The message id of debug messages
 */
- (void)transShowDebugInfo:(id)device Error:(BOOL)isError Pos:(BOOL)onTop Message:(NSString *)info;

/**
 * @brief Transfer manager  delegate for notify ready for new tranmission
 * @param device the device object
 */
- (void)transIsReady:(id)device;

/**
 * @brief Transfer manager  delegate for receiving a device
 * @param device Scanned device
 */
- (void)transReceiveDevice:(VsDevice *)device;

/**
 * @brief Transfer manager  delegate for RSSI
 *
 * @param transManager Transfer manager instance
 * @param device The device of data source
 * @param rssi RSSI value of device
 */
- (void)transUpdateRSSI:(TransferManager *)transManager
                 Device:(VsDevice *)device
                   RSSI:(NSNumber *)rssi;

/**
 * @brief Transfer manager delegate for device info update
 * @param device The device of data source
 * @param item The item which was updated @see DevInfoItemEnum
 */
- (void)transReceiveDeviceInfo:(VsDevice *)device Item:(DevInfoItemEnum)item;

/**
 * @brief Transfer manager delegate for BleCentralManager's status changed
 * @param state New BLE state @see BLEStatus
 */
- (void)transUpdateBLEState:(BLEStatus)state;

@end

@interface TransferManager : NSObject
@property (strong, nonatomic, readonly) NSHashTable *delegates;
@property (strong, nonatomic, readonly) NSLock *delegateLock;
@property (strong, nonatomic, readonly) dispatch_queue_t transQueue;
@property (strong, nonatomic, readonly) VsProtocol *protoInst;
@property (strong, nonatomic, readonly) BleCentralManager *bleCentralManagerInst;

/**
 *  @brief Create shared instance for Transfer manager
 */
+ (instancetype)sharedInstance;

/**
 *  @brief Init transfer manager instance
 */
- (instancetype)init;

/**
 * @brief Scan devices
 */
- (void)scanDevicesWithBlock:(void (^)(NSError *_Nullable))block;

/**
 * @brief Stop Scanning for devices
 * @return Error code
 * @see VsaErrCode
 */
- (int)stopScan;

/**
 * @brief Get device instance by name
 * @param name Device name
 * @return The instance of found device
 */
- (VsDevice *_Nullable)getScanedDeviceByName:(NSString *)name;

/**
 * @brief Connect to a device
 * @param device Device instance
 * @return Error code
 * @see VsaErrCode
 */
- (int)connectDevice:(VsDevice *)device;

/**
 * @brief Disconnect to a device
 * @param device Device instance
 * @return Error code
 * @see VsaErrCode
 */
- (int)disConnectDevice:(VsDevice *)device;

/**
 *  @brief Recieve packet from device
 *  @param device Device instance
 *  @param packet The received packet
 *  @return Error code
 *  @see VsaErrCode
 */
- (int)receivePacket:(VsDevice *)device Packet:(NSData *)packet;

/**
 *  @brief Add delegate to transfer manager
 *  @param transDelegate Input delegate
 */
- (void)addDelegate:(id<TransferManagerDelegate>)transDelegate;

/**
 *  @brief Remove transfer manager delegate
 *  @param transDelegate Input delegate
 */
- (void)removeDelegate:(id<TransferManagerDelegate>)transDelegate;

/**
 *  @brief Remove all delegates
 */
- (void)removeAllDelegates;

/**
 *  @brief Get BLE centeral manager state
 *  @return BLE centeral manager state
 *  @see BLEStatus
 */
- (BLEStatus)getBleCentralManagerState;
@end

NS_ASSUME_NONNULL_END
/** @} */
#endif /* TransferManager_h */
