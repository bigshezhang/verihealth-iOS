//
//  TestManager+Device.h
//  CoreSDK
//
//  Created by Alex Lin on 2021/9/19.
//

#ifndef TestManager_Device_h
#define TestManager_Device_h

#import "TestManager.h"

NS_ASSUME_NONNULL_BEGIN
@interface TestManager (Device)

/**
 * @brief Run tests commands related to device's actions
 * @param body Dictionary containing device actions' info
 * @see HttpFramework/TestService/TestApi.h
 */
- (void)runDeviceCommand:(NSDictionary *)body;
@end

NS_ASSUME_NONNULL_END

#endif /* TestManager_Device_h */
