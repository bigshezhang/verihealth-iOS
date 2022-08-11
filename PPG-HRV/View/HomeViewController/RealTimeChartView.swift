//
//  RealTimeChartView.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/8/10.
//

import SwiftUI
import SwiftUICharts


struct RealTimeChartView: View {
    @ObservedObject var myData = userData

    var body: some View {
        VStack{
            HStack{
                Text("RealTime Data")
                    .font(.system(size: 17))
                    .foregroundColor(Color("HomeTitleColor"))
                    .padding(.leading, 30)
                
                Spacer()
                
                NavigationLink {
                    HistoryView()
                } label: {
                    Text("History")
                        .foregroundColor(Color(hex: "#6f8fea"))
                }


                Image(systemName: "arrow.right")
                    .padding(.trailing, 30)
                    .foregroundColor(Color("HomeTitleColor"))
            }
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 20){
                    CardView {
                        Text("Spo2")
                            .foregroundColor(Color("HomeTitleColor"))
                            .font(.system(size: 24))
                            .padding(10)
                        
                        ChartLabel((myData.realTimeSpo2.count == 2) ? "--%" : "\(Int(myData.realTimeSpo2.last!))%", type: .custom(size: 12, padding: .init(top: -10, leading: 10, bottom: 0, trailing: 0), color: Color("HomeTitleColor")))
                            .padding(.bottom, 15)
                       
                        ChartGrid {
                            LineChart()
                        }
                        .padding(.top, -15)
                    }
                    .data(myData.realTimeSpo2.map{Double($0)})
                    .chartStyle(ChartStyle(backgroundColor: .clear,
                                           foregroundColor: ColorGradient(.white, .red)))
                    .frame(width: 120,height: 200)
                    
                    CardView {
                        Text("HR")
                            .foregroundColor(Color("HomeTitleColor"))
                            .font(.system(size: 24))
                            .padding(10)
                        ChartLabel((myData.realTimeHR.count == 2) ? "--%" : "\(Int(myData.realTimeHR.last!))%", type: .custom(size: 12, padding: .init(top: -10, leading: 10, bottom: 0, trailing: 0), color: Color("HomeTitleColor")))
                            .padding(.bottom, 15)
                  
                        ChartGrid {
                            LineChart()
                        }
                        .padding(.top, -15)

                    }
                    .data(myData.realTimeHR)
                    .chartStyle(ChartStyle(backgroundColor: .clear,
                                           foregroundColor: ColorGradient(.pink.opacity(0.5), .red)))
                    .frame(width: 120,height: 200)
                    
                    CardView {
                        Text("HRV")
                            .foregroundColor(Color("HomeTitleColor"))
                            .font(.system(size: 24))
                            .padding(10)
                        ChartLabel((myData.realTimeHRV.count == 2) ? "--%" : "\(Int(myData.realTimeHRV.last!))%", type: .custom(size: 12, padding: .init(top: -10, leading: 10, bottom: 0, trailing: 0), color: Color("HomeTitleColor")))
                            .padding(.bottom, 15)
                  
                        ChartGrid {
                            LineChart()
                        }
                        .padding(.top, -15)

                    }
                    .data(myData.realTimeHRV)
                    .chartStyle(ChartStyle(backgroundColor: .clear,
                                           foregroundColor: ColorGradient(.blue.opacity(0.5), .blue)))
                    .frame(width: 120,height: 200)
                }
                .padding(.leading, 30)
                .padding(.top, 5)
            }
        }
        .padding(.top, -20)
        Spacer(minLength: 60)
    }
}

struct RealTimeChartView_Previews: PreviewProvider {
    static var previews: some View {
        RealTimeChartView()
    }
}
