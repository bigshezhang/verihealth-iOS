//
//  VsaErrorDefine.h
//  BaseFramework
//
//  Created by Alex Lin on 2021/8/2.
//

#ifndef VsaErrorDefine_h
#define VsaErrorDefine_h

/** @addtogroup ErrorCode
 *  @ingroup BaseDefine
 *  @{
 */

/**
 * @enum VsaErrCode
 * @brief Error code define for VSA (VeriSilicon Applilcation)
 */
typedef NS_ENUM(int, VsaErrCode) {
    VSA_ERR_GENERIC = -1, /**< Generic error */
    VSA_SUCCESS = 0, /**< Success */
    VSA_ERR_INVALID, /**< Error for invalid parameters */
    VSA_ERR_UNSUPPORTED, /**< Error for unsupport */
    VSA_ERR_NO_DEVICE, /**< Error for no device */
    VSA_ERR_NO_MEM, /**< Error for no memory */
    VSA_ERR_FULL, /**< Error for generic full */
    VSA_ERR_EMPTY, /**< Error for generic empty */
    VSA_ERR_TIMEOUT, /**< Error for timeout */
    VSA_ERR_NOT_READY, /**< Error for not ready */
};

/** @} */
#endif /* VsaErrorDefine_h */
