//
//  HistoryCellView.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/8/10.
//

import SwiftUI
import HealthCharts
import CoreSDK

struct HistoryCellView: View {
    let type : DBDataType
    let dayTimeStamp : TimeInterval
    
    func dataToPoint(dataArray : [Int]) -> [DataPoint]{
        var dataPoints = [DataPoint]()
        for index in 0...23 {
            dataPoints.append(DataPoint(value: Double(dataArray[index]), label: "\(index)", legend: Legend(color: Color(hex: "#8ea7fd"), label: "")))
        }
        return dataPoints
    }
        
    func getDayDataInDayByHour() -> [Int] {
        var dataArray = [Int]()
        for hour in 0...23 {
            let hourInMinArray = DataBaseManager().getDataArrayInHourByMin(type: type, start: Int32(Int(dayTimeStamp) + hour * 3600))
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
            BarChartView(dataPoints: dataToPoint(dataArray: getDayDataInDayByHour()))
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
                            .offset(y: -15)
                    }
                )
                .accentColor(Color(hex: "#6984e7"))
                .onAppear{
                    print("\(dayTimeStamp)", "\(Date().timeIntervalSince1970)")
            }
        }
    }
}

struct HistoryCellView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryCellView(type: DATA_TYPE_HR, dayTimeStamp: dayStringToTimeStamp(getCurrentDate()))
    }
}
