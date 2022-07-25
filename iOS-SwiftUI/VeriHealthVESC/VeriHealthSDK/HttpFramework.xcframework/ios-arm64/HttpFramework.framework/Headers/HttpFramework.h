//
//  HttpFramework.h
//  HttpFramework
//
//  Created by Alex Lin on 2021/9/2.
//

#import <Foundation/Foundation.h>

//! Project version number for HttpFramework.
FOUNDATION_EXPORT double HttpFrameworkVersionNumber;

//! Project version string for HttpFramework.
FOUNDATION_EXPORT const unsigned char HttpFrameworkVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <HttpFramework/PublicHeader.h>
#import <HttpFramework/FileDownload.h>
#import <HttpFramework/HttpRequestManager.h>
#import <HttpFramework/HttpRequestParams.h>
#import <HttpFramework/HttpRequestResponse.h>

// Not included in doxygen API documentation
#import <HttpFramework/WebApi.h>
#import <HttpFramework/WebClient.h>
#import <HttpFramework/TestApi.h>
#import <HttpFramework/TestClient.h>

// TODO: Move to SecureFramework
#import <HttpFramework/ECCEncrypt.h>
#import <HttpFramework/Encrypt.h>
#import <HttpFramework/TokenManager.h>
