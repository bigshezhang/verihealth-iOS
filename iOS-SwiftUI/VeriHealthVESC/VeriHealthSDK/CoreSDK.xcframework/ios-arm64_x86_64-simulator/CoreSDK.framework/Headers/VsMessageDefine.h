//
//  VsMessageDefine.h
//  CoreSDK
//
//  Created by Alex Lin on 2021/7/27.
//

#ifndef VsMessageDefine_h
#define VsMessageDefine_h

/** @defgroup GlobalDefine GlobalDefine
 *  Global definitions for VeriHealthSDK and App.
 *  @ingroup CoreSDK
 */

/** @addtogroup VsMessageDefine
 *  Definitions of BLE messages' id.
 *  @ingroup GlobalDefine
 *  @{
 */

#define BT_DEV_NAME_LENGTH 16 /**< BT device name length */
#define BT_DEV_MAC_LENGTH 6 /**< BT device MAC address length */

/* SDK internal messages definition */
/*
 *System Messages
 */
#define VS_ATTACH_STATE_MSG 0x0001 /**< Connect state */
#define VS_SENSOR_DATA_MSG 0x0002 /**< Sensor messages */
#define VS_SYNC_TIME_MSG 0x0003 /**< Sync time with UTC format */
#define VS_ALERTING_MSG 0x0004 /**< Alerting message */

/* OTA messages, it's over a separate service, but should not use same ID */
#define VS_OTA_START_MSG 0x0010 /**< OTA start message */
#define VS_OTA_FLUSH_MSG 0x0011 /**< OTA flush message */
#define VS_OTA_FINISH_MSG 0x0012 /**< OTA finish message */
#define VS_OTA_REBOOT_MSG 0x0013 /**< OTA reboot message */
#define VS_OTA_CANCEL_MSG 0x0014 /**< OTA cancel message */

/*
 *BLE messages
 */
#define VS_BLE_BIND_CTRL 0x0080 /**< 0 for unbind, 1 for bind */
#define VS_BLE_NAME_MAC 0x0081 /**< BLE config name and MAC message */

/*
 * Secure messages
 */
#define VS_SDK_KEY_MSG 0x300 /**< Key message for SDK */

/*
 *Auto test messages
 */
#define VS_TEST_GEN_RESULT 0x400 /**< Generate result packet */
#define VS_TEST_GEN_RAW 0x401 /**< Generate raw packet */
#define VS_TEST_DEV_READY_MSG 0x402 /**< Device ready for test */
#define VS_TEST_RESULT_MSG 0x403 /**< Test result message */
#define VS_TEST_FINISH_MSG 0x404 /**< Test finish  message */
#define VS_TEST_SEN_SQI_MSG 0x405 /**< Sensor signal quality index test */

/*
 * Debug messages
 */
#define VS_DEBUG_MONITOR_MSG 0x500 /**< Debug monitor */
#define VS_DEBUG_INFO_MSG 0x501 /**< Debug info */

/**
 * SDK messages end
 */
#define VS_SDK_MSG_END (0x1000)

/**
 * Custom messages start
 */
#define VS_CUSTOM_MSG_START 0x2000

/*
 *VS_SYNC_TIME_MSG param length
 */
#define VS_TIME_STAMP_LENGTH 6

/** @} */

/**
 * @enum VsMsgFlags
 * @brief Enum of vs message header flag bit
 */
typedef enum VsMsgFlags {
    FLAG_BIT_REQ_ACK = 0, /**< Require ACK flag */
    FLAG_BIT_GET, /**< Flag of a get message */
    FLAG_BIT_ENCRYPTED, /**< Encrypted flag */
    FLAG_BIT_ACK, /**< ACK message flag */
} VsMsgFlags;

#endif /* VsMessageDefine_h */
