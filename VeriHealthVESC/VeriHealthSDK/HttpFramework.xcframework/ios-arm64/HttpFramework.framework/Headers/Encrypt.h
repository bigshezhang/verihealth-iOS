//
//  Encrypt.h
//  HttpFramework
//
//  Created by Kaili Lu on 2022/3/24.
//

#ifndef Encrypt_h
#define Encrypt_h

#import <Foundation/Foundation.h>
#import "WebApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Encrypt)

/**
 * @brief Generate encrypt key with SHA1
 * @return Hex string key
 */
- (NSString *)SHA1;

/**
 * @brief Generate encrypt key with SHA256
 * @return NSString key
 */
- (NSString *)SHA256;

/**
 * @brief Generate encrypt key with SHA256
 * @return NSData key
 */
- (NSData *)SHA256Data;

/**
 * @brief convert dictionary to json
 * @param dicData NSDictionary data
 * @return JSON string
 */
+ (NSString *)getJSONStringFromDic:(NSDictionary *)dicData;

/**
 * @brief convert  json to dictionary
 * @param jsonString json string
 * @return NSDictionary data
 */
+ (NSDictionary *)getDicFromJSONString:(NSString *)jsonString;

/**
 * @brief generate AES256 key
 * @return a random 256bit key
 */
+ (NSData *)random256BitAESKey;

/**
 * @brief save the AES key
 * @param key the AES key
 * @param KeyID the AES keyID
 */
+ (void)saveKey:(NSString *)key forKey:(NSString *)KeyID;

/**
 * @brief generate & save the AES key pair
 */
+ (void)generateAESKeyPair;

/**
 * @brief get the AES key
 * @param keyID the AES keyID
 */
+ (NSString *)getAESKey:(NSString *)keyID;

/**
 * @brief Encrypt plain text with AES256
 * @param plainText the plainText to be encrypted
 * @param AESKey AES key for encrypt
 * @param iv optional  initialization vector
 * @return the ciphertext after encrypted
 */
+ (NSString *)AESEncryptWithKey:(NSString *)plainText
                        withKey:(NSString *)AESKey
                         withIV:(NSString *)iv;

/**
 * @brief Encrypt plain text with AES256
 * @param plainText the plainText to be encrypted
 * @return the ciphertext after encrypted
 */
+ (NSString *)AESEncrypt:(NSString *)plainText;

/**
 * @brief Decrypt ciphertext with AES256
 * @param cipherText the cipherText to be decrypted
 * @param AESKey AES key for decrypt
 * @param iv optional  initialization vector
 * @return the plaintext after decrypted
 */
+ (NSString *)AESDecryptWithKey:(NSString *)cipherText
                        withKey:(NSString *)AESKey
                         withIV:(NSString *)iv;

/**
 * @brief Decrypt ciphertext with AES256
 * @param cipherText the cipherText to be decrypted
 * @return the plaintext after decrypted
 */
+ (NSString *)AESDecrypt:(NSString *)cipherText;

@end

NS_ASSUME_NONNULL_END

#endif /* Encrypt_h */
