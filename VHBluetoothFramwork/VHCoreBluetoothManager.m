//
//  VHCoreBluetoothManager.m
//  蓝牙连接流程self
//
//  Created by giancarlo on 2017/7/31.
//  Copyright © 2017年 giancarlo. All rights reserved.
//

#import "VHCoreBluetoothManager.h"

@interface VHCoreBluetoothManager ()<CBCentralManagerDelegate,CBPeripheralDelegate>

//扫描回调属性
@property(nonatomic,copy)void(^scanBlock)(CBPeripheral *);
//连接回调属性
@property(nonatomic,copy)void(^connectBlock)(BOOL,NSError*);
//发送数据回调
@property(nonatomic,copy)void(^writeBlock)(BOOL,NSError*);
//蓝牙中心属性 CBCentralManager
@property(nonatomic,strong)CBCentralManager *cbCentralManager;

@end

@implementation VHCoreBluetoothManager{
    BOOL _isStateUnknown;  //因为每次打开app需要扫描一次，才能确定蓝牙状态
}

// 单例
+ (instancetype)shareInstance{
    static VHCoreBluetoothManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[VHCoreBluetoothManager alloc] init];
    });
    return  manager;
}


- (instancetype)init{
    self = [super init];
    //初始化外设数组
    self.scanArr = [NSMutableArray new];
//    [self isBluetoothAvailabel];
    return self;
}

//创建蓝牙中心,懒加载 initWithDelegate
//queue:代理所在线程 主线程: dispatch_get_main_queue()
-(CBCentralManager *)cbCentralManager{
    if (_cbCentralManager == nil) {
        self.cbCentralManager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
    }
    return _cbCentralManager;
}



//获取蓝牙授权状态 isBluetoothAvailabel
- (BOOL)isBluetoothAvailabel{
    BOOL flag = NO;
    /*
     CBManagerStateUnknown = 0,
     CBManagerStateResetting,
     CBManagerStateUnsupported,
     CBManagerStateUnauthorized,
     CBManagerStatePoweredOff,
     CBManagerStatePoweredOn,
     */
    switch (self.cbCentralManager.state) {
        case CBManagerStateUnknown:
            NSLog(@"未知状态");
            flag = YES;
            break;
        case CBManagerStateResetting:
            NSLog(@"连接断开 即将重置");
            break;
        case CBManagerStateUnsupported:
            NSLog(@"当前设备不支持蓝牙");
            break;
        case CBManagerStateUnauthorized:
            NSLog(@"未授权");
            break;
        case CBManagerStatePoweredOff:
            NSLog(@"蓝牙未开启");
            break;
        case CBManagerStatePoweredOn:
            NSLog(@"蓝牙可用");
            flag = YES;
            break;
    }
    return  flag;
}

///开始扫描
- (void)startScan: (void(^)(CBPeripheral *))update{
    
    //0.判断蓝牙是否可用
    //断言: 第一个参数: 条件表达式
    //第二个参数: 当条件表达式不满足时<程序主动崩溃报错,并且给出提示信息
//    NSAssert([self isBluetoothAvailabel], @"请检查你的蓝牙设置");
    
    //1.扫描外设 Services: 扫描指定服务的外设  options: 设置 为nil表示默认设置
#pragma mark - 第一步 扫描外设 scanForPeripherals
    [self.cbCentralManager scanForPeripheralsWithServices:nil options:nil];
    if (self.cbCentralManager.state == CBManagerStateUnknown) {
        _isStateUnknown = YES;
    }
    
    //保存扫描回调 self.scanBlock =
    self.scanBlock = update;
    
}

- (void)stopScan {
    [self.cbCentralManager stopScan];
}

#pragma mark CBCentralManagerDelegate 蓝牙中心的代理方法

//蓝牙状态更新CBCentrlManager.state
-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
    NSLog(@"%zd",central.state);
    [self isBluetoothAvailabel];
    //如果是打开app后第一次扫描，则需要在确定蓝牙状态是CBManagerStatePoweredOn后再扫描一次
    if (_isStateUnknown) {
         [self.cbCentralManager scanForPeripheralsWithServices:nil options:nil];
    }
}

#pragma mark - 第二步 发现外设(锁定外设)

/**
 didDiscoverPeripheral:
 peripheral: 扫描到的外设
 advertisementData: 外设的广告介绍信息
 RSSI: 外设信号强度  int类型
 */
//外设是不能自己创建的，只能通过扫描得到
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI{
//    NSLog(@"扫描到的外设%@",peripheral);
//    NSLog(@"信号强度%@",RSSI);
//    NSLog(@"%@",advertisementData);
//     NSLog(@"扫描到的外设%@",peripheral.name);
    
    //去掉原来的，添加最新的
    if ([_scanArr containsObject:peripheral]) {
        [_scanArr removeObject:peripheral];
    }
    [_scanArr addObject:peripheral];
    self.scanBlock(peripheral);
    
//    //将外设加入数组,并做去重处理
//    if (![_scanArr containsObject:peripheral]) {
//        //添加到数组
//        [_scanArr addObject:peripheral];
//
//        //执行回调
//        self.scanBlock(peripheral);
//    }
    
    
}

#pragma mark - 第三步 连接外设
//断开连接
- (void)disconnect{
    
    [self.cbCentralManager cancelPeripheralConnection:self.peripheral];

}


