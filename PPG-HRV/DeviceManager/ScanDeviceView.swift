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


struct ScanDeviceView_Previews: PreviewProvider {
    static var previews: some View {
        ScanDeviceView()
            .environmentObject(ViewRouter())
            .environmentObject(UserData())
    }
}
