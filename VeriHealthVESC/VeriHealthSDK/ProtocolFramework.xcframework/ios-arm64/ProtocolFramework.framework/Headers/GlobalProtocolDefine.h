//
//  GlobalProtocolDefine.h
//  ProtocolFramework
//
//  Created by Alex Lin on 2021/7/22.
//

#ifndef GlobalProtocolDefine_h
#define GlobalProtocolDefine_h

/** @addtogroup ProtocolDefine
 *  Global definitions for Protocol and other frameworks.
 *  @ingroup ProtocolFramework
 *  @{
 */

/**
 * @enum SensorType
 * @brief Sensor types
 * @note The data type of SensorType should be uint32_t to sync with device
 */
typedef NS_ENUM(uint8_t, SensorType) {
    SEN_TYPE_NONE = 0, /**< None */
    SEN_TYPE_PPG, /**< PPG sensor */
    SEN_TYPE_ECG, /**< ECG sensor */
    SEN_TYPE_IMU, /**< IMU sensor */
    SEN_TYPE_TMP, /**< Temperature sensor */
    SEN_TYPE_MAX
};

/** @} */
#endif /* GlobalProtocolDefine_h */
