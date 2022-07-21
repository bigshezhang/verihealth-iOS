//
//  FindDeviceView.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/20.
//

import SwiftUI
import BaseFramework
import BleFramework
import CoreSDK

var currDevice = VsDevice()


struct FindDeviceView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var viewRouter: ViewRouter
    
//    var currDevice = VsDevice()
    func connectDevice() -> Void {
        ConnectionAdapter.sharedInstance().connect(currDevice)
    }
    
    var body: some View {

        Button {
            userData.isDeviceConnected = true
            viewRouter.currentPage = .Home
            connectDevice()
            
        } label: {
            Circle()
        }

    }
}

struct FindDeviceView_Previews: PreviewProvider {
    static var previews: some View {
        FindDeviceView()
    }
}
