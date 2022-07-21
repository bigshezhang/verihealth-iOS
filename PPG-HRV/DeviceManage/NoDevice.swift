//
//  NoDevice.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/20.
//

import SwiftUI
import BaseFramework
import BleFramework
import CoreSDK

struct NoDevice: View {
    var currDevice = VsDevice()
    func connectDevice() -> Void {
        ConnectionAdapter.sharedInstance().connect(currDevice)
    }

    var body: some View {
        Text("233")
            .onAppear{
                connectDevice()
            }
    }
}




struct NoDevice_Previews: PreviewProvider {
    static var previews: some View {
        NoDevice()
    }
}
