//
//  RouterView.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/20.
//

import SwiftUI
import UIKit

struct RouterView: View {
//    @EnvironmentObject var userData: UserData
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State private var selection = 1
    
    var body: some View {
        NavigationView {
            ZStack{
                ScrollView(){
                    switch viewRouter.currentPage{
                    case .Home: HomeView()
                    case .Page1: Page1()
                    case .Page2: Page2()
                    }
                }
                VStack{
                    Spacer()
                    TabView()
                        .opacity(viewRouter.isTabBarShow ? 1 : 0)
                        .animation(.spring(), value: viewRouter.isTabBarShow)
                }
            }
            .edgesIgnoringSafeArea(.vertical)
        }
        .navigationTitle("")
//        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RouterView_Previews: PreviewProvider {
    static var previews: some View {
        RouterView()
            .environmentObject(ViewRouter())
//            .environmentObject(UserData())
    }
}
