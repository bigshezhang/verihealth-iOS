//
//  ResultDefine.h
//  BaseFramework
//
//  Created by Alex Lin on 2021/8/13.
//

#ifndef ResultDefine_h
#define ResultDefine_h

/** @defgroup BaseFramework BaseFramework
 *  BaseFramework provides basic definitions and utility functions for other frameworks.
 */

/** @defgroup BaseDefine BaseDefine
 *  Global definitions for Base or other frameworks.
 *  @ingroup BaseFramework
 */

/** @addtogroup BaseDataTypeDefine
 *  @ingroup BaseDefine
 *  @{
 */

/**
 * @enum SenResultDataType
 * @brief Enum of result data type
 */
typedef NS_ENUM(uint32_t, SenResultDataType) {
    RES_TYPE_INFO = 0, /**< Information */
    RES_TYPE_HR, /**< Heart rate */
    RES_TYPE_RR, /**< Respiratory rate */
    RES_TYPE_SPO2, /**< Oxygen saturation */
    RES_TYPE_TMP, /**< Temperature */
    RES_TYPE_STEP, /**< Step counter */
    RES_TYPE_BP, /**< Blood pressure */
    RES_TYPE_GLUCOSE, /**< Glucose level */
    RES_TYPE_SQ, /**< Sleep quality */
    RES_TYPE_PAI, /**< Physical Activity Index */
    RES_TYPE_HRMAX, /**< HR max */
    RES_TYPE_HRREST, /**< HR rest */
    RES_TYPE_CC, /**< Calories consumption */
    RES_TYPE_BMR, /**< Basal metabolic rate result */
    RES_TYPE_SED, /**< Sedentary */
    RES_TYPE_HRV, /**< Heart Rate Variablity */
    RES_TYPE_AF, /**< Atrial Fibrillation */
    RES_TYPE_MAX
};

/**
 * @enum UserPhyStatus
 * @brief Enum of user physical status
 */
typedef NS_ENUM(uint8_t, UserPhyStatus) {
    USER_PHY_STA_STILL = 0, /**< User is still/reset */
    USER_PHY_STA_WALK, /**< User is walking */
    USER_PHY_STA_SLEEP, /**< User status info */
    USER_PHY_STA_SPORT, /**< User is exercising */
    USER_PHY_STA_NAP /**< User is napping */
};

/**
 * @enum SportType
 * @brief Enum of sport type
 */
typedef NS_ENUM(uint8_t, SportType) {
    SPORT_TYPE_WALK = 0, /**< Walking */
    SPORT_TYPE_RUN, /**< Running */
    SPORT_TYPE_SWIM /**< Swimming */
};

/**
 * @enum SenResInfoType
 * @brief Enum of result info type
 */
typedef NS_ENUM(uint8_t, SenResInfoType) {
    RES_INFO_TYPE_USER_STA = 0, /**< User status info */
    RES_INFO_TYPE_SPORT /**< Sport type */
};

/** @} */

static const uint8_t resultPresetGroup0[] = { RES_TYPE_INFO, RES_TYPE_HR, RES_TYPE_RR,
                                              RES_TYPE_SPO2, RES_TYPE_TMP };
static const uint8_t resultPresetGroup1[] = { RES_TYPE_INFO, RES_TYPE_BP, RES_TYPE_GLUCOSE,
                                              RES_TYPE_SQ };
static const uint8_t resultPresetGroup2[] = { RES_TYPE_INFO, RES_TYPE_STEP, RES_TYPE_HRMAX,
                                              RES_TYPE_HRREST };
static const uint8_t resultPresetGroup3[] = { RES_TYPE_INFO, RES_TYPE_PAI };
static const uint8_t resultPresetGroup4[] = { RES_TYPE_INFO, RES_TYPE_CC, RES_TYPE_BMR };
static const uint8_t resultPresetGroup5[] = { RES_TYPE_INFO, RES_TYPE_SED };
static const uint8_t resultPresetGroup6[] = { RES_TYPE_INFO, RES_TYPE_HRV, RES_TYPE_AF };
static const uint8_t resultSizeArray[RES_TYPE_MAX] = { 1, 2, 1, 2, 2, 4, 4, 2, 8, 12, 1, 1, 4, 2, 4, 2, 2 };

static NSString *const resultKeysArray[RES_TYPE_MAX] = {
    @"INFO", @"HR",    @"RR",     @"SPO2", @"TMP", @"STEP", @"BP",  @"GLUCOSE", @"SQ",
    @"PAI",  @"MAXHR", @"RESTHR", @"CC",   @"BMR", @"SED",  @"HRV", @"AF",
};

#endif /* ResultDefine_h */
