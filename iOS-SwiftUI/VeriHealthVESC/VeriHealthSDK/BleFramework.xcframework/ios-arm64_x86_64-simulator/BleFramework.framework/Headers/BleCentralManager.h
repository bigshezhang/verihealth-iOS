//
//  BleCentralManager.h
//  BleFramework
//
//  Created by Delia Chen on 2021/7/30.
//

#ifndef BleCentralManager_h
#define BleCentralManager_h

/** @defgroup BleFramework BleFramework
 *  BleFramework provides interfaces such as BLE device scanning, connection, reading and writing of characteristics. It passes Bluetooth packets, connection status, etc. to the upper layer through delegation.
 */

/** @addtogroup BleCentralManager
 *  @ingroup BleFramework
 *  @{
 */

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <BaseFramework/BaseFramework.h>
#import "BleFrameworkDefine.h"

NS_ASSUME_NONNULL_BEGIN
@class BleCentralManager;

@protocol BleCentralManagerDelegate <NSObject>
@optional

/**
 * @brief BleCentralManager delegate for bluetooth state
 * @param state The new updated state @see CBManagerState
 */
- (void)bleFwUpdateBLEState:(CBManagerState)state;
/**
 * @brief BleCentralManager delegate for sensor data
 * @param device BLE device
 * @param data Sensor data
 */
- (void)bleFwRecvPrivatePacket:(VsDevice *)device deviceData:(NSData *)data;

/**
 * @brief BleCentralManager delegate for device info update
 * @param device BLE device
 * @param item The item which was updated
 */
- (void)bleFwRecvDeviceInfo:(VsDevice *)device Item:(DevInfoItemEnum)item;

/**
 * @brief BleCentralManager delegate for TransferManager
 * @param thisDevice BLE device
 * @param isConnected Device's connection status is updated
 */
- (void)bleFwUpdateConnection:(VsDevice *)thisDevice isConnected:(BOOL)isConnected;

/**
 * @brief BleCentralManager delegate for TransferManager
 * @param thisDevice BLE device
 */
- (void)bleFwConnectionFailed:(VsDevice *)thisDevice;

/**
 * @brief BleCentralManager delegate for writewithoutresponse transfer ready
 * @param thisDevice BLE device
 */
- (void)bleFwTransferReady:(VsDevice *)thisDevice;

/**
 * @brief BleCentralManager delegate for found device dictionary
 * @param bleCentralManager BleCentralManager instance
 * @param device The scanned device
 */
- (void)bleFwScannedDeviceDict:(BleCentralManager *)bleCentralManager Scanned:(VsDevice *)device;

/**
 * @brief BleCentralManager delegate for found device dictionary
 * @param thisDevice BLE device
 * @param rssi RSSI value of thisDevice
 */
- (void)bleFwUpdateRSSI:(VsDevice *)thisDevice RSSI:(NSNumber *)rssi;
@end

@interface BleCentralManager : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate>
@property (strong, nonatomic) CBCentralManager *centralManager;
@property (nonatomic, weak) id<BleCentralManagerDelegate> delegate;
@property (nonatomic, strong, readonly) NSMutableDictionary *scannedDeviceDict;
@property (nonatomic, strong, readonly) NSMutableDictionary *connectedDeviceDict;
@property (strong, nonatomic) NSMutableDictionary *rssiTimerDict;
@property (strong, nonatomic) NSString *defDevice;
@property (strong, nonatomic) NSMutableArray *knownPeripherals;
@property (nonatomic) BOOL restoreFlag;
+ (instancetype)sharedInstance;
/**
 * @brief Scan all nearby periperals
 */
- (void)scanPeriperalsWithBlock:(void (^_Nonnull)(NSError *_Nullable error))block;

/**
 * @brief Stop scan periperals
 */
- (void)stopScanPeriperals;
/**
 * @brief Connect to a peripheral manually
 * @param peripheral BLE peripheral
 */
- (void)connectToPeripheral:(CBPeripheral *)peripheral;
/**
 * @brief Cancel connect to a peripheral
 * @param peripheral BLE peripheral
 */
- (void)cancelConnectWithPeripheral:(CBPeripheral *)peripheral;
/**
 * @brief Write value for characteristic
 * @param device The device to write
 * @param character The character to write
 * @param data The value to be written
 * @param mode The BLE write mode @see BleWriteMode
 */
- (void)writeValueForCharacteristic:(VsDevice *)device
                          Character:(id)character
                               Data:(NSData *)data
                               Mode:(BleWriteMode)mode;
@end
NS_ASSUME_NONNULL_END
/** @} */
#endif
