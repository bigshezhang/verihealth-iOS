//
//  TodayView.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/8/11.
//

import SwiftUI
import CoreSDK

struct TodayView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack{
            Color(hex: "#f5f6fa")
                .ignoresSafeArea()
            
            ScrollView{
                VStack(){
                    TodaySpo2CardView()
                        .scaleEffect(1.11)
                        .padding(.bottom, 27)
                    TodayCardView(type: DATA_TYPE_HR)
                        .shadow(color: Color(hex: "#e4e8f7"), radius: 5, x: 5, y: 5)
                        .overlay(
                            VStack{
                                HStack{
                                    Text("Today HR")
                                        .foregroundColor(Color("HomeTitleColor"))
                                        .padding(.leading, 85)
                                    Spacer()
                                }
                                Spacer()
                            }
                        )
                    TodayCardView(type: DATA_TYPE_HRV)
                        .shadow(color: Color(hex: "#e4e8f7"), radius: 5, x: 5, y: 5)
                        .overlay(
                            VStack{
                                HStack{
                                    Text("Today HRV")
                                        .foregroundColor(Color("HomeTitleColor"))
                                        .padding(.leading, 85)
                                    Spacer()
                                }
                                Spacer()
                            }
                        )
                }
                .padding(.top, 50)
            }
            .padding(.top, 40)
            VStack{
                Rectangle()
                    .foregroundColor(Color(hex: "#f5f6fa"))
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
                    )
                Spacer()
            }
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
