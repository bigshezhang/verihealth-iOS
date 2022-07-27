//
//  DeviceManager.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/27.
//

import BaseFramework
import BleFramework
import CoreSDK

class ScanDevices: NSObject, ObservableObject
{
    @Published var isScanningPublisher: Bool = false
    
    override init() {
        super.init()
        TransferManager.sharedInstance().addDelegate(self)
    }
    
    public func startScan() {
        isScanningPublisher = true
        TransferManager.sharedInstance().scanDevices { error in
            print("[启动蓝牙是否错误] -> ", error)
        }
    }
}

extension ScanDevices: TransferManagerDelegate {
    func transUpdateBLEState(_ state: BLEStatus) {
    }
    
    func transReceive(_ device: VsDevice) {
        print("[获取的蓝牙名称]-> ",device.name)
        TransferManager.sharedInstance().connect(device)    //连接设备
    }
    
    func transIsReady(_ device: Any) {
        print("[设备已准备好传输数据]")
    }
    
    func transReceiveMessage(_ transManager: TransferManager, device: Any, dataFrame frame: VsMessageFrame) {
        print("[信息框架id -> ]",frame.msg_id)
    }
}
