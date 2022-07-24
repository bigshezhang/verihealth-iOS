//
//  VsDevice.h
//  BaseFramework
//
//  Created by Alex Lin on 2021/8/10.
//

#ifndef VsDevice_h
#define VsDevice_h

/** @addtogroup VsDevice
 *  Definition of VeriSilicon device.
 *  @ingroup BaseFramework
 *  @{
 */

#import <BaseFramework/VsDeviceDefine.h>

/**
 * @brief VeriSilicon device
 */
@interface VsDevice : NSObject

@property (nonatomic) VsDeviceType type; /**< Device type */
@property (nonatomic) BOOL connected; /**< Connection status */
@property (nonatomic) uint8_t battery_level; /**< Battery level */
@property (strong, nonatomic) NSNumber *rssi; /**< RSSI value of BLE */
@property (strong, nonatomic) id peripheral; /**< Object of peripheral  */
@property (strong, nonatomic) NSString *name; /**< Name of device */
@property (strong, nonatomic) NSString *manufacturer; /**< Manufacturer name */
@property (strong, nonatomic) NSString *model_no; /**< Model number of product */
@property (strong, nonatomic) NSString *fw_version; /**< Firmware version */
@property (strong, nonatomic) NSString *hw_version; /**< Hardwawre version */
@property (strong, nonatomic) NSString *latest_version; /**< Latest firmware ver on OTA server */
@property (strong, nonatomic) NSString *serial_no; /**< Serial number */
@property (strong, nonatomic) NSUUID *uuid; /**< UUID object */
@property (strong, nonatomic) id vs_character; /**< Object of VS character */
@property (strong, nonatomic) id ota_character; /**< Object of OTA character */
@property (strong, nonatomic) NSString *address; /**< MAC address of device */
@property (strong, nonatomic) NSString *ota_desc; /**< OTA description of latest firmware ver */
@property (nonatomic) VsProductEnum product_id; /**< product ID */
@property (strong, nonatomic) NSMutableArray *battery_pool;

/**
 *  @brief Check whether new firmware version is available
 *  @return YES for available
 */
- (BOOL)isNewFwAvailable;

@end

/** @} */
#endif /* VsDevice_h */
