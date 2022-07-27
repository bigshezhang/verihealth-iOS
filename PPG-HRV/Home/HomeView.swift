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
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        ZStack{
            Image("HomeBG")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
                .scaleEffect()   //图片问题，去除白边
  
            
            VStack{
                HStack{
                    if !userData.isDeviceConnected{
                        NavigationLink {
                            ScanDeviceView()
                        } label: {
                            Capsule()
                                .frame(width:240, height: 45)
                                .padding(.leading, 34)
                                .foregroundColor(Color("HomeTopBar"))
                                .opacity(0.2)
                                .overlay(Text("点击以连接设备").foregroundColor(.white).padding(.leading,34))
                        }
                        Spacer()
                    } else {
                        Capsule()
                            .frame(width:240, height: 45)
                            .padding(.leading, 34)
                            .foregroundColor(Color("HomeTopBar"))
                            .opacity(0.2)
                            .overlay(Text(userData.currDevice.name).foregroundColor(.white).padding(.leading,34))
                        Spacer()
                    }
                    
                    Circle()
                        .frame(height: 45)
                        .overlay(Circle().foregroundColor(Color("HomeAvatar")).frame(height: 40))
                        .padding(.trailing, 45)
                        .foregroundColor(.white)
                }
                .padding(.top, 40)
                
                HStack {
                    VStack(alignment: .leading){
                        Text("My Master")
                            .font(.system(size: 21,weight: .medium))
                            .foregroundColor(.white)
                        Text("Have a nice day")
                            .font(.system(size: 17,weight: .regular))
                            .foregroundColor(.white)
                    }
                    .padding(.leading,34)
                    .padding(.top, 38)
                    
                    Spacer()
                }
                
                RealTimeView()
                    .overlay(
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color.white)
                                .opacity((userData.currDevice.name == nil) ? 0.8 : 0)
                            Text("请连接设备后查看实时HRV")
                                .opacity((userData.currDevice.name == nil) ? 1 : 0)
                                .foregroundColor(Color.gray)
                        }
                    )
                    .frame(width: 350, height: 400)
                    .padding(.top, 100)
                
                Spacer()
            }
            .padding(.top, 10)
        }
    }
}

struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(UserData())
            .environmentObject(ViewRouter())
    }
}
