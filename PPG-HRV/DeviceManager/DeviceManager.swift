//
//  DeviceManager.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/27.
//

import BaseFramework
import BleFramework
import CoreSDK

class DeviceManager: NSObject, ObservableObject
{
    @Published var isScanningPublisher: Bool = false
    
    override init() {
        super.init()
        TransferManager.sharedInstance().addDelegate(self)
    }
    
    deinit {
        TransferManager.sharedInstance().removeDelegate(self)
    }
    
    public func startScan() {
        isScanningPublisher = true
        TransferManager.sharedInstance().scanDevices { error in
            print("[启动蓝牙是否错误] -> ", error)
        }
    }
    
    public func sendCustomPack(device: VsDevice, isMeasuring: Int){
        var toMeasure = MyBleSendPacket(isMeasuring: UInt16(isMeasuring))
        
        let payData = NSData(bytes: &toMeasure, length: 2)
        
        TransferManager.sharedInstance().sendCommonMessage(device, msgId: UInt16(VS_SEND_MSG), data: payData as Data)
    }
    
}


extension DeviceManager: TransferManagerDelegate {
    func transUpdateBLEState(_ state: BLEStatus) {
    }
    
    func transReceive(_ device: VsDevice) {
        print("[获取的蓝牙名称]-> ",device.name)
        TransferManager.sharedInstance().connect(device)    //连接设备
        sendCustomPack(device: device, isMeasuring: 1)
    }
    
    func transIsReady(_ device: Any) {
        print("[设备已准备好传输数据]")
    }
    
    func transReceiveMessage(_ transManager: TransferManager, device: Any, dataFrame frame: VsMessageFrame) {
        print("[信息框架id] -> ",frame.msg_id)
    }
    
    func transReceiveCustomMessage(_ transManager: TransferManager, device: Any, dataFrame frame: PayloadFrame) {
        print("[收到自定义消息] -> ")
        
        if frame.payload != nil{
            let data: NSData = (frame.payload as NSData?)!
            var receivePack = MyBleRecPacket()
            data.getBytes(&receivePack, length: data.length)
//            print("[收包Type] -> ", receivePack.type)
            print("[收包算法返回值] -> ", receivePack.ret)
        }
    }
}
