//
//  HomeView.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/8/8.
//

import SwiftUI
import SwiftUICharts
import Progress_Bar
import AlertToast
import PopupView

struct HomeView: View {
    @ObservedObject var myData = userData
    @EnvironmentObject var viewRouter: ViewRouter
        
    @State var onHandToastState = false
    @State var connectedToastState = false
    @State var offHandToastState = false
    @State var disConnectToastState = false

    
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
        .onChange(of: myData.isOnHand, perform: { newValue in
            if myData.isOnHand {
                onHandToastState.toggle()
            } else {
                offHandToastState.toggle()
            }
        })
        .onChange(of: myData.isDeviceConnected, perform: { newValue in
            if myData.isDeviceConnected{
                connectedToastState.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.8){
                    connectedToastState.toggle()
                }
            } else {
                disConnectToastState.toggle()
            }
        })
        .toast(isPresenting: $onHandToastState, duration: 2, tapToDismiss: true) {
            AlertToast(displayMode: .alert, type: .image("OnHand", .clear), subTitle: "已穿戴设备")
        }       //穿戴检测True
        .popup(isPresented: $connectedToastState,type: .default){
            ConnectedToast()
                .background(
                    ZStack{
                        RoundedRectangle(cornerSize: CGSize(width: 50, height: 50))
                            .frame(width: 400,height: 400)
                            .foregroundColor(.white)
                    }
                )
                .frame(width: 200,height: 100)
                .scaleEffect(0.45)
        }   //连接状态True
        .toast(isPresenting: $offHandToastState, duration: 2){
            AlertToast(displayMode: .alert, type: .error(.red),subTitle: "未穿戴设备")
        }   //穿戴检测False
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
