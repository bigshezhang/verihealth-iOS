//
//  TestClient.h
//  HttpFramework
//
//  Created by Alex Lin on 2021/9/23.
//

#ifndef TestClient_h
#define TestClient_h

#import "HttpRequestManager.h"
#import "TestApi.h"

typedef void (^HttpRefreshSessionSuccessBlock)(void);

NS_ASSUME_NONNULL_BEGIN
@interface TestClient : NSObject

/**
 * @brief Init the URL of server
 * @param url the URL of web server
 */
+ (void)initServerUrl:(NSString *)url;

/**
 * @brief Send JSON request to web server
 * @param paramUrl the URL of web server
 * @param paramRequestID the request ID
 * @param paramRequestType the request type
 * @param paramDict the dictonary of params
 * @param headerDict the dictonary of header
 * @param bodyDict the dictonary of body
 * @param paramRespBlock the callback for response
 */
+ (void)sendJSONRequest:(NSString *)paramUrl
              requestID:(NSInteger)paramRequestID
            requestType:(RequestType)paramRequestType
              ParamDict:(id _Nullable)paramDict
             HeaderDict:(id _Nullable)headerDict
               BodyDict:(id _Nullable)bodyDict
          RecvRespBlock:(HttpRequestResponseBlock)paramRespBlock;

/**
 * @brief Post request to server
 * @param requestId The request ID number
 * @param bodyDict the body to post in NSDictionary
 * @param completion the callback for repsonse
 */
+ (void)postRequest:(uint32_t)requestId
                 Body:(NSDictionary *_Nullable)bodyDict
    completionHandler:
        (nullable void (^)(NSDictionary *_Nullable respObj, NSError *_Nullable error))completion;

/**
 * @brief Get request from server
 * @param requestId The request ID number
 * @param completion the callback for repsonse
 */
+ (void)getRequest:(uint32_t)requestId
    completionHandler:
        (nullable void (^)(NSDictionary *_Nullable respObj, NSError *_Nullable error))completion;

/**
 * @brief Get request id from request API
 * @param requestApi The request  API
 */
+ (uint32_t)getRequestId:(NSString *)requestApi;

@end
NS_ASSUME_NONNULL_END

#endif /* TestClient_h */
