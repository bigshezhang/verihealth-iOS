//
//  NewHomeView.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/8/8.
//

import SwiftUI
import SwiftUICharts
import Progress_Bar
import AlertToast

struct HomeView: View {
    @ObservedObject var myData = userData
    @EnvironmentObject var viewRouter: ViewRouter
        
    @State var toastState = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            HStack{
                Text("My Health")
                    .font(.system(size: 28))
                    .padding(30)
                    .foregroundColor(Color("HomeTitleColor"))
                Spacer()

                NavigationLink {
                    DeviceDictView()
                } label: {
                    Capsule()
                        .padding(.top, 30)
                        .padding(.bottom, 30)
                        .padding(.trailing, 30)
                        .opacity(0.05)
                        .foregroundColor(.black)
                        .overlay(Text(userData.isDeviceConnected ? userData.currentDeviceName : "点击连接设备") .padding(.trailing, 30).foregroundColor(.black))
                }
            }
            
            DataGlanceView()
            RealTimeChartView()
        }
        .toast(isPresenting: $toastState, duration: 2, tapToDismiss: true) {
            AlertToast(displayMode: .alert, type: .image("OnHand", .clear), subTitle: "触发穿戴检测")
        }
        .background(Color("HomeBgColor").ignoresSafeArea())
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ViewRouter())
    }
}
