//
//  GlobalOtaDefine.h
//  CoreSDK
//
//  Created by Alex Lin on 2021/8/18.
//

#ifndef GlobalOtaDefine_h
#define GlobalOtaDefine_h

/** @defgroup OtaDefine OtaDefine
 *  Global definitions for OtaManager and Application.
 *  @ingroup OTA
 *  @{
 */

/**
 * @enum OtaProgressType
 * @brief Type of OTA's progress
 */
typedef NS_ENUM(uint8_t, OtaProgressType) {
    ProgressDownload = 0,
    ProgressInstall,
};

/**
 * @enum OtaProgressState
 * @brief State of OTA's progress
 */
typedef NS_ENUM(uint8_t, OtaProgressState) {
    OnProgress = 0,
    ProgressFinished,
    ProgressAbortError,
};

/**
 * @enum OtaStateMachineId
 * @brief State of OTA state machine
 */
typedef NS_ENUM(int8_t, OtaStateMachineId) {
    OtaSmError = -1,
    OtaSmIdle = 0,
    OtaSmStart,
    OtaSmTransfer,
    OtaSmTransFinish,
    OtaSmReboot,
    OtaSmComplete,
    OtaSmCancel,
    OtaSmDownload,
};

/**
 * @enum OtaErrorCode
 * @brief Type of error occurred during OTA
 */
typedef NS_ENUM(int8_t, OtaErrorCode) {
    OtaNoError = 0,
    OtaErrorGeneric,
    OtaErrorNetwork,
    OtaErrorDisconnect,
    OtaErrorNoImage,
    OtaErrorInvalidImage,
    OtaErrorWrongState,
    OtaErrorNoDevice,
    OtaErrorDeviceFault,
    OtaErrorDownload,
};
/** @} */

#endif /* GlobalOtaDefine_h */
