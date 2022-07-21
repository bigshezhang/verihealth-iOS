//
//  RouterView.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/20.
//

import SwiftUI
import UIKit

struct RouterView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State private var selection = 1
    
    var body: some View {
        NavigationView {
            ZStack{
                switch viewRouter.currentPage{
                case .Home: FindDeviceView()
                case .Page1: Page1()
                case .Page2: Page2()
                }
                VStack{
                    Spacer()
                    TabView()
                }
                .ignoresSafeArea()
            }
        }
    }
}

struct RouterView_Previews: PreviewProvider {
    static var previews: some View {
        RouterView()
            .environmentObject(ViewRouter())
            .environmentObject(UserData())
    }
}
