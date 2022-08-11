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
            print("[启动蓝牙是否错误] -> ", error as Any)
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
    
    func transUpdateConnectionState(_ transManager: TransferManager, device: Any, newState state: Bool) {
        if state {
            userData.isDeviceConnected = true
        } else {
            userData.isDeviceConnected = false
        }
    }
    
    func transReceive(_ device: VsDevice) {
        print("[获取到一个VS设备]-> ",device.name as Any)
    }
        
    
    func transIsReady(_ device: Any) {
        print("[设备已准备好传输数据]")
    }
    
    func transReceiveMessage(_ transManager: TransferManager, device: Any, dataFrame frame: VsMessageFrame) {
        print("[信息框架id] -> ",frame.msg_id)
    }
    
    func transReceiveCustomMessage(_ transManager: TransferManager, device: Any, dataFrame frame: PayloadFrame) {
        DispatchQueue.main.async {
            userData.isDeviceConnected = true   //收到消息就判定为已连接
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
                            userData.realTimeSpo2.append(Int(receivePack.spo2))
                            DataBaseManager().writeData(type: DATA_TYPE_SPO2,value: Int32(userData.realTimeSpo2.last!))
                        } else {
                            userData.realTimeSpo2.removeFirst()
                            userData.realTimeSpo2.append(Int(receivePack.spo2))
                            DataBaseManager().writeData(type: DATA_TYPE_SPO2,value: Int32(userData.realTimeSpo2.last!))
                        }
                    }
                } else {
                    if receivePack.loss > 100{
                        receivePack.loss = 100
                    }
                    if receivePack.wrong > 100{
                        receivePack.wrong = 100
                    }
                    receivePack.loss = 100 - receivePack.loss
                    DispatchQueue.main.async{
                        userData.lossRate = Double(receivePack.loss) / 100.0
                        userData.mistakeRate = Double(receivePack.wrong) / 100.0
                        print("[loss] -> ", receivePack.loss)
                        print("[mistake] -> ", receivePack.wrong)
                    }
                }
            }
            
        case 10001:
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
            
        case 10002:                                 //获得了原始数据
            if frame.payload != nil{
                let data: NSData = (frame.payload as NSData?)!
                var receivePack = RawDataPacket()
                data.getBytes(&receivePack, length: data.length)
//                print("[获得了原始数据] -> ", receivePack.data)
                HeartRateCalc(receivePack: receivePack)
            }

        default : break
        }
    }
    
}
