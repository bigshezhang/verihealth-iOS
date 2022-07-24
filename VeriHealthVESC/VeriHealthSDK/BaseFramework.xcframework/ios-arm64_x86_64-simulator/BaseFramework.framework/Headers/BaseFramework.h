//
//  BaseFramework.h
//  BaseFramework
//
//  Created by Alex Lin on 2021/6/16.
//

#import <Foundation/Foundation.h>

//! Project version number for BaseFramework.
FOUNDATION_EXPORT double BaseFrameworkVersionNumber;

//! Project version string for BaseFramework.
FOUNDATION_EXPORT const unsigned char BaseFrameworkVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <BaseFramework/PublicHeader.h>
// Define
#import <BaseFramework/VsaErrorDefine.h>
#import <BaseFramework/ResultDefine.h>
// DataFrame
#import <BaseFramework/RawDataFrame.h>
#import <BaseFramework/ResultDataFrame.h>
#import <BaseFramework/VsMessageFrame.h>
#import <BaseFramework/PayloadFrame.h>
#import <BaseFramework/VsDevice.h>
// Utility
#import <BaseFramework/DateUtility.h>
#import <BaseFramework/DiscUtility.h>
#import <BaseFramework/FileUtility.h>
#import <BaseFramework/NSDateAndNSStringConversion.h>
// TODO: move to SecureFramework
#import <BaseFramework/SecureUtility.h>
