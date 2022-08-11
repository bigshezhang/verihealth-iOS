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
            let viewRouter = ViewRouter()
            RouterView()
                .onAppear{
                    heart_rate_init_api()
                    FileTool().createTodayDir()     //创建当天的信息收集文件夹
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: deviceManager.startScan)
                    FakeDataGenerator().chartDataGenerator()
                }
                .environmentObject(viewRouter)
        }
    }
}
