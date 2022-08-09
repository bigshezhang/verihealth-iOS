//
//  RealTimeView.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/26.
//

import SwiftUI
import SwiftUICharts

struct RealTimeHRVView: View {
    @ObservedObject var myData = userData
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .foregroundColor(.white)
                
            GeometryReader{ GeometryProxy in
                ZStack{
                    LineView(data: myData.realTimeHRV, title: "实时HRV")
                        .padding()
                    VStack{
                        HStack(){
                            Spacer()
                            ZStack{
                                HStack{
                                    Spacer()
                                    Spinner()
                                        .frame(width: 30,height: 30)
                                        .opacity(myData.isDeviceConnected ? 0 : 1)
                                        .animation(.spring(), value: myData.isDeviceConnected)
                                        .padding(.trailing, 20)
                                        .padding(.top, 20)
                                }
                                
                                HStack{
                                    Spacer()
                                    Text("当前的HRV：\(Int(myData.realTimeHRV.last!))")
                                            .font(.system(size: 14))
                                            .opacity(myData.isDeviceConnected ? 1 : 0)
                                            .animation(.spring(), value: myData.isDeviceConnected)
                                            .padding(.top, 40)
                                            .padding(.trailing)
                                }
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
