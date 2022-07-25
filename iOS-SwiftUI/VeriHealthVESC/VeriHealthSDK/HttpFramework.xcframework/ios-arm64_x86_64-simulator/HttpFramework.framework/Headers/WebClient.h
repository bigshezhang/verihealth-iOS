//
//  WebClient.h
//  HttpFramework
//
//  Created by Alex Lin on 2021/9/23.
//

#ifndef WebClient_h
#define WebClient_h

#import "HttpRequestManager.h"
#import "WebApi.h"

typedef void (^HttpRefreshSessionSuccessBlock)(void);
typedef void (^HttpRefreshSessionFailBlock)(HttpRequestResponse *_Nullable responseObject);

NS_ASSUME_NONNULL_BEGIN
@interface WebClient : NSObject

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
              requestID:(RequestID)paramRequestID
            requestType:(RequestType)paramRequestType
              ParamDict:(id _Nullable)paramDict
             HeaderDict:(id _Nullable)headerDict
               BodyDict:(id _Nullable)bodyDict
          RecvRespBlock:(HttpRequestResponseBlock)paramRespBlock;

/**
 * @brief Send JSON request to get data from server
 * @param paramUrl the URL of web server
 * @param paramRequestID the request ID
 * @param paramRequestType the request type
 * @param paramDict the dictonary of params
 * @param headerDict the dictonary of header
 * @param bodyDict the dictonary of body
 * @param paramResponseBlock the callback for response
 */
+ (void)sendJSONRequestWithRefreshSession:(NSString *)paramUrl
                                requestID:(RequestID)paramRequestID
                              requestType:(RequestType)paramRequestType
                                ParamDict:(id _Nullable)paramDict
                               HeaderDict:(NSDictionary *_Nullable)headerDict
                                 BodyDict:(id _Nullable)bodyDict
                            RecvRespBlock:(HttpRequestResponseBlock)paramResponseBlock;
/**
 * @brief Post request to server
 * @param serverURL The URL of server
 * @param requestId The request ID number
 * @param bodyDict The body to post in NSDictionary
 * @param certPathName The name of cert
 * @param certPathType The file type of cert
 * @param completion the callback for repsonse
 */
+ (void)postRequest:(NSString *)serverURL
            requestId:(uint32_t)requestId
                 Body:(NSString *_Nullable)bodyDict
         certPathName:(NSString *)certPathName
             fileType:(NSString *)certPathType
    completionHandler:
        (nullable void (^)(NSDictionary *_Nullable respObj, NSError *_Nullable error))completion;

/**
 * @brief Get request from server
 * @param serverURL The URL of server
 * @param requestId The request ID number
 * @param certPathName The name of cert
 * @param certPathType The file type of cert
 * @param completion The callback for repsonse
 */
+ (void)getRequest:(NSString *)serverURL
            requestId:(uint32_t)requestId
         certPathName:(NSString *)certPathName
             fileType:(NSString *)certPathType
    completionHandler:
        (nullable void (^)(NSDictionary *_Nullable respObj, NSError *_Nullable error))completion;

/**
 * @brief Get request id from request API
 * @param requestApi The request  API
 */
+ (uint32_t)getRequestId:(NSString *)requestApi;

@end
NS_ASSUME_NONNULL_END
#endif /* WebClient_h */
