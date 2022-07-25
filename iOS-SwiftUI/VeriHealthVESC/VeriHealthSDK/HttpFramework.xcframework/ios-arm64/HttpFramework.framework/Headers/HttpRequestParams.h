//
//  HttpRequestParams.h
//  HttpFramework
//
//  Created by Alex Lin on 2021/9/23.
//

#ifndef HttpRequestParams_h
#define HttpRequestParams_h

/** @addtogroup HttpRequestParams
 *  HttpRequestParams encapsulates the parameters to be carried by the HTTP request.
 *  @ingroup HttpFramework
 *  @{
 */

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, RequestTask) {
    RequestTask_Data,
    RequestTask_Upload_File,
    RequestTask_Upload_Binary,
    RequestTask_Download,
};

typedef NS_ENUM(NSInteger, RequestType) {
    RequestType_Get,
    RequestType_Post,
    RequestType_Put,
    RequestType_Delete
};

typedef NS_ENUM(NSInteger, RequestID) {
    // User
    Request_Register,
    Request_Login,
    Request_ECCPublicKey,
    Request_List,
    Request_GetMsgCode,
    Request_ModifyPassword,
    Request_FindPassword,
    Request_ValidateCode,
    Request_ResetPassword,
    Request_ValidateNewPassword,
    Request_CompleteUserInfo,
    Request_UploadPortrait,
    Request_DownloadPortrait,
    Request_SendFeedback,
    Request_GetFeedback,
    Request_DeleteFeedback,
    Request_DeleteAllFeedback,
    Request_GetUserInfo,
    // Vital data
    Request_UploadVitalData,
    Request_DownloadVitalData,
    // App
    Request_CheckAppVersion,
    Request_GetHelpManual,
    Request_Max
};

@interface HttpRequestParams : NSObject

@property (nonatomic, assign) RequestType requestType;
@property (nonatomic, copy) NSString *requestUrl;
@property (nonatomic, assign) RequestID requestID;
@property (nonatomic, strong) NSDictionary *requestParams;
@property (nonatomic, strong) NSDictionary *requestBody;
@property (nonatomic, strong) NSString *requestStringBody;
@property (nonatomic) RequestTask requestTask;
@end

/** @} */
#endif /* HttpRequestParams_h */
