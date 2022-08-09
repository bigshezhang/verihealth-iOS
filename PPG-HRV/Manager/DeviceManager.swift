//
//  DeviceManager.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/27.
//

import BaseFramework
import BleFramework
import CoreSDK
import Accelerate


class DeviceManager: NSObject, ObservableObject
{
    @Published var isScanningPublisher: Bool = false
    @Published var deviceDict = BleCentralManager.sharedInstance().scannedDeviceDict
    @Published var deviceArray = [VsDevice]()
    var tmpVsDevice = VsDevice()
    
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
        print("[发送的蓝牙信息] -> ", isMeasuring)
        var toMeasure = MyBleSendPacket(isMeasuring: UInt16(isMeasuring))
        
        let payData = NSData(bytes: &toMeasure, length: 2)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            TransferManager.sharedInstance().sendCommonMessage(device, msgId: UInt16(VS_SEND_MSG), data: payData as Data)
        }
    }
    
    public func getDeviceArray() -> [VsDevice] {
        for device in deviceDict{
            tmpVsDevice = device.value as! VsDevice
            deviceArray.append(tmpVsDevice)
        }
        return deviceArray
    }
}


extension DeviceManager: TransferManagerDelegate {
    func transUpdateBLEState(_ state: BLEStatus) {
        print("[更新蓝牙状态] -> ", BLEStatus.RawValue())
    }
    
    func transReceive(_ device: VsDevice) {
        print("[获取的蓝牙名称]-> ",device.name)
        if(device.name == userData.currentDeviceName){
            TransferManager.sharedInstance().connect(device)    //连接之前连接过的最后一个设备
        }
        userData.currDevice = device
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            userData.isDeviceConnected = true           //异步处理一下，防止主视图崩溃
        }
        sendCustomPack(device: device, isMeasuring: 1)
    }
        
    func transIsReady(_ device: Any) {
        print("[设备已准备好传输数据]")
    }
    
    func transReceiveMessage(_ transManager: TransferManager, device: Any, dataFrame frame: VsMessageFrame) {
        print("[信息框架id] -> ",frame.msg_id)
    }
    
    func transReceiveCustomMessage(_ transManager: TransferManager, device: Any, dataFrame frame: PayloadFrame) {
//        print("[收到自定义消息]")
        DispatchQueue.main.async {
            userData.isDeviceConnected = true   //收到消息就解除
        }
        
        if frame.payload != nil{
            let data: NSData = (frame.payload as NSData?)!
            var receivePack = MyBleRecPacket()
            data.getBytes(&receivePack, length: data.length)
            if receivePack.ret == 0 {
                print("[HRV返回了有效值] -> ", receivePack.sdnn)
                if userData.realTimeHRV.count < 31 {        //向HomeView中的实时HRV视图传值
                    DispatchQueue.main.async {
                        userData.realTimeHRV.append(Double(receivePack.sdnn))
                    }
                } else {
                    DispatchQueue.main.async {
                        userData.realTimeHRV.removeFirst()
                        userData.realTimeHRV.append(Double(receivePack.sdnn))
                    }
                }
                let currentCustomFilePath = FileTool().createRealtimeTxt(writeWhat: .custom)    //输出有效数据到Custom文件
                do {
                    let fileHandle = try FileHandle(forWritingTo: URL.init(string: currentCustomFilePath)!)
                    fileHandle.seekToEndOfFile()
                    try fileHandle.write(contentsOf: "\(receivePack.sdnn)\n".data(using: .utf8)!)
                    try fileHandle.close()
                } catch {
                    print(error)
                }
            } else {
                print("[收到了无效包]")
            }
            let currentRawFilePath = FileTool().createRealtimeTxt(writeWhat: .raw)        //输出Raw数据到文件
            
            var rawData = [UInt16]()      //  解构元组（swift将C中数组强制转换为了元组
            let mirror = Mirror(reflecting: receivePack.data)
            for (label, value) in mirror.children {
                rawData.append(value as! UInt16)
            }
            
            do {
                let fileHandle = try FileHandle(forWritingTo: URL.init(string: currentRawFilePath)!)
                fileHandle.seekToEndOfFile()
                try fileHandle.write(contentsOf: "\(rawData.prefix(Int(receivePack.size)))\n".data(using: .utf8)!)
                try fileHandle.close()
            } catch {
                print(error)
            }
        }
    }
}
