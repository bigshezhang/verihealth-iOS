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
import Progress_Bar

struct TodaySpo2CardView: View {
    @ObservedObject var myData = userData
    let todayTimeStamp = dayStringToTimeStamp(getCurrentDate())
    let lastHourTimeStamp = hourStringToTimeStamp(getCurrentHourFullSize())
    let lastMinuteTimeStamp = minuteStringToTimeStamp(getCurrentMinuteFullSize())
    let yesterdayTimeStamp = dayStringToTimeStamp(getCurrentDate()) - 24 * 60 * 60
    
    let todaySpo2Array = DataBaseManager().getDayDataInDayByMinute(type: DATA_TYPE_SPO2, start: Int32(dayStringToTimeStamp(getCurrentDate())))
    let lastHourSpo2Array = DataBaseManager().getDataArrayInHourByMin(type: DATA_TYPE_SPO2, start: Int32(hourStringToTimeStamp(getCurrentHourFullSize())))
    let lastMinuteSpo2Array = DataBaseManager().getDataArrayInMinuteBySec(type: DATA_TYPE_SPO2, start: Int32(minuteStringToTimeStamp(getCurrentMinuteFullSize())))
    let yesterdaySpo2Array = DataBaseManager().getDayDataInDayByMinute(type: DATA_TYPE_SPO2, start: Int32(dayStringToTimeStamp(getCurrentDate())) - 24 * 60 * 60)
    
    var todaySpo2Average = Int()
    
    func getSpo2Average(dataArray : [Int]) -> Int{
//        print("[todaySpo2Array] -> ", todaySpo2Array)
        var sum = Int()
        var validCount = Int()
//        print("[dataArray.count -> ]", dataArray.count)
        if dataArray.count > 0{
            for index in 0...dataArray.count - 1{
                sum += dataArray[index]
                if dataArray[index] != 0{
                    validCount += 1
                }
            }
        }
        if validCount > 0{
            return sum / validCount
        } else {
            return 0
        }
    }
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                ZStack{
                    Circle()
                        .stroke(Color(hex: "#e8ecff"), lineWidth: 8)
                        .frame(width: 50,height: 50)
                    RingShape(progress: Double(getSpo2Average(dataArray: todaySpo2Array)) / 100.0, thickness: 8)
                        .fill(AngularGradient(gradient: Gradient(colors: [Color(hex: "#464ae1").opacity(0.5), Color(hex: "#6f8fea").opacity(0.5)]), center: .center, startAngle: .degrees(-90), endAngle: .degrees(360 * Double(getSpo2Average(dataArray: todaySpo2Array)) / 100.0 - 90)))
                        .shadow(color: Color(hex: "#474AD9"), radius: 1, x:1, y: 1)
                        .animation(.spring(), value: myData.realTimeSpo2.last!)
                        .frame(width: 50, height: 50)
                }

                VStack(alignment: .leading){
                    Text("\(getSpo2Average(dataArray: todaySpo2Array))%")
                        .font(.system(size: 28))
                        .foregroundColor(Color("HomeTitleColor"))
                    Text("All day average Spo2")
                        .font(.system(size: 14))
                        .foregroundColor(Color(hex: "#9797a8"))
                }
                .padding(.leading, 20)
            }
            .padding(.top,25)
            
            Spacer()
            VStack(alignment: .leading){
                Group{
                    HStack{
                        LinearProgress(percentage: Double(getSpo2Average(dataArray: lastMinuteSpo2Array)) / 100, backgroundColor: Color(hex: "#eaeefc"), foregroundColor: LinearGradient(colors: [Color(hex: "#cbd6ff"), Color(hex: "#90a9ff")], startPoint: .leading, endPoint: .trailing))
                            .frame(width: 148, height: 8)
                            .onAppear{
                                print("[前一分钟的Spo2数据] -> ",lastMinuteSpo2Array)
                            }
                        Text("\(getSpo2Average(dataArray: lastMinuteSpo2Array))%")
                            .font(.system(size: 12))
                            .foregroundColor(Color(hex: "#6f8fea"))
                        Text("last minute")
                            .font(.system(size: 12))
                            .foregroundColor(Color("HomeTitleColor"))
                    }
                    HStack{
                        LinearProgress(percentage: Double(getSpo2Average(dataArray: lastHourSpo2Array)) / 100, backgroundColor: Color(hex: "#eaeefc"), foregroundColor: LinearGradient(colors: [Color(hex: "#cbd6ff"), Color(hex: "#90a9ff")], startPoint: .leading, endPoint: .trailing))
                            .frame(width: 148, height: 8)
                            .onAppear{
                                print("[上一个小时的Spo2数据] -> ", lastHourSpo2Array)
                            }
                        Text("\(getSpo2Average(dataArray: lastHourSpo2Array))%")
                            .font(.system(size: 12))
                            .foregroundColor(Color(hex: "#6f8fea"))
                        Text("last hour")
                            .font(.system(size: 12))
                            .foregroundColor(Color("HomeTitleColor"))
                    }
                    
                    HStack{
                        LinearProgress(percentage: Double(getSpo2Average(dataArray: yesterdaySpo2Array)) / 100, backgroundColor: Color(hex: "#eaeefc"), foregroundColor: LinearGradient(colors: [Color(hex: "#cbd6ff"), Color(hex: "#90a9ff")], startPoint: .leading, endPoint: .trailing))
                            .frame(width: 148, height: 8)
                            .onAppear{
                                print("[昨天的Spo2数据] -> ", lastHourSpo2Array)
                            }
                        Text("\(getSpo2Average(dataArray: yesterdaySpo2Array))%")
                            .font(.system(size: 12))
                            .foregroundColor(Color(hex: "#6f8fea"))
                        Text("yesterday")
                            .font(.system(size: 12))
                            .foregroundColor(Color("HomeTitleColor"))
                    }
                }
                .padding(.bottom, 18)
            }
            .padding(.bottom, 8)
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
