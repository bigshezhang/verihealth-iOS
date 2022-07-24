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
    var currDevice = VsDevice()
    @AppStorage("isFirstInit") var isFirstInit: Bool = true
    @AppStorage("isDeviceConnected") var isDeviceConnected: Bool = false
    @AppStorage("vsDeviceUUID") var vsDeviceUUID: String = ""
}