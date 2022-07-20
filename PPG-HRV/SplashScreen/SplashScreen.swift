//
//  SplashScreen.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/19.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isPressed = false
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        ZStack {
            VStack(){
                Image("SplashTop")
                    .resizable(resizingMode: .stretch)
                    .edgesIgnoringSafeArea(.all)
                    .padding(-10)
                    .offset(y: isPressed ? -400 : 0)
                    .opacity(isPressed ? 0 : 1)
                    .animation(Animation.default.speed(0.5), value: isPressed)
                
                
                //是否需要添加折线图
                
                Image("SplashBottom")
                    .resizable(resizingMode: .stretch)
                    .edgesIgnoringSafeArea(.all)
                    .offset(y: isPressed ? 400 : 0)
                    .opacity(isPressed ? 0 : 1)
                    .animation(Animation.default.speed(0.5), value: isPressed)
                
            }

            
            VStack{
                Button {
                    isPressed = true
                    userData.isFirstInit = false
                } label: {
                    Circle()
                        .frame(width: 160)
                        .foregroundColor(.white)
                        .overlay(
                            Circle()
                                .foregroundColor(Color("SplashButton"))
                                .frame(width: 150)
                                .overlay(
                                    Text("Your Heart \n My things")
                                        .font(.system(size: 22))
                                        .foregroundColor(.white)
                                )
                        )
                        .shadow(radius: 20, x: 20, y: 20)
                        .opacity(isPressed ? 0 : 1)
                        .animation(Animation.default.speed(0.5), value: isPressed)
                }
                
            }
        }
    }
}



struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
