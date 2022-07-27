//
//  PPG_HRVApp.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/19.
//

import SwiftUI
import UIKit
import BaseFramework
import BleFramework
import CoreSDK

@main
struct PPG_HRVApp: App {
    private let scanDevices = {
        ScanDevices()
    }()
    
    var body: some Scene {
        WindowGroup {
            var userData = UserData()
            var viewRouter = ViewRouter()
            if userData.isFirstInit{
                SplashScreen()
                    .environmentObject(userData)
                    .environmentObject(viewRouter)
            } else {
                RouterView()
                    .onAppear{
                        scanDevices.startScan()
                    }
                    .environmentObject(viewRouter)
                    .environmentObject(userData)
            }
        }
    }
}
