//
//  TodayCardView.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/8/10.
//

import SwiftUI
import CoreSDK
import HealthCharts
import PlotUI
struct TodayCardView: View {
    let todayTimeStamp = dayStringToTimeStamp(getCurrentDate())
    
    func dataToPoint(dataArray : [Int]) -> [DataPoint]{
        var dataPoints = [DataPoint]()
        for index in 0...23 {
            dataPoints.append(DataPoint(value: Double(dataArray[index]), label: "\(index)", legend: Legend(color: Color(hex: "#8ea7fd"), label: "")))
        }
        return dataPoints
    }
        
    func getTodayDataInDayByHour() -> [Int] {
        var dataArray = [Int]()
        for hour in 0...23 {
            let hourInMinArray = DataBaseManager().getDataArrayInHourByMin(type: DATA_TYPE_HR, start: Int32(Int(todayTimeStamp) + hour * 3600))
            var tmpSum = Int()
            var validCountInMinute = Int()
            for index in 0...hourInMinArray.count-1{
                tmpSum += hourInMinArray[index]
                if hourInMinArray[index] != 0{
                    validCountInMinute += 1
                }
            }
            if validCountInMinute != 0{
                dataArray.append(tmpSum / validCountInMinute)
            } else {
                dataArray.append(0)
            }
        }
        return dataArray
    }
    
    var body: some View {
        
        VStack {
            BarChartView(dataPoints: dataToPoint(dataArray: getTodayDataInDayByHour()))
                .chartStyle(BarChartStyle(showAxis: true,labelCount: 12,showLegends: false))
                .foregroundColor(.gray)
            
                .foregroundColor(Color.gray)
                .frame(width: 480,height: 200)
                .scaleEffect(0.65)
                .background(
                    ZStack{
                        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                            .foregroundColor(Color.white)
                            .frame(width: 350, height: 200)
    //                        .shadow(radius: 4, x: 2, y: 2)
                            .offset(y: -15)
                    }
                )
                .accentColor(Color(hex: "#6984e7"))
                .onAppear{
                    print("\(todayTimeStamp)", "\(Date().timeIntervalSince1970)")
            }
            
            
//            PlotView {
//                BarView(
//                    x: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24],
//                    y: getTodayDataInDayByHour().map{Double($0)}
//                )
//                .barWidth(8)
//
//
//            }
//        horizontal: {
//                HAxis(
//                    ticks: [0.5 ,1, 3, 5, 7, 9,11],
//                    labels: ["0","1", "3", "5", "7", "9", "11"]
//                )
//                .tickStyle(.bottomTrailing)
//                .tickStroke(style: StrokeStyle(lineWidth: 0))
//            } vertical: {
//                VAxis(ticks: [60, 80, 100],labels: ["60","80","100"])
//                    .tickStyle(.trailing)
//                    .tickStroke(style: StrokeStyle(lineWidth: 0.2))
//            }
//            .contentDisposition(minX: 1, maxX: 26, minY: 50, maxY: 190)
//            .frame(width: 320, height: 200)
//            .tickInsets(bottom: 20)
//            
//            PlotView {
//                BarView(
//                    x: [3, 4, 5],
//                    y: [2000, 2100, 2300]
//                )
//            } horizontal: {
//                HAxis(
//                    ticks: [1, 2, 3, 4, 5],
//                    labels: ["Sun", "Mon", "Tue", "Wed", "Thu"]
//                )
//            } vertical: {
//                VAxis(ticks: [1000, 2000, 3000])
//            }
//            .contentDisposition(minX: 1, maxX: 5, minY: 0, maxY: 3000)
//            .frame(width: 500, height: 300)
        }
 
    }
}

struct TodayCardView_Previews: PreviewProvider {
    static var previews: some View {
        TodayCardView()
    }
}
