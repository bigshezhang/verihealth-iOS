//
//  HistoryCellView.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/8/10.
//

import SwiftUI
import SwiftUICharts
import HealthCharts
import CoreSDK
struct HistoryCellView: View {
    let timeStamp = Int32(Date().timeIntervalSince1970)
    var lasthourData = DataBaseManager().getDataArrayInHourByMin(type: DATA_TYPE_HR, start: Int32(Date().timeIntervalSince1970) - 3601)
    let highIntensity = Legend(color: .orange, label: "High Intensity", order: 5)
    let buildFitness = Legend(color: .yellow, label: "Build Fitness", order: 4)
    let fatBurning = Legend(color: .green, label: "Fat Burning", order: 3)
    let warmUp = Legend(color: .blue, label: "Warm Up", order: 2)
    let low = Legend(color: .gray, label: "Low", order: 1)
    
    func returnLegend(value: Int) -> Legend{
        switch(value){
        case 60...90 : return low
        case 91...130 : return warmUp
        case 131...150 : return fatBurning
        case 151...170 : return buildFitness
        case 171...190 : return highIntensity
        default : break
        }
        return low
//        switch(value){
//        case 60...61 : return low
//        case 62...63 : return warmUp
//        case 64...65 : return fatBurning
//        case 66...67 : return buildFitness
//        case 68...69 : return highIntensity
//        default : break
//        }
        return low
    }
    
    func dataToPoint(dataArray : [Int]) -> [DataPoint]{
        var dataPoints = [DataPoint]()
        for index in 1...15 {
            dataPoints.append(DataPoint(value: Double(dataArray[index * 4 - 4]), label: "\(index * 4 - 4)", legend: returnLegend(value: dataArray[index * 4 - 4])))
        }
        return dataPoints
    }
//
    func intToDouble(intArray: [Int]) -> [Double]{
        var doubleArray = [Double]()
        for index in 0...intArray.count-1{
            doubleArray.append(Double(intArray[index]))
        }
        return doubleArray
    }
    
    func selectPoint(dataArray : [Double]) -> [Double]{
        var selectedArray = [Double]()
        for index in 1...15 {
            selectedArray.append(dataArray[index * 4 - 4])
        }
        return selectedArray
    }
    
    var body: some View {
        var barData = selectPoint(dataArray: intToDouble(intArray: lasthourData))
//        let limit = DataPoint(value: 130, label: "5", legend: fatBurning)
        VStack{
            BarChartView(dataPoints: dataToPoint(dataArray: lasthourData))
                .chartStyle(BarChartStyle(showAxis: true, axisLeadingPadding: CGFloat(0), showLegends: false))
                .onAppear{
                    print(dataToPoint(dataArray: lasthourData))
                }
                .frame(width: 360,height: 120)
                .background(
                    ZStack{
                        RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                            .foregroundColor(Color.white)
                            .padding(-20)
                            .shadow(color: .gray, radius: 5)
                    }
                )
                .scaleEffect(0.9)
        }
    }
}

struct HistoryCellView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryCellView()
    }
}
