//
//  UserData.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/19.
//

import Foundation
import SwiftUI
import BleFramework
import CoreSDK

final class UserData: ObservableObject {
    @Published var currDevice = VsDevice()
    @Published var isDeviceConnected: Bool = false
    @State var realTimeHRV : [Double] = [0,0]
    
    @AppStorage("isFirstInit") var isFirstInit: Bool = true
    @AppStorage("vsDeviceUUID") var vsDeviceUUID: String = ""
//    @AppStorage("vsData") var vsData = [2,2]
}

var userData = UserData()
