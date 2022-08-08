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
    @State var deviceArray = DeviceManager().getDeviceArray()
    @State var freshTimes = 5
    @State var isTimerValid = false
    
    var body: some View {
        
        ForEach(deviceArray, id: \.self){ device in
            Text(device.name)
        }
        .background(
            RoundedRectangle(cornerSize: CGSize(width: 5, height: 5))
                .foregroundColor(Color.white)
        )
        .onAppear{
            isTimerValid = true
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                if !isTimerValid {
                    print("[更新定时器已销毁]")
                    timer.invalidate()
                } else {
                    print("[更新设备列表中]")
                    deviceArray = DeviceManager().getDeviceArray()
                }
            }
        }
        .onDisappear{
            isTimerValid = false
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
    }
}
