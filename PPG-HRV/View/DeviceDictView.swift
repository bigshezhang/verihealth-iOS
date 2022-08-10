//
//  DeviceDictView.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/8/8.
//

import SwiftUI
import CoreSDK
import BleFramework

struct DeviceDictView: View {
    @EnvironmentObject var viewRouter : ViewRouter
    @State var deviceArray = DeviceManager().getDeviceArray()
    @State var freshTimes = 5
    @State var isTimerValid = false
    @State var isScaning = true
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        if isScaning{
            ZStack {
                VStack{
                    Recording(recording: true)
                }
                VStack(spacing: 50){
                    Text("寻找设备中")
                        .foregroundColor(.white)
                }
                .onAppear{
                    viewRouter.isTabBarShow = false
                }
                .onDisappear{
                    viewRouter.isTabBarShow = true
            }
            }
            .onAppear{
                    isTimerValid = true
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                        if !isTimerValid {
                            print("[更新定时器已销毁]")
                            timer.invalidate()
                        } else {
                            deviceArray = DeviceManager().getDeviceArray()
//                            print("[更新设备列表中]")
                            if deviceArray.count != 0{
                                isScaning = false
                            }
                        }
                    }
                }
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {self.presentationMode.wrappedValue.dismiss()}, label: {Image(systemName: "arrow.left").foregroundColor(.blue)}))
            .edgesIgnoringSafeArea(.top)
        } else {
            List{
                ForEach(deviceArray, id: \.self){ device in
                    Button {
                        TransferManager.sharedInstance().connect(device)
                        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                            if device.connected {
                                print("[连接了该设备] -> ", device.name)
                                userData.currentDeviceName = device.name
                                userData.isDeviceConnected = true
                                timer.invalidate()
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    } label: {
                        Text(device.name)
                    }
                }
            }
            .padding(.top, 30)
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {self.presentationMode.wrappedValue.dismiss()}, label: {Image(systemName: "arrow.left").foregroundColor(.blue)}))
            .edgesIgnoringSafeArea(.top)
            .onDisappear{
                isTimerValid = false
            }
        }
    }
}

struct DeviceCellView: View{
    private var device : VsDevice
    var body: some View{
        HStack{
            Text(device.name)
        }
    }
}


struct DeviceDictView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceDictView()
            .environmentObject(ViewRouter())
    }
}
