//
//  Toast.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/8/10.
//

import SwiftUI
import AlertToast


struct Toast: View {
    @State private var showToast = false
    var body: some View {
        VStack{

                   Button("Show Toast"){
                        showToast.toggle()
                   }
               }
        .toast(isPresenting: $showToast){
            
            // `.alert` is the default displayMode
            AlertToast(type: .regular, title: "Message Sent!")
        }
    }
}

struct Toast_Previews: PreviewProvider {
    static var previews: some View {
        Toast()
    }
}
