//
//  RealTimeView.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/26.
//

import SwiftUI
import SwiftUICharts

struct RealTimeView: View {
    @ObservedObject var MyData = userData
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .foregroundColor(.white)
                
            GeometryReader{ GeometryProxy in
                ZStack{
                    LineView(data: MyData.realTimeHRV, title: "实时HRV")
                        .padding()
        //                .padding()

                    VStack{
                        HStack(){
                            Spacer()
                            Spinner()
                                .opacity(MyData.isDeviceConnected ? 0 : 1)
                                .animation(.spring(), value: MyData.isDeviceConnected)
                                .padding(.trailing, 20)
                                .padding(.top, 20)
                        }
                        Spacer()

                    }
                    
                    VStack{
                        HStack(){
                            Spacer()
                            Text("仅保留最近半分钟心率")
                                .font(.system(size: 10))
                                .opacity(MyData.isDeviceConnected ? 1 : 0)
                                .animation(.spring(), value: MyData.isDeviceConnected)
                                .padding(.trailing, 20)
                                .padding(.top, 20)
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}

//struct RealTimeView_Previews: PreviewProvider {
//    static var previews: some View {
//        RealTimeView()
//    }
//}
