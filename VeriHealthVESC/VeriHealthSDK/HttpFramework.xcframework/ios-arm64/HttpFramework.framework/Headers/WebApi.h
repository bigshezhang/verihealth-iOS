//
//  WebApi.h
//  HttpFramework
//
//  Created by Alex Lin on 2021/9/23.
//

#ifndef WebApi_h
#define WebApi_h

#define RefreshSessionFailCode 1300
#define kHttpSuccessCode 10000

#define kBinaryFileKey @"file"
#define kFileType @"fileType"

#define kSessionID @"token"
#define kDataID @"data"
#define kUserNameKey @"userNameKey"
#define kUserAccountKey @"userAccountKey"
#define kUserPasswordKey @"userPasswordKey"
#define kAESKeyRequest @"AESKeyRequest"
#define kAESKeyData @"AESKeyData"
#define kAESIVName @"AESIV"

// User
#define kRegisterAPI @"register"
#define kLoginAPI @"login"
#define kGetECCKeyAPI @"ECCPublicKey"
#define kListAPI @"list"
#define kModifyPasswordAPI @"modifyPassword"
#define kFindPasswordAPI @"findPassword"
#define kCheckVerCodeAPI @"checkVerCode"
#define kResetPasswordAPI @"resetPassword"
#define kCompleteUserInfoAPI @"completeUserInfo"
#define kUserPortraitAPI @"uploadUserPortrait"
#define kSendFeedbackAPI @"sendFeedback"
#define kGetFeedbackAPI @"getFeedBack"
#define kDeleteFeedBackAPI @"delFeedBack"
#define kDeleteAllFeedBackAPI @"delAllFeedBack"
#define kGetUserInfoAPI @"getUserInfo"
#define kMobileRegisterAPI @"setMessageAccount"
#define kMessageCodeLoginAPI @"messageCodeLogin"
#define kGetMessageCodeAPI @"getMessageCode"
#define kValidateMessageCodeAPI @"validateMessageCode"
#define kValidateNewPasswordAPI @"validateNewPassword"

// Vital data
#define kUploadVitalDataAPI @"uploadVitalData"
#define kDownloadVitalDataAPI @"dowonloadVitalData"

// App
#define kCheckAppVersionAPI @"checkAppVersion"
#define kGetInstructionManualAPI @"helpManual"
#endif /* WebApi_h */
