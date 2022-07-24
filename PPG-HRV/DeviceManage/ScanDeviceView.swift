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

    var delegate: TransferManagerDelegate = ScanDevices()
    
    var body: some View {
        Button {
            delegate.bindDeviceArray
        } label: {
            Text("尝试连接")
                .onAppear {
                    ConnectionAdapter.sharedInstance().startScan(false) { error in
                        print(error)
                        DispatchQueue.main.asyncAfter(deadline: .now()+1){
                            ConnectionAdapter.sharedInstance().startScan(false) { error in
                                print(error)
                            }
                        }
                    }
                }
        }

    }
}

class ScanDevices: NSObject, TransferManagerDelegate
{
    func transReceive(_ device: VsDevice) {
        print(device.address)
    }
}


struct ScanDeviceView_Previews: PreviewProvider {
    static var previews: some View {
        ScanDeviceView()
    }
}
