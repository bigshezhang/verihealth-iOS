//
//  GlobalTransferDefine.h
//  CoreSDK
//
//  Created by Alex Lin on 2021/7/27.
//

#ifndef GlobalTransferDefine_h
#define GlobalTransferDefine_h

/** @defgroup TransferDefine TransferDefine
 *  Global definitions for TransferManager and Application.
 *  @ingroup Transfer
 */

/** @defgroup TransferParamsDefine TransferParamsDefine
 *  Type definitions of parameters in the data transferred by the TransferManager.
 *  @ingroup TransferDefine
 *  @{
 */

/**
 * @enum ConnectionState
 * @brief Connection state of device
 */
typedef NS_ENUM(uint8_t, ConnectionState) {
    STATE_DISCONNECTED = 0x0,
    STATE_CONNECTED,
    STATE_ATTACHED,
    STATE_DETACHED,
    STATE_SIG_WEAK
};

/**
 * @enum BLEStatus
 * @brief BleCentralManager's status
 */
typedef NS_ENUM(NSInteger, BLEStatus) {
    BLEStateError = -1,
    BLEStateUnsupported = 0,
    BLEStatePoweredOff,
    BLEStatePoweredOn,
    BLEStateUnauthorized,
};

static NSString *const kSettingTestSeverUrl = @"setting_remote_test_url"; // String

/** @} */
#endif /* GlobalTransferDefine_h */
