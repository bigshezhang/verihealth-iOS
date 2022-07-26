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
    @State var isScaning = false
    @State var rollStep = 0
    var delegate: TransferManagerDelegate = ScanDevices()
    @Environment(\.presentationMode) var presentationMode
    
    func startScan(){
        
//
//        ConnectionAdapter.sharedInstance().startScan(false) { error in
//            isScaning.toggle()  //为了防止动画反着来只能用toggle
//            print("[第一次开启蓝牙扫描是否出错]-> ",error)    //冷启动蓝牙扫描，可能尚未powerup
//        }
        for i in 1...100 {
            ConnectionAdapter.sharedInstance().startScan(false) { error in
                print("[第\(i)次开启蓝牙扫描是否出错]-> ",error)        //再启动一次蓝牙扫描，这时应该成功启动
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+3){
                delegate.transReceive?(device)//通过委托模式获取VsDevice实例
                print("[读到的设备名字] ->",device.name)
                if device.name != nil{
                    userData.currDevice = device
                    userData.isDeviceConnected = true
                }
            }
        }
        
        if device.name != nil {
            TransferManager().connect(device)
        }
    }
    
    var body: some View {
        ZStack {
            VStack{
                Image("BG")
                    .resizable()
                    .frame(height: 707)
                    .scaledToFill()
                    .ignoresSafeArea()
                    .overlay(Image("Radio")
                        .rotationEffect(Angle.degrees(isScaning ? 360 : 0))
                        .animation(Animation.linear(duration: 20).repeatForever(autoreverses: false), value: isScaning)
                        .ignoresSafeArea()
                    )
                    .edgesIgnoringSafeArea(.top)
                
                Spacer()
            }

            VStack(spacing: 50){
                Text("寻找设备中")
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
        .navigationBarItems(leading: Button(action: {self.presentationMode.wrappedValue.dismiss()}, label: {Image("BackArrow")}))
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
