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
    var body: some View {
        VStack{
            NavigationLink {
                FindDeviceView()
            } label: {
                Capsule()
                    .frame(width:240, height: 45)
                    .padding(.trailing, 60)
                    
            }
            Spacer()
        }
    }
}

struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
