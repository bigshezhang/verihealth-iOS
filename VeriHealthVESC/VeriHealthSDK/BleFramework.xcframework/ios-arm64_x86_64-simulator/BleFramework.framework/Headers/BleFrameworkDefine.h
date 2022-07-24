//
//  BleFrameworkDefine.h
//  BleFramework
//
//  Created by Delia Chen on 2021/7/30.
//

#ifndef BleFrameworkDefine_h
#define BleFrameworkDefine_h

/** @addtogroup BleDefine
 *  Global definitions for BLE and other frameworks.
 *  @ingroup BleFramework
 *  @{
 */

/**
 * @enum BleWriteMode
 * @brief Enum of BLE write mode
 */
typedef NS_ENUM(NSInteger, BleWriteMode) {
    BleWriteWithResponse = 0,
    BleWriteWithoutResponse,
};

/** @} */
#endif /* BleFrameworkDefine_h */
