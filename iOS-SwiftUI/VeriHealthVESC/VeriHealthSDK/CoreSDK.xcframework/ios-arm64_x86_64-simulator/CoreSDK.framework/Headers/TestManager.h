//
//  TestManager.h
//  CoreSDK
//
//  Created by Alex Lin on 2021/9/11.
//

#ifndef TestManager_h
#define TestManager_h

#import <BaseFramework/BaseFramework.h>

NS_ASSUME_NONNULL_BEGIN
@class TestManager;

@interface TestManager : NSObject
@property (assign, nonatomic, readonly) BOOL isStarted;
@property (strong, nonatomic, readonly) dispatch_queue_t testQueue;
@property (strong, nonatomic) NSTimer *hbTimer;
@property (strong, nonatomic, readwrite) NSMutableData *messageList;
@property (strong, nonatomic, readwrite) NSMutableData *dataSize;
@property (strong, nonatomic, readwrite) NSMutableArray *messageName;
@property (assign, nonatomic, readwrite) int currIndex;
@property (assign, nonatomic, readwrite) uint64_t timeStamp;
@property (nonatomic) uint8_t *testParam;
@property (assign, nonatomic, readwrite) BOOL isMsgRemoteTestStart;
@property (assign, nonatomic, readwrite) BOOL isProtocolRemoteTestStart;

/**
 *  @brief Create shared instance for Test Manager
 */
+ (instancetype)sharedInstance;

/**
 *  @brief Init Test server URL
 *  @param url The URL of server
 */
- (void)initServerUrl:(NSString *)url;

/**
 *  @brief Init Test Manager instance
 */
- (instancetype)init;

/**
 *  @brief Ping the remote server
 *  @param completion The block for completion
 */
- (void)ping:(nullable void (^)(NSDictionary *_Nullable respObj,
                                NSError *_Nullable error))completion;

/**
 *  @brief Start the  remote test
 */
- (void)start;

/**
 *  @brief Stop the  remote test
 */
- (void)stop;

/**
 @brief Fill message id list
 @param msgList The message list from upper layer
 @param sizeList The message size list
 @param msgName The  message name list
 */
- (void)fillMessageList:(NSData *)msgList Size:(NSData *)sizeList Name:(NSArray *)msgName;

/**
 @brief Message test after device ready
 */
- (void)triggerMessageTest;

@end

NS_ASSUME_NONNULL_END

#endif /* TestManager_h */
