
//  TabView.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/20.


import SwiftUI

struct TabView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var viewRouter: ViewRouter
    private var iconSize: CGFloat = 30
    var body: some View {
        ZStack {
            HStack(spacing: 70) {
                Spacer()
                
                TabBarIcon(IconName: "clock", tabName: "clock", width: iconSize, height: iconSize, color: .white, assignedPage: .Page1)

                TabBarIcon(IconName: "home", tabName: "home", width: iconSize, height: iconSize, color: .white, assignedPage: .Home)

                TabBarIcon(IconName: "profile", tabName: "profile", width: iconSize, height: iconSize, color: .white, assignedPage: .Page2)
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical)
            .background(Color.white)
        }

    }
}

struct TabBarIcon: View {
    let IconName, tabName: String
    let width, height: CGFloat
    let color: Color
    @EnvironmentObject var viewRouter: ViewRouter
    let assignedPage : Page

    var body: some View {
        VStack(spacing: 0){
            Image(IconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .foregroundColor(color)
        }
        .shadow(radius: 10,y: 5)
        .onTapGesture {
            viewRouter.currentPage = assignedPage
            print(viewRouter.currentPage)
        }
    }
}



struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView()
    }
}
