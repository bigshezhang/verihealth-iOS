//
//  AppSettings.h
//  CoreSDK
//
//  Created by Alex Lin on 2021/9/16.
//

#ifndef AppSettings_h
#define AppSettings_h

/** @addtogroup Settings
 *  Settings APIs, which encapsulate some NSUserDefaults interfaces. It is convenient for Application developers to store lightweight local data that does not require encryption.
 *  @ingroup CoreSDK
 *  @{
 */

@interface AppSettings : NSObject

/**
 * @brief Get user setting of value
 * @param key The key to get user setting
 * @return User setting value
 */
+ (nullable id)getUserDefaultInfo:(NSString *_Nullable)key;

/**
 * @brief Get user setting of array
 * @param key The key to get user setting
 * @return User setting value
 */
+ (nullable id)getUserDefaultArray:(NSString *_Nullable)key;

/**
 * @brief Save user setting of value
 * @param value The value to be saved
 * @param key The key to save user setting
 */
+ (void)saveUserDefaultInfo:(nullable id)value forKey:(NSString *_Nullable)key;

/**
 * @brief Save user setting of array
 * @param array The array to be saved
 * @param key The key to save user setting
 */
+ (void)saveUserDefaultArray:(nullable id)array forKey:(NSString *_Nullable)key;

/**
 * @brief Remove user setting
 * @param key The key to remove user setting
 */
+ (void)removeUserDefaultInfo:(NSString *_Nullable)key;

@end

/** @} */
#endif /* AppSettings_h */
