//
//  TodayView.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/8/11.
//

import SwiftUI
import PlotUI

struct TodayView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack{
            VStack{
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width: 400,height: 60)
                    .shadow(color: Color(hex: "#8ea7fd").opacity(0.3),radius: 5, y:8)
                    .overlay(
                        ZStack{
                            Text("Today")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(Color(hex: "#8ea7fd"))
                            
                            HStack{
                                Button(action: {self.presentationMode.wrappedValue.dismiss()}, label: {Image(systemName: "arrow.left").foregroundColor(Color("HomeTitleColor"))})
                                    .padding(.leading, 30)
                                Spacer()
                            }
                        }

//                            .offset(y: 18)
                    )
                Spacer()
            }
            
            ScrollView{
                TodayCardView()
                    .shadow(color: Color(hex: "#8ea7fd").opacity(0.3),radius: 5, y: 1)
                    .padding(.top,100)
                TodaySpo2CardView()
 
            }
        }
//        .ignoresSafeArea()
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
//        .navigationBarItems(leading: Button(action: {self.presentationMode.wrappedValue.dismiss()}, label: {Image(systemName: "arrow.left").foregroundColor(Color("HomeTitleColor"))}).padding(.bottom, 10).padding(.leading, 10).scaleEffect(0.8))
    }
    
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
