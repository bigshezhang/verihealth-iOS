//
//  RealTimeView.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/26.
//

import SwiftUI
import SwiftUICharts

struct RealTimeView: View {
//    @State var realTimeData : [Double] = []
    @State var isLoading = true
//    func startTimer(){
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
//            isLoading = false
//            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
//                realTimeData.append(Double.random(in: 60..<80))
//                if realTimeData.count > 30 {
//                    realTimeData.removeFirst()
//                }
//                //这里异步获取心率会有问题，体现为重返视图后多异步重叠
//            }
//        }
//    }
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .foregroundColor(.white)
                
            GeometryReader{ GeometryProxy in
                ZStack{
                    LineView(data: userData.realTimeHRV, title: "实时HRV")
                        .padding()
        //                .padding()

                    VStack{
                        HStack(){
                            Spacer()
                            Spinner()
                                .opacity(isLoading ? 1 : 0)
                                .animation(.spring(), value: isLoading)
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
                                .opacity(isLoading ? 0 : 1)
                                .animation(.spring(), value: isLoading)
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

struct RealTimeView_Previews: PreviewProvider {
    static var previews: some View {
        RealTimeView()
    }
}
