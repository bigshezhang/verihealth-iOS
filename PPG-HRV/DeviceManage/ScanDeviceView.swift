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
    
    
    
    var body: some View {
        Button {
            
            ConnectionAdapter.sharedInstance().startScan(false) { error in  //  初次启动蓝牙电源状态可能不对，1秒后再次尝试
                DispatchQueue.main.asyncAfter(deadline: .now()+1){
                    ConnectionAdapter.sharedInstance().startScan(false) { error in
                    print(error)
                }
            }
            }
            
//            ScanDevices().transReceive(VsDevice())
//            print(ConnectionAdapter.sharedInstance().)
            userData.currDevice = TransferManager.sharedInstance().getScanedDevice(byName: "")!
            print(userData.currDevice)
        } label: {
            Text("开始扫描")
        }
        .onAppear{
            ConnectionAdapter.sharedInstance().startScan(false) { error in  //  初次启动蓝牙电源状态可能不对，1秒后再次尝试
                DispatchQueue.main.asyncAfter(deadline: .now()+1){
                    ConnectionAdapter.sharedInstance().startScan(false) { error in
                    print(error)
                }
            }
            }
        }

    }
}

class ScanDevices: NSObject{
    func byDefault(){
        print("233")
    }
}

extension ScanDevices: TransferManagerDelegate
{
    
}



struct ScanDeviceView_Previews: PreviewProvider {
    static var previews: some View {
        ScanDeviceView()
    }
}
