//
//  ConnectionDefine.h
//  CoreSDK
//
//  Created by Delia Chen on 2022/5/12.
//

#ifndef ConnectionDefine_h
#define ConnectionDefine_h

/**
 * @enum TransferConnType
 * @brief Type of connection and transfer data
 */
typedef NS_ENUM(NSUInteger, TransferConnType) {
    TransferConnTypeBle,
    TransferConnTypeWifi,
    TransferConnTypeNBIoT,
};

#endif /* ConnectionDefine_h */