//连接设备  第一个参数:要连接的外设  第二个参数:连接结果的回调
- (void)connectPeripheral:(CBPeripheral*)peripheral Completion:(void(^)(BOOL,NSError*))completion{
    
    //1.保存block
    self.connectBlock = completion;
    
    //2.连接外设 centralManager   connectPeripheral
    [self.cbCentralManager connectPeripheral:peripheral options:nil];
    
    //开启定时器
//    NSTimer *timer = [NSTimer timerWithTimeInterval:20 repeats:NO block:^(NSTimer * _Nonnull timer) {
//        NSError *error = [NSError errorWithDomain:@"自定义" code:-1 userInfo:@{@"原因":@"连接超时"}];
//        self.connectBlock(NO, error);
//        [self.cbCentralManager cancelPeripheralConnection:peripheral];
//    }];
//
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}


//链接外设成功
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
//    self.isConnected = YES;
    NSLog(@"外设连接成功");
    self.UUIDStr = @"FEE1";
    //接收外设发来的数据
    if (self.characteristic) {
        NSLog(@"进来了");
//        [self.peripheral setNotifyValue:YES forCharacteristic:self.characteristic];
    }
    

    
    //1.送出回调
//    self.connectBlock(YES, nil);
    //2.保存链接的外设  此时外设是一个局部变量
    self.peripheral = peripheral;
    //3.设置外设的代理为当前控制器
    self.peripheral.delegate = self;
    
#pragma mark - 第四步 寻找外设的服务
    //4.寻找外设的服务
    //没有寻找服务之前,查看外设服务,此时外设是没有服务的
//    NSLog(@"此时外设的服务是%@",self.peripheral.services);
    
    //参数: 指定的服务(如果设备已经连接过,将服务保存到本地,下一次连接可以指定服务)
    [self.peripheral discoverServices:nil];
}


//连接外设失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"外设连接失败");
    // 送出回调
    self.connectBlock(NO, error);
}

//外设断开（主动或被动）
-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{

    NSLog(@"外设断开");
    self.isConnected = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"peripheralCut" object:nil];
    //在这里可以重连
}

#pragma mark - CBPeripheralDelegate  外设的代理

//外设信号强度发生变化
- (void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(NSError *)error{
    //NSLog(@"外设信号强度发生变化==%@",peripheral.RSSI);
    
}

#pragma mark 第四步 外设发现了服务
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    
//    NSLog(@"发现后外设的服务是: %@",peripheral.services);

#pragma mark 第五步 寻找服务的特征
    for (CBService *service in peripheral.services) {
        
        //没有寻找服务特征之前服务是没有特征的
//        NSLog(@"没有寻找服务特征之前服务是没有特征的:%@",service.characteristics);
        
        //第一个参数 寻找指定的特征 为nil表示寻找所有特征
        //第二个参数: 寻找哪个服务的特征
        [self.peripheral discoverCharacteristics:nil forService:service];
    }
}

//发现服务的特征会调用的方法
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    
//    NSLog(@"发现服务的特征%@",service.characteristics);
    
    for (CBCharacteristic *c in service.characteristics) {
        //每个特征都有自己的UUID
        //NSLog(@"每个特征都有自己的UUID:%@",c.UUID);
        
        if ([[c.UUID UUIDString] isEqualToString:self.UUIDStr]) {//@"2A06"
            //记录想要发数据的特征
            NSLog(@"%@",self.UUIDStr);
            self.characteristic = c;
            NSLog(@"确定特征开始接收数据");
            [self.peripheral setNotifyValue:YES forCharacteristic:self.characteristic];
//            self.connectBlock(YES, nil);
        }
    }
}

#pragma mark 第六步 - 给外设的特征发送数据
//给设备发送数据 第一个参数:外设的特征CBCharacteristic  第二个参数:要发的数据NSData
- (void)writeDataWithCharacteristic:(CBCharacteristic *)characteristic Data:(NSData *)data Completion:(void(^)(BOOL,NSError*))completion{
    
    self.writeBlock = completion;
    /**
     Value:要给特征发送的数据 二进制
     Characteristic:要发数据的特征
     type:特征的读写类型  注意:该参数不能乱写  否则会发送数据失败 实际工作中就两个枚举值,这个不行就换哪个
     CBCharacteristicWriteWithResponse = 0,需要外设响应
     CBCharacteristicWriteWithoutResponse,不需要外设响应
     */
    //给外设的某个特征写入数据  writeValue forCharacteristic
    //设备给特征写入数据
    [self.peripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
    
}

//接收到外设的特征发过来的数据
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
//    NSLog(@"接收到外设的特征发过来的数据");
     //characteristic.value  特征返回的数据
    [self.delegate getData:characteristic.value];
}

//手机给外设的服务发送数据成功
- (void)peripheral:(CBPeripheral *)peripheral didWriteValujeForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    NSLog(@"发数据成功");
    if (error) {
        self.writeBlock(NO, error);
    }else{
        self.writeBlock(YES, nil);
    }
//    NSLog(@"//手机给外设的服务发送数据成功");

}


//以通知的形式接收外设的数据
//[peripheral setNotifyValue:YES forCharacteristic:charact];每调用一次这个方法，下面代理就好收到最后一次发的数据
//手机接收外设的数据有两种形式  1.手机主动去请求数据  2.外设可以主动给手机发数据
//下面属于第一种
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    NSLog(@"//以通知的形式接收外设的数据");//可以延迟接收最后一条数据
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         self.isConnected = YES;
         self.connectBlock(YES, nil);
    });
   
    
//    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:5 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        [blue getBattery];
//    }];

//   [self.delegate getData:characteristic.value];

    
}

//十六进制字符串转NSData
- (NSData *)convertHexStrToData:(NSString *)str {
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    
//    NSLog(@"hexdata: %@", hexData);
    return hexData;
}

//NSData转十六进制字符串
- (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}

@end
