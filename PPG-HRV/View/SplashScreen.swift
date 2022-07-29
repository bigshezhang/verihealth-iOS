//
//  SplashScreen.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/19.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isPressed = false
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        if userData.isFirstInit {
            ZStack {
                VStack(){
                    Image("SplashTop")
                        .resizable(resizingMode: .stretch)
                        .edgesIgnoringSafeArea(.all)
                        .padding(-10)
                        .offset(y: isPressed ? -400 : 0)
                        .opacity(isPressed ? 0 : 1)
                        .animation(Animation.default.speed(0.5), value: isPressed)
                    
                    Image("SplashBottom")
                        .resizable(resizingMode: .stretch)
                        .edgesIgnoringSafeArea(.all)
                        .offset(y: isPressed ? 400 : 0)
                        .opacity(isPressed ? 0 : 1)
                        .animation(Animation.default.speed(0.5), value: isPressed)
                    
                }

                Button {
                    isPressed = true
                    viewRouter.currentPage = .Home
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                        userData.isFirstInit = false
                    })
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
        } else {
            RouterView()
                .animation(.easeIn, value: userData.isFirstInit)
        }
    }
}



struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
