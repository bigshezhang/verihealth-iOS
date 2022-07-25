//
//  PPG_HRVApp.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/19.
//

import SwiftUI

@main
struct PPG_HRVApp: App {
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
                    .environmentObject(viewRouter)
                    .environmentObject(userData)
            }
        }
    }
}
