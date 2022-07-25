//
//  TestManager+OTA.h
//  CoreSDK
//
//  Created by Alex Lin on 2021/9/18.
//

#ifndef TestManager_OTA_h
#define TestManager_OTA_h

#import "TestManager.h"

NS_ASSUME_NONNULL_BEGIN
@interface TestManager (OTA)

/**
 * @brief Start OTA, including image download and image upgrade
 * @param url The url of remote image file
 * @param name The path & name of image file
 */
- (void)startOta:(NSString *)url Name:(NSString *)name;

/**
 * @brief Run tests commands related to OTA's actions
 * @param respBody Dictionary containing OTA actions' info
 * @see HttpFramework/TestService/TestApi.h
 */
- (void)runOtaCommand:(NSDictionary *)respBody;
@end

NS_ASSUME_NONNULL_END

#endif /* TestManager_OTA_h */
