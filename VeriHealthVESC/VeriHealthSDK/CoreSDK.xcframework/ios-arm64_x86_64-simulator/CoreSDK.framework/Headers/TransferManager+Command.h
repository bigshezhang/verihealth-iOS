//
//  TransferManager+Command.h
//  CoreSDK
//
//  Created by Alex Lin on 2021/8/25.
//

#ifndef TransferManager_Command_h
#define TransferManager_Command_h

/** @addtogroup TransferManager
 *  @ingroup Transfer
 *  @{
 */

#import "TransferManager.h"

NS_ASSUME_NONNULL_BEGIN
@interface TransferManager (Command)

/**
 *  @brief Send attach/disattach status command
 *  @param device Device instance
 *  @param state The new state @see ConnectionState
 *  @return Error code @see VsaErrCode
 */
- (int)sendAttachState:(VsDevice *)device State:(ConnectionState)state;

/**
 *  @brief Send BLE bind/unbind command
 *  @param device Device instance
 *  @param bind Bind control, 0 for unbind, 1 for bind
 *  @return Error code @see VsaErrCode
 */
- (int)sendBindCtrl:(VsDevice *)device Bind:(bool)bind;

/**
 *  @brief Send current time stamp in ms to device
 *  @param device Device instance
 *  @return Current timestamp
 */
- (uint64_t)sendTimeStamp:(VsDevice *)device;

/**
 *  @brief Send result test request  to device
 *  @param device Device instance
 *  @param type  Result type  @see SenResultDataType
 *  @param val Value of specified result type
 *  @return Error code @see VsaErrCode
 */
- (int)sendTestResultRequest:(VsDevice *)device Type:(SenResultDataType)type Value:(uint32_t)val;

/**
 *  @brief Send get BLE name mac request  to device
 *  @param device Device instance
 *  @return Error code @see VsaErrCode
 */
- (int)sendGetNameMACRequest:(VsDevice *)device;

/**
 *  @brief Send set BLE name mac to device
 *  @param device Device instance
 *  @param name set device name
 *  @param mac set mac address
 *  @return Error code @see VsaErrCode
 */
- (int)sendSetNameMAC:(VsDevice *)device Name:(NSString *)name MAC:(NSData *)mac;

/**
 *  @brief Send common message to device
 *  @param device Device instance
 *  @param msg_id The message id (op_code)
 *  @param data The custom data of applicaton
 *  @return Error code @see VsaErrCode
 */
- (int)sendCommonMessage:(VsDevice *)device MsgId:(uint16_t)msg_id Data:(nullable NSData *)data;

/**
 *  @brief Transfer OTA firmware data to device
 *  @param device Device instance
 *  @param offset The offset of firmware data in the image
 *  @param data Data of firmware
 *  @return Error code @see VsaErrCode
 */
- (int)sendOtaDataPacket:(VsDevice *)device Offset:(uint32_t)offset Data:(NSData *)data;

/**
 *  @brief Send OTA start command to device
 *  @param device Device instance
 *  @param version Version of new firmware
 *  @param length Total length of new firmware image
 *  @return Error code @see VsaErrCode
 */
- (int)sendOtaStart:(VsDevice *)device Verison:(uint16_t)version Length:(uint32_t)length;

/**
 *  @brief Send OTA finish command to device
 *  @param device Device instance
 *  @return Error code @see VsaErrCode
 */
- (int)sendOtaFinish:(VsDevice *)device;

@end

NS_ASSUME_NONNULL_END
/** @} */
#endif /* TransferManager_Command_h */
