//
//  VHCoreBluetoothManager.h
//  蓝牙连接流程self
//
//  Created by giancarlo on 2017/7/31.
//  Copyright © 2017年 giancarlo. All rights reserved.
//

#import <Foundation/Foundation.h>

//导入CoreBluetooth框架
#import <CoreBluetooth/CoreBluetooth.h>


@protocol VHCoreBluetoothManagerDelegate

- (void)getData:(NSData*)data;

@end

//可用把创建单例的方法写成宏 自己写的宏加前缀k
#define kVHCoreBluetoothManager [VHCoreBluetoothManager shareInstance]

@interface VHCoreBluetoothManager : NSObject

//代理属性 实现代理方法即可拿到外设传来的数据
@property(nonatomic,weak)id<VHCoreBluetoothManagerDelegate>delegate;

//放搜索到的蓝牙设备的数组
@property(nonatomic,strong)NSMutableArray <CBPeripheral *>* scanArr;

//当前连接的蓝牙外设
@property(nonatomic,strong)CBPeripheral *peripheral;

//和手机直接通讯的对应特征
@property(nonatomic,strong)CBCharacteristic *characteristic;

//和手机直接通讯的对应特征UUID,在外设连接成功后设置(连接成功后会自动扫描外设的所有服务和特征)
@property(nonatomic,strong)NSString *UUIDStr;

/// 单例
+ (instancetype)shareInstance;

@property(nonatomic,assign)BOOL isConnected;
/**
 蓝牙是否可以

 @return  蓝牙是否可以
 */
- (BOOL)isBluetoothAvailabel;

@property(nonatomic,strong)NSTimer *myTimer;


/**
 扫描外设

 @param update 扫描到的回调，传回当前扫描到的外设
 */
- (void)startScan: (void(^)(CBPeripheral *))update;

//停止扫描
- (void)stopScan;

/**
 连接外设

 @param peripheral 要连接的外设
 @param completion 是否连接成功
 */
- (void)connectPeripheral:(CBPeripheral*)peripheral Completion:(void(^)(BOOL,NSError*))completion;


/**
 断开连接
 */
- (void)disconnect;


/**
 给设备发送数据

 @param characteristic 外设的特征CBCharacteristic
 @param data 要发的数据NSData
 @param completion 是否发送成功
 */
- (void)writeDataWithCharacteristic:(CBCharacteristic *)characteristic Data:(NSData *)data Completion:(void(^)(BOOL,NSError*))completion;




//十六进制字符串转NSData
- (NSData *)convertHexStrToData:(NSString *)str;

//NSData转十六进制字符串
- (NSString *)convertDataToHexStr:(NSData *)data;

@end
