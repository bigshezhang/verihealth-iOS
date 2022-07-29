//
//  RouterView.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/20.
//

import SwiftUI
import UIKit

struct RouterView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var selection = 1
    @State var createFileError = String()
    var body: some View {
        NavigationView {
            ZStack{
                ScrollView(){
                    switch viewRouter.currentPage{
                    case .Home: HomeView()
                    case .Page1: HistoryHRVView()
                    case .Page2: ProfileView()
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
