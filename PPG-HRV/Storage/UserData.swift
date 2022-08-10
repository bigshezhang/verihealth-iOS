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
import BaseFramework
  

final class UserData: ObservableObject {
    var currDevice = VsDevice()
    @Published var isDeviceConnected: Bool = false
    @Published var realTimeHRV : [Double] = [0,0]
    @Published var realTimeHR : [Double] = [0,0]
    @Published var realTimeSpo2 : [Double] = [0,0]
    @Published var lossRate = 0.0
    @Published var mistakeRate = 0.0
    
    
    @Published var isOnHand = false
    
    @AppStorage("todayDirPath") var todayDirPath: String = ""
    @AppStorage("isFirstInit") var isFirstInit: Bool = true
    @AppStorage("vsDeviceUUID") var vsDeviceUUID: String = ""
    @AppStorage("appSupportDir") var appSupportDir :String = getApplicationSupportDirectory()
    @AppStorage("appDocDir") var appDocDir :String = getDocumentDirectory()
    @AppStorage("currentDeviceName") var currentDeviceName : String = ""
}

var userData = UserData()
