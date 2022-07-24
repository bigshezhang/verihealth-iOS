//
//  TokenManager.h
//  HttpFramework
//
//  Created by Kaili Lu on 2022/3/22.
//

#ifndef TokenManager_h
#define TokenManager_h

@interface TokenManager : NSObject

/**
 * @brief save token to userDefault
 */
+ (void)saveToken:(NSString *)token;

/**
 * @brief get token from userDefault
 */
+ (NSString *)getToken;

/**
 * @brief clean token from userDefault
 */
+ (void)cleanToken;

@end

#endif /* TokenManager_h */
