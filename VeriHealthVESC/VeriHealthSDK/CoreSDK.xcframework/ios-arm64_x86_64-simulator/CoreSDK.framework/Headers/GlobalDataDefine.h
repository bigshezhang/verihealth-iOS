//
//  GlobalDataDefine.h
//  CoreSDK
//
//  Created by Alex Lin on 2021/10/28.
//

#ifndef GlobalDataDefine_h
#define GlobalDataDefine_h

/** @defgroup DataDefine DataDefine
 *  Global definitions for DataManager and Application.
 *  @ingroup Data
 */

/** @addtogroup DataConstraints
 *  Data constraints of vital sign value.
 *  @ingroup DataDefine
 *  @{
 */

/** @def TIMESTAMP_MIN
 *  @brief 2021/1/1/00:00
 */
#define TIMESTAMP_MIN 1609430400
#define HR_MAX 180
#define HR_MIN 40
/** @def BODY_TMP_MIN
 *  @brief degree * 100
 */
#define BODY_TMP_MIN 2500
/** @def HRV_MAX
 *  @brief in ms
 */
#define HRV_MAX 1000
/** @} */


/** @addtogroup DataType
 *  DB Data Type.
 *  @ingroup DataDefine
 *  @{
 */

/**
 * @enum DBDataType
 * @brief The type of data stored in the database
 */
typedef enum DBDataType {
    DATA_TYPE_NONE = 0, /**< None */
    DATA_TYPE_USER, /**< User */
    DATA_TYPE_HR, /**< Heart rate */
    DATA_TYPE_RR, /**< Respiratory rate */
    DATA_TYPE_SPO2, /**< Oxygen saturation */
    DATA_TYPE_TMP, /**< Temperature */
    DATA_TYPE_STEP, /**< Step counter */
    DATA_TYPE_BP, /**< Blood pressure */
    DATA_TYPE_GLUCOSE, /**< Glucose level */
    DATA_TYPE_SQ, /**< Sleep quality */
    DATA_TYPE_PAI, /**< Physical Activity Index */
    DATA_TYPE_HRMAX, /**< HR max */
    DATA_TYPE_HRREST, /**< HR rest */
    DATA_TYPE_CC, /**< Calories consumption */
    DATA_TYPE_BMR, /**< Basal metabolic rate result */
    DATA_TYPE_HRV, /**< Heart Rate Variablity */
    DATA_TYPE_FALL, /**< Fall detected */
    DATA_TYPE_SEDENTARY, /**< Sedentary */
    DATA_TYPE_AFIB, /**< AFib */
    DATA_TYPE_ECG, /**< ECG */
    DATA_TYPE_ALERT_FALL, /**< Fall alert */
    DATA_TYPE_ALERT_SED, /**< Sedentary alert */
    DATA_TYPE_ALERT_AFIB, /**< AFib alert */
    DATA_TYPE_MAX
} DBDataType;

/**
 * @enum AFResultDef
 * @brief AFib results define
 */
typedef NS_ENUM(uint8_t, AFResultDef) {
    AF_RESULT_INVALID = 0,
    AF_RESULT_SINUS = 1,
    AF_RESULT_AF = 2,
    AF_RESULT_ABNORMAL = 3
};
/** @} */
#endif /* GlobalDataDefine_h */
