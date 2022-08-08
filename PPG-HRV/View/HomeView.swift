//
//  HomeView.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/20.
//

import Foundation
import SwiftUI
import BaseFramework
import BleFramework

struct HomeView: View{
    @ObservedObject var MyData = userData
    @EnvironmentObject var viewRouter: ViewRouter
    @State var isShowDeviceDict = false
    
    var body: some View {
    ZStack{
        Color("HomeBgColor")
            .ignoresSafeArea()
        VStack{
            HStack{
                Button {
                    isShowDeviceDict = true
                } label: {
//                    Text(userData.isDeviceConnected ? "\(userData.currentDeviceName)" : "点击搜索设备")
                    Text("获取列表")
                }
            }
            
            Spacer()
        }
        .padding(.top, 10)
    }
    .sheet(isPresented: $isShowDeviceDict) {
        DeviceDictView()
    }
    }
}

struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ViewRouter())
    }
}
