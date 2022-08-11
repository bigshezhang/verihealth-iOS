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
            NavigationView{
                HomeView()
                    .onAppear{
                        heart_rate_init_api()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: deviceManager.startScan)
    //                    FakeDataGenerator().chartDataGenerator()  //一个假数据生成器，或许方便UI测试
                    }
            }
            .navigationBarBackButtonHidden()
            .navigationTitle("")
        }
    }
}
