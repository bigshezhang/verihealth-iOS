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
    private let deviceManager = {
        DeviceManager()
    }()
    
    var body: some Scene {
        WindowGroup {
            var viewRouter = ViewRouter()
            if userData.isFirstInit{
                SplashScreen()
                    .environmentObject(viewRouter)
            } else {
                RouterView()
                    .onAppear{
                        FileTool().createTodayDir()     //创建当天的信息收集文件夹
                        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                            deviceManager.startScan()
                        }

                    }
                    .environmentObject(viewRouter)
            }
        }
    }
}
