//
//  TodaySpo2CardView.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/8/11.
//

import SwiftUI
import CoreSDK
import HealthCharts
import PlotUI

struct TodaySpo2CardView: View {
    @ObservedObject var myData = userData
    let todayTimeStamp = dayStringToTimeStamp(getCurrentDate())
    let todaySpo2Array = DataBaseManager().getTodayDataInDayByMinute(type: DATA_TYPE_SPO2)
    var todaySpo2Average = Int()
    
    func getTodaySpo2Average() -> Int{
        print("[todaySpo2Array] -> ", todaySpo2Array)
        var sum = Int()
        var validCount = Int()
        
        for index in 0...todaySpo2Array.count - 1{
            sum += todaySpo2Array[index]
            if todaySpo2Array[index] != 0{
                validCount += 1
            }
        }
//        print("[todaySpo2Array] ->",todaySpo2Array)
        if validCount > 0{
            return sum / validCount
        } else {
            return 0
        }
    }
    
    var body: some View {
        VStack{
            HStack{
                ZStack{
                    RingShape(progress: myData.realTimeSpo2.last!, thickness: 12)
                        .fill(AngularGradient(gradient: Gradient(colors: [Color(hex: "#464ae1"), Color(hex: "#6f8fea")]), center: .center, startAngle: .degrees(-90), endAngle: .degrees(Double(360 * (getTodaySpo2Average() / 100) - 90))))
                        .shadow(color: Color(hex: "#474AD9"), radius: 3, x:3, y: 3)
                    Text("\(getTodaySpo2Average())")
                }


                VStack{
                    
                }
            }
            HStack{
                
            }
            HStack{
                
            }
            HStack{
                
            }
        }
        .frame(width: 315,height: 224)
        .background( RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
            .foregroundColor(.white)
            .shadow(color: Color(hex: "#e4e8f7"), radius: 5, x: 5, y: 5))
    }
}

struct TodaySpo2CardView_Previews: PreviewProvider {
    static var previews: some View {
        TodaySpo2CardView()
    }
}
