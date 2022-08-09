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
import LineChartView
  

final class UserData: ObservableObject {
    var currDevice = VsDevice()
    @Published var isDeviceConnected: Bool = false
    @Published var realTimeHRV : [Double] = [0,0]
    @Published var realTimeHR : [Double] = [0,0]
    
    @Published var hrChartData = [LineChartData(0.0),LineChartData(10.0),LineChartData(30.0),LineChartData(10.0),LineChartData(10.0),LineChartData(10.0),LineChartData(10.0)]
    
    @Published var hrvChartData = [LineChartData(0.0)]
        
    @AppStorage("todayDirPath") var todayDirPath: String = ""
    @AppStorage("isFirstInit") var isFirstInit: Bool = true
    @AppStorage("vsDeviceUUID") var vsDeviceUUID: String = ""
    @AppStorage("appSupportDir") var appSupportDir :String = getApplicationSupportDirectory()
    @AppStorage("appDocDir") var appDocDir :String = getDocumentDirectory()
    @AppStorage("currentDeviceName") var currentDeviceName : String = ""
    
    
}

var userData = UserData()
