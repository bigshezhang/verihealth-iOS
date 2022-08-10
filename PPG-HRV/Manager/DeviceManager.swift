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
    
//    public func sendCustomPack(device: VsDevice, isMeasuring: Int){
//        print("[发送的蓝牙信息] -> ", isMeasuring)
//        var toMeasure = MyBleSendPacket(isMeasuring: UInt16(isMeasuring))
//
//        let payData = NSData(bytes: &toMeasure, length: 2)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
//            TransferManager.sharedInstance().sendCommonMessage(device, msgId: UInt16(VS_SEND_MSG), data: payData as Data)
//        }
//    }
    
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
        print("[获取到一个的Vs设备]-> ",device.name)
        if(device.name == userData.currentDeviceName){
            TransferManager.sharedInstance().connect(device)    //连接之前连接过的最后一个设备
//            Timer(timeInterval: 1, repeats: true) { timer in
//                if device.connected {
//                    self.sendCustomPack(device: device, isMeasuring: 1)
//                    DispatchQueue.main.async {
//                        userData.currentDeviceName = device.name
//                        userData.isDeviceConnected = true
//                    }
//                    timer.invalidate()
//                }
//            }
        }
//        userData.currDevice = device
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
//            userData.isDeviceConnected = true           //异步处理一下，防止主视图崩溃
//        }
    }
        
    func transIsReady(_ device: Any) {
        print("[设备已准备好传输数据]")
    }
    
    func transReceiveMessage(_ transManager: TransferManager, device: Any, dataFrame frame: VsMessageFrame) {
        print("[信息框架id] -> ",frame.msg_id)
    }
    
    func transReceiveCustomMessage(_ transManager: TransferManager, device: Any, dataFrame frame: PayloadFrame) {
        DispatchQueue.main.async {
            userData.isDeviceConnected = true   //收到消息就解除
        }

        switch frame.opcode{
        case 10000:                                 //收到Spo2的包
            if frame.payload != nil{
                let data: NSData = (frame.payload as NSData?)!
                var receivePack = ResultPacket()
                data.getBytes(&receivePack, length: data.length)
                
                if receivePack.ret == 0{
                    DispatchQueue.main.async {
                        if userData.realTimeSpo2.count < 30 {
                            userData.realTimeSpo2.append(Double(receivePack.spo2) / 100.0)
                        } else {
                            userData.realTimeSpo2.removeFirst()
                            userData.realTimeSpo2.append(Double(receivePack.spo2) / 100.0)
                        }
                        userData.lossRate = Double(receivePack.loss) / 100.0
                        userData.mistakeRate = Double(receivePack.wrong) / 100.0
                    }
                    print("[OP 10000] -> ", receivePack.spo2)
                }
            }
        case 10001:                                 //获得了原始数据
            if frame.payload != nil{
                let data: NSData = (frame.payload as NSData?)!
                var receivePack = RawDataPacket()
                data.getBytes(&receivePack, length: data.length)

            }
        case 10002:
            if frame.payload != nil{
                let data: NSData = (frame.payload as NSData?)!
                var receivePack = LodPacket()
                data.getBytes(&receivePack, length: data.length)
                
                if receivePack.status == 0{
                    DispatchQueue.main.async {
                        userData.isOnHand = false
                    }
                } else {
                    DispatchQueue.main.async {
                        userData.isOnHand = true
                    }
                }
            }
            
        default : break
        }
        
        
//        if frame.payload != nil{
//            let data: NSData = (frame.payload as NSData?)!
//            var receivePack = ResultPacket()
//            data.getBytes(&receivePack, length: data.length)
//
//            if receivePack.ret == 0{
//                userData.realTimeSpo2.append(Double(receivePack.spo2))
//            }
////            HeartRateCalc(receivePack: receivePack)
//        }
    }
    
}
