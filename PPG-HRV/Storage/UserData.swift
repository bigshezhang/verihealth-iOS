//
//  UserData.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/19.
//

import Foundation
import SwiftUI

final class UserData: ObservableObject {
    @AppStorage("isFirstInit") var isFirstInit: Bool = true
    @AppStorage("isDeviceConnected") var isDeviceConnected: Bool = false

}
