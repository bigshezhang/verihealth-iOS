//
//  SecureUtility.h
//  BaseFramework
//
//  Created by Alex Lin on 2021/9/9.
//

#ifndef SecureUtility_h
#define SecureUtility_h

/** @addtogroup Secure
 *  Secure-related utility functions
 *  @ingroup Utility
 *  @{
 */

/**
 *  @brief Get sha224 for input data
 *  @param input The input data
 *  @return Result of sha224
 */
NSString *sha224(NSData *input);

/**
 *  @brief Get sha256 for input data
 *  @param input The input data
 *  @return Result of sha256
 */
NSString *sha256(NSData *input);

/**
 *  @brief Get sha384 for input data
 *  @param input The input data
 *  @return Result of sha384
 */
NSString *sha384(NSData *input);

/**
 *  @brief Get sha512 for input data
 *  @param input The input data
 *  @return Result of sha512
 */
NSString *sha512(NSData *input);

/**
 *  @brief Get MD5 for input data
 *  @param input The input data
 *  @return Result of MD5
 */
NSString *getMD5(NSData *input);

/** @} */
#endif /* SecureUtility_h */
