//
//  HttpRequestManager.h
//  HttpFramework
//
//  Created by Alex Lin on 2021/9/23.
//

#ifndef HttpRequestManager_h
#define HttpRequestManager_h

/** @defgroup HttpFramework HttpFramework
 *  HTTPFramework provides interfaces related to the HTTP protocol such as sending requests, file uploading and downloading.
 */

/** @addtogroup HttpRequestManager
 *  HttpRequestManager is responsible for the management of HTTP requests.
 *  @ingroup HttpFramework
 *  @{
 */
#import <Foundation/Foundation.h>
#import "HttpRequestParams.h"
#import "HttpRequestResponse.h"

typedef void (^HttpRequestResponseBlock)(HttpRequestResponse *responseObject);
typedef void (^HttpRequestReceiveBlock)(NSURLResponse *response, id responseObject, NSError *error);
typedef void (^HttpRequestProgressBlock)(float progress);

@interface HttpRequestManager : NSObject

+ (HttpRequestManager *)instance;

- (void)sendJSONRequest:(HttpRequestParams *)requestParams
             HeaderDict:(NSDictionary *)headerDict
          responseBlock:(HttpRequestReceiveBlock)block;

- (void)sendUploadFileRequest:(HttpRequestParams *)requestParams
                   HeaderDict:(NSDictionary *)headerDict
              progressHandler:(HttpRequestProgressBlock)progressBlock
            completionHandler:(HttpRequestReceiveBlock)completionBlock;

- (void)sendDownloadFileRequest:(HttpRequestParams *)requestParams
                     HeaderDict:(NSDictionary *)headerDict
                progressHandler:(HttpRequestProgressBlock)progressBlock
              completionHandler:(HttpRequestReceiveBlock)completionBlock;

- (void)cancelHTTPAllOperations;
@end

/** @} */
#endif /* HttpRequestManager_h */
