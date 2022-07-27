//
//  ScanDevice.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/24.
//

import SwiftUI
import UIKit
import BaseFramework
import BleFramework
import CoreSDK

struct ScanDeviceView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var viewRouter: ViewRouter
    @State var device = VsDevice()
    @State var isScaning = true
    @State var rollStep = 0
//    var delegate: TransferManagerDelegate = ScanDevices()
    @Environment(\.presentationMode) var presentationMode
    
    func startScan(){
        ConnectionAdapter.sharedInstance().startScan(true) { error in
            print("[启动扫描错误信息 -> ]", error)
        }
        
        ConnectionAdapter.sharedInstance().startScan(true) { error in
            print("[启动扫描错误信息 -> ]", error)
        }
        
        while device.name == nil {
            ScanDevices().transReceive(device)
        }
        
        print("找到了设备")
        
//        ConnectionAdapter.sharedInstance().startScan(false) { error in
//            print("[第一次开启蓝牙扫描是否出错]-> ",error)
//            ScanDevices().transReceive(device)//通过委托模式获取VsDevice实例
//            print("[第一次读到的设备名字] ->",device.name)   //再启动一次蓝牙扫描，这时应该成功启动
//            if device.name != nil{
//                userData.currDevice = device
//                userData.isDeviceConnected = true
//                //冷启动蓝牙扫描，可能尚未powerup
//            }
//
//            DispatchQueue.main.asyncAfter(deadline: .now()+1){
//                ConnectionAdapter.sharedInstance().startScan(false) { error in
//                    print("[第二次开启蓝牙扫描是否出错]-> ",error)    //冷启动蓝牙扫描，可能尚未powerup
//                }
//                ScanDevices().transReceive(device)//通过委托模式获取VsDevice实例
//                print("[第二次读到的设备名字] ->",device.name)   //再启动一次蓝牙扫描，这时应该成功启动
//                if device.name != nil{
//                    isScaning = false
//                    TransferManager().connect(device) //连接设备！
//                    userData.currDevice = device
//                    userData.isDeviceConnected = true
//                    startTransfer() //开始传输数据！
//                }
//            }
//
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3){
//                while (device.uuid == nil){
//                      print("尚未获取到设备")
//                  }
//                  print("设备连接完成")
//            }
//        }
    }
    
    func startTransfer(){
        ScanDevices().transIsReady(device)
        ScanDevices().transReceiveMessage(TransferManager.sharedInstance(), device: device, dataFrame: VsMessageFrame())
    }
    
    var body: some View {
        ZStack {
            VStack{
                Recording(isScaning: self.$isScaning, recording: true)
            }
            VStack(spacing: 50){
                Text(isScaning ? "寻找设备中" : "\(device.name)")
                    .foregroundColor(.white)
            }
            .onAppear{
                startScan()
                print("[是否连接]-> ",userData.isDeviceConnected)
                viewRouter.isTabBarShow = false
            }
            .onDisappear{
                viewRouter.isTabBarShow = true
        }
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {self.presentationMode.wrappedValue.dismiss()}, label: {Image(systemName: "arrow.left").foregroundColor(.blue)}))
        .edgesIgnoringSafeArea(.top)
    }
}

class ScanDevices: NSObject, TransferManagerDelegate
{
    func transReceive(_ device: VsDevice) {
//        print("[获取的蓝牙地址]-> ",device.address)
    }
    
    func transIsReady(_ device: Any) {
        print("[设备已准备好传输数据]")
    }
    
    func transReceiveMessage(_ transManager: TransferManager, device: Any, dataFrame frame: VsMessageFrame) {
        print("[信息框架id -> ]",frame.msg_id)
    }
}


struct ScanDeviceView_Previews: PreviewProvider {
    static var previews: some View {
        ScanDeviceView()
            .environmentObject(ViewRouter())
            .environmentObject(UserData())
    }
}
