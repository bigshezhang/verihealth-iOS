//
//  FindDeviceView.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/20.
//

import SwiftUI

struct FindDeviceView: View {
    @EnvironmentObject var userData: UserData
 //   @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {

        Button {
            userData.isDeviceConnected = true
//            viewRouter.currentPage = .Home
        } label: {
            Circle()
        }

    }
}

struct FindDeviceView_Previews: PreviewProvider {
    static var previews: some View {
        FindDeviceView()
    }
}
