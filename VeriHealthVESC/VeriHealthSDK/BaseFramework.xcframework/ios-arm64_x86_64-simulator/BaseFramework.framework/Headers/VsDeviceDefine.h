//
//  VsDeviceDefine.h
//  BaseFramework
//
//  Created by Alex Lin on 2021/8/2.
//

#ifndef VsDeviceDefine_h
#define VsDeviceDefine_h

/** @addtogroup VsDeviceDefine
 *  @ingroup BaseDefine
 *  @{
 */

/**
 * @enum VsDeviceType
 * @brief Device Type
 */
typedef NS_ENUM(uint8_t, VsDeviceType) {
    DeviceTypeBLE, /**< BLE device */
    DeviceTypeWiFi, /**< WiFi device */
    DeviceTypeNBIoT, /**< NBIoT device */
    DeviceTypeUSB /**< USB device */
};

/**
 * @enum DevInfoItemEnum
 * @brief Device information items
 */
typedef NS_ENUM(NSInteger, DevInfoItemEnum) {
    InfoItemUnknown = 0, /**< Undefined info */
    InfoItemBattery, /**< Battery level info */
    InfoItemFwVersion, /**< Firmware version */
    InfoItemHwVersion, /**< Hardware version */
    InfoItemManufacturer, /**< Manufacturer info */
    InfoItemSerialNum, /**< Product serial number */
    InfoItemModelNum /**< Product model number */
};

/**
 * @enum VsProductEnum
 * @brief Different product forms enum
 */
typedef NS_ENUM(uint8_t, VsProductEnum) {
    ProductIdUnknown = 0, /**< Unknown product */
    ProductIdVHWrist, /**< VeriHealth Wristband*/
    ProductIdVHPatch, /**< VeriHealth Patch */
    ProductIdVHDisplay, /**< VeriHealth Display */
    ProductIdRigel, /**< Rigel EVB */
    ProductIdCocopalm, /**< Cocopalm */
    ProductIdMax /**< Max number of supported products */
};

/** @} */

#define POOL_SIZE (5)
static NSString *const kVHModelName = @"VeriHealth";
static NSString *const kPrefixNameVH = @"VH-";
static NSString *const kPrefixNameVHW = @"VHW-";
static NSString *const kPrefixNameVHP = @"VHP-";
static NSString *const kPrefixNameVHD = @"VHD-";
static NSString *const kRigelName = @"Rigel";
static NSString *const kCocopalmName = @"Cocopalm";
static NSString *const kPrefixNameVHC = @"VHC-";

#endif /* VsDeviceDefine_h */
