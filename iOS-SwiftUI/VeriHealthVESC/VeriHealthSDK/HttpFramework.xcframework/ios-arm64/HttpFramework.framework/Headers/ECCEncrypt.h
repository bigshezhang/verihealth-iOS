//
//  ECCEncrypt.h
//  HttpFramework
//
//  Created by Kaili Lu on 2022/3/31.
//

#ifndef ECCEncrypt_h
#define ECCEncrypt_h

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface ECCEncrypt : NSObject

/**
 * @brief Encrypt plaintext with ECC
 * @param plainText The plainText to be encrypted
 * @param certPathName The name of cert
 * @param certPathType The file type of cert
 * @return Base64 encoded string
 */
+ (NSString *)EncryptString:(NSString *)plainText
               certPathName:(NSString *)certPathName
                   fileType:(NSString *)certPathType;

/**
 * @brief Encrypt plaintext with ECC
 * @param data The NSData plainText to be encrypted
 * @param certPathName The name of cert
 * @param certPathType The file type of cert
 * @return The ciphertext after encrypted
 */
+ (NSData *)EncryptData:(NSData *)data
           certPathName:(NSString *)certPathName
               fileType:(NSString *)certPathType;

/**
 * @brief Encrypt plaintext with ECC
 * @param plainText The plainText to be encrypted
 * @param keyRef The key for decrypt
 * @return The ciphertext after encrypted
 */
+ (NSData *)ECIESEncrypt:(NSData *)plainText withKeyRef:(SecKeyRef)keyRef;

/**
 * @brief Decrypt ciphertext with ECC
 * @param str The cipherText to be decrypted
 * @param privKey The key for decrypt
 * @return The plaintext after decrypted
 */
+ (NSString *)DecryptString:(NSString *)str privateKey:(NSString *)privKey;

/**
 * @brief Decrypt ciphertext with ECC
 * @param data The cipherText to be decrypted
 * @param privKey The key for decrypt
 * @return The plaintext after decrypted
 */
+ (NSData *)DecryptData:(NSData *)data privateKey:(NSString *)privKey;

/**
 * @brief Decrypt ciphertext with ECC
 * @param cipherText The cipherText to be decrypted
 * @param keyRef The key for decrypt
 * @return The plaintext after decrypted
 */
+ (NSData *)ECIESDecrypt:(NSData *)cipherText withKeyRef:(SecKeyRef)keyRef;

@end

NS_ASSUME_NONNULL_END

#endif /* ECCEncrypt_h */
