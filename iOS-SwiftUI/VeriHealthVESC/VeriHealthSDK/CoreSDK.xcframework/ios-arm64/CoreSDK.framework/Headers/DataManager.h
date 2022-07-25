//
//  DataManager.h
//  CoreSDK
//
//  Created by Alex Lin on 2021/9/11.
//

#ifndef DataManager_h
#define DataManager_h

/** @defgroup Data Data
 *  Data APIs, provide interfaces such as Realm database initialization, storage, and query data, and pass vital sign data to the upper layer through delegation.
 *  @ingroup CoreSDK
 */

/** @addtogroup DataManager
 *  @ingroup Data
 *  @{
 */

#import <BaseFramework/BaseFramework.h>
#import <Realm/Realm.h>
#import "GlobalDataDefine.h"

NS_ASSUME_NONNULL_BEGIN
@class DataManager;

/**
 * Delegate methods for DataManager delegates
 */
@protocol DataManagerDelegate <NSObject>
@optional

/**
 * @brief Update the statistical data
 * @param type The data type
 * @param value The new value for specific data type
 */
- (void)DataStatisticalUpdate:(DBDataType)type Value:(int)value;

/**
 * @brief Update the statistical data for HR
 * @param min Minimum value of HR
 * @param max Maxmum value of HR
 * @param avg Average value of HR
 */
- (void)HrStatisticalUpdate:(uint8_t)min Max:(uint8_t)max Avg:(uint8_t)avg;

@end

@interface DataManager : NSObject

/**
 *  @brief Create shared instance for Data Manager
 */
+ (instancetype)sharedInstance;

/**
 *  @brief Init Data Manager instance
 */
- (instancetype)init;

/**
 *  @brief Initialization DataBase
 *  @param user Current user
 *  @param device Current device
 */
- (void)DataBaseInit:(NSString *)user device:(VsDevice *)device;

/**
 *  @brief Write data object  to DataBase
 *  @param DataObj Any supported result object
 *  @param timeStamp TimeStamp of HRObject
 */
- (void)writeData:(id)DataObj TimeStamp:(int)timeStamp;

/**
 *  @brief Write alert data to DataBase
 *  @param type The type of alert data
 *  @param timestamp TimeStamp of alert data
 *  @param param The parameter of alert data
 */
- (void)writeAlertData:(DBDataType)type Time:(uint32_t)timestamp Param:(int)param;

/**
 *  @brief Delete all data in DataBase
 */
- (void)deleteAllData;

/**
 *  @brief Query all speicified type data in DataBase with mainQueue
 *  @param type The data type @see DBDataType
 *  @param userName The username of database
 *  @return Realm result
 */
- (RLMResults *)queryAllData:(DBDataType)type UserName:(NSString *)userName;

/**
 *  @brief Query data in DataBase with mainQueue
 *  @param type The data type @see DBDataType
 *  @param startTime Start timestamp
 *  @param endTime End timestamp
 *  @param userName The username of database
 *  @return Realm result
 */
- (RLMResults *)queryData:(DBDataType)type
                    Start:(int)startTime
                      End:(int)endTime
                 UserName:(NSString *)userName;

/**
 *  @brief Query  latest data from database
 *  @param type The data type @see DBDataType
 *  @param userName The username of database
 */
- (int)queryLatestData:(DBDataType)type UserName:(NSString *)userName;

/**
 *  @brief Query  latest data  over a period of time from database
 *  @param type The data type @see DBDataType
 *  @param startTime Start timestamp
 *  @param endTime End timestamp
 *  @param userName The username of database
 */
- (int)queryLatestData:(DBDataType)type
                 Start:(int)startTime
                   End:(int)endTime
              UserName:(NSString *)userName;

/**
 *  @brief Query  latest data from a period time
 *  @param type The data type @see DBDataType
 *  @param maxTime Max timestamp
 */
- (int)queryPeriodLatestData:(DBDataType)type maxTime:(int)maxTime;

/**
 *  @brief Query  data in DataBase with dataQueue
 *  @param type The data type @see DBDataType
 *  @param startTime Start timestamp
 *  @param endTime End timestamp
 *  @param userName The username of database
 *  @param completion The callback for repsonse
 */
- (void)queryData:(DBDataType)type
                Start:(int)startTime
                  End:(int)endTime
             UserName:(NSString *)userName
    completionHandler:(nullable void (^)(RLMResults *res, NSError *_Nullable error))completion;

/**
 *  @brief Get current user name
 */
- (NSString *)currUser;

/**
 *  @brief Add delegate to Data Manager
 *  @param dataDelegate Input delegate
 */
- (void)addDelegate:(id<DataManagerDelegate>)dataDelegate;

/**
 *  @brief Remove data manager delegate
 *  @param dataDelegate Input delegate
 */
- (void)removeDelegate:(id<DataManagerDelegate>)dataDelegate;

/**
 *  @brief Remove all delegates
 */
- (void)removeAllDelegates;

@end

NS_ASSUME_NONNULL_END
/** @} */
#endif /* DataManager_h */
