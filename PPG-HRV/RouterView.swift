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
//    @EnvironmentObject var viewRouter: ViewRouter
    
    @State private var selection = 1
    
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                Page1().tabItem {
                    NavigationLink(destination: Page1()) {
                        Image("clock")
                            .frame(height: 100)
                    }
                }
                .tag(0)
                HomeView().tabItem {
                    NavigationLink(destination: HomeView()) {
                        Image("home")
                    }
                }
                .tag(1)
                Page2().tabItem {
                    NavigationLink(destination: Page2()) {
                        Image("profile")
                    }
                }
                .tag(2)
            }

        }

//        .background(Color.black)

    }
}

struct RouterView_Previews: PreviewProvider {
    static var previews: some View {
        RouterView()
            .environmentObject(ViewRouter())
            .environmentObject(UserData())
    }
}
