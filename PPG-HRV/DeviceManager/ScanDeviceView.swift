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
    @Environment(\.presentationMode) var presentationMode

    private let scanDevices = {
        ScanDevices()
    }()

    var body: some View {
        ZStack {
            VStack{
//                Recording(isScaning: self.$isScaning, recording: true)
            }
            VStack(spacing: 50){
                Text(isScaning ? "寻找设备中" : "\(device.name)")
                    .foregroundColor(.white)
            }
            .onAppear{
//                startScan()
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

class ScanDevices: NSObject, ObservableObject
{
    @Published var isScanningPublisher: Bool = false
    let transferManager : TransferManager = {
        TransferManager()
    }()
    
    override init() {
        super.init()
        transferManager.addDelegate(self)
    }
    
    public func startScan() {
        isScanningPublisher = true
        transferManager.scanDevices { error in
            print("[启动蓝牙是否错误] -> ", error)
        }
    }
//
//    public func stop() {
//        isScanningPublisher = false
//        if central.isScanning {
//            central.stopScan()
//        }
//    }
}

extension ScanDevices: TransferManagerDelegate {
    func transUpdateBLEState(_ state: BLEStatus) {
    }
    
    func transReceive(_ device: VsDevice) {
        print("[获取的蓝牙名称]-> ",device.name)
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
