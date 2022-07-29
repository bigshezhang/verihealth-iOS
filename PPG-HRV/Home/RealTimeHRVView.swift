//
//  RealTimeView.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/26.
//

import SwiftUI
import SwiftUICharts

struct RealTimeHRVView: View {
    @ObservedObject var mydata = userData
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .foregroundColor(.white)
                
            GeometryReader{ GeometryProxy in
                ZStack{
                    LineView(data: mydata.realTimeHRV, title: "实时HRV")
                        .padding()
                    VStack{
                        HStack(){
                            Spacer()
                            ZStack{
                                HStack{
                                    Spacer()
                                    Spinner()
                                        .frame(width: 30,height: 30)
                                        .opacity(mydata.isDeviceConnected ? 0 : 1)
                                        .animation(.spring(), value: mydata.isDeviceConnected)
                                        .padding(.trailing, 20)
                                        .padding(.top, 20)
                                }
                                Text("当前的HRV：\(Int(mydata.realTimeHRV.last!))")
                                        .font(.system(size: 14))
                                        .opacity(mydata.isDeviceConnected ? 1 : 0)
                                        .animation(.spring(), value: mydata.isDeviceConnected)
                                        .padding(.top, 40)
                                        .padding(.trailing)
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}

struct RealTimeView_Previews: PreviewProvider {
    static var previews: some View {
        RealTimeHRVView()
    }
}
