//
//  AlertTypeDefine.h
//  CoreSDK
//
//  Created by Delia Chen on 2022/5/13.
//

#ifndef AlertTypeDefine_h
#define AlertTypeDefine_h

/** @addtogroup AlertDefine
 *  Global definitions for AlertManager and Application.
 *  @ingroup Alert
 *  @{
 */

/**
 * @enum AlertTypeEnum
 * @brief Alerting type define
 */
typedef NS_ENUM(uint8_t, AlertTypeEnum) {
    ALERT_TYPE_CLEAR, /**< clear the last alerting */
    ALERT_TYPE_FALL, /**< fall detected */
    ALERT_TYPE_SEDENTARY, /**< sedentary */
    ALERT_TYPE_AFib, /**< atrial fibrillation */
    ALERT_TYPE_WEAR, /**< wear detected */
    ALERT_TYPE_MAX, /**< MAX */
};

/** @} */
#endif /* AlertTypeDefine_h */
