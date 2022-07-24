//
//  CoreSDK.h
//  CoreSDK
//
//  Created by Delia Chen on 2022/4/11.
//

#import <Foundation/Foundation.h>

//! Project version number for CoreSDK.
FOUNDATION_EXPORT double CoreSDKVersionNumber;

//! Project version string for CoreSDK.
FOUNDATION_EXPORT const unsigned char CoreSDKVersionString[];

// In this header, you should import all the public headers of your framework using statements like
// #import <CoreSDK/PublicHeader.h> Bridging-Header
#import <CoreSDK/DataDefine.h>

// Public headers
// Data
#import <CoreSDK/ModelDB.h>
#import <CoreSDK/DataParser.h>
#import <CoreSDK/DataManager.h>
// OTA
#import <CoreSDK/OtaManager.h>
// Transfer
#import <CoreSDK/TransferManager.h>
#import <CoreSDK/TransferManager+Command.h>
// Alert
#import <CoreSDK/AlertManager.h>
// Algo
#import <CoreSDK/AlgoManager.h>
// Connection
#import <CoreSDK/ConnectionAdapter.h>
// Test
#import <CoreSDK/TestManager.h>
#import <CoreSDK/TestManager+OTA.h>
#import <CoreSDK/TestManager+Device.h>
// Setting
#import <CoreSDK/AppSettings.h>
// Global Define
#import <CoreSDK/GlobalTransferDefine.h>
#import <CoreSDK/GlobalDataDefine.h>
#import <CoreSDK/GlobalOtaDefine.h>
#import <CoreSDK/AlertTypeDefine.h>
// Log
#import <CoreSDK/LogManager.h>
// Utility
#import <CoreSDK/MessageUtility.h>
// Custom Message
#import <CoreSDK/VsMessageDefine.h>
