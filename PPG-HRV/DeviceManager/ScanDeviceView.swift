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
    var delegate: TransferManagerDelegate = ScanDevices()
    @Environment(\.presentationMode) var presentationMode
    
    func startScan(){
        ConnectionAdapter.sharedInstance().startScan(false) { error in
            print("[第一次开启蓝牙扫描是否出错]-> ",error)
            delegate.transReceive?(device)//通过委托模式获取VsDevice实例
            print("[第一次读到的设备名字] ->",device.name)   //再启动一次蓝牙扫描，这时应该成功启动
            if device.name != nil{
                userData.currDevice = device
                userData.isDeviceConnected = true
                //冷启动蓝牙扫描，可能尚未powerup
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now()+1){
                ConnectionAdapter.sharedInstance().startScan(false) { error in
                    print("[第二次开启蓝牙扫描是否出错]-> ",error)    //冷启动蓝牙扫描，可能尚未powerup
                }
                delegate.transReceive?(device)//通过委托模式获取VsDevice实例
                print("[第二次读到的设备名字] ->",device.name)   //再启动一次蓝牙扫描，这时应该成功启动
                if device.name != nil{
                    userData.currDevice = device
                    userData.isDeviceConnected = true
                }
            }
        }
        
        if device.name != nil {
            isScaning = false
            TransferManager().connect(device)
        }
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
        print("[获取的蓝牙地址]-> ",device.address)
    }
}


struct ScanDeviceView_Previews: PreviewProvider {
    static var previews: some View {
        ScanDeviceView()
            .environmentObject(ViewRouter())
            .environmentObject(UserData())
    }
}
