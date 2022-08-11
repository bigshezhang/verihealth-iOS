//
//  HistoryView.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/8/10.
//

import SwiftUI
import CoreSDK
import HealthCharts


struct HistoryView: View {
    @State private var snackTime = Date()
    @Environment(\.presentationMode) var presentationMode
    func date2String(_ date:Date, dateFormat:String = "yy/MM/dd") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "en_US")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }
    
    func getTypeString(type: DBDataType) -> String{
        switch type{
        case DATA_TYPE_SPO2: return "Spo2"
        case DATA_TYPE_HR: return "HR"
        case DATA_TYPE_HRV: return "HRV"
        default:
            break
        }
        return ""
    }
    
    @ViewBuilder func dayDataChart(type: DBDataType, start: Int32) -> some View{
        let typeString = getTypeString(type: type)
        
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                HistoryCellView(type: type, dayTimeStamp: TimeInterval(start))
                    .shadow(color: Color(hex: "#e4e8f7"), radius: 5, x: 5, y: 5)
                    .padding(.leading, -50)
                    .overlay(
                        VStack{
                            HStack{
                                Text("Average \(typeString) of \(date2String(snackTime, dateFormat: "yy/MM/dd"))")
                                    .foregroundColor(Color("HomeTitleColor"))
                                    .padding(.leading, 40)
                                Spacer()
                            }
                            Spacer()
                        }
                    )
            }
            .padding(.leading, 10)
            .padding(.top, 15)
        }
    }
    var body: some View {
        ZStack{
            Color(hex: "#f5f6fa")
                .ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false){
                dayDataChart(type: DATA_TYPE_SPO2, start: Int32(snackTime.timeIntervalSince1970))
                    .padding(.top, 40)
                dayDataChart(type: DATA_TYPE_HR, start: Int32(snackTime.timeIntervalSince1970))
                dayDataChart(type: DATA_TYPE_HRV, start: Int32(snackTime.timeIntervalSince1970))
            }
            .padding(.top, 40)
            VStack{
                Rectangle()
                    .foregroundColor(Color(hex: "#f5f6fa"))
                    .frame(width: 400,height: 60)
                    .shadow(color: Color(hex: "#8ea7fd").opacity(0.3),radius: 5, y:8)
                    .overlay(
                        ZStack{
                            Text("History")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(Color(hex: "#8ea7fd"))
                            
                            HStack{
                                Button(action: {self.presentationMode.wrappedValue.dismiss()}, label: {Image(systemName: "arrow.left").foregroundColor(Color("HomeTitleColor"))})
                                    .padding(.leading, 30)
                                Spacer()
                                DatePicker("",selection: $snackTime, displayedComponents: .date)
                                    .padding(.trailing, 18)
                            }
                        }
                    )
                Spacer()
            }
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
