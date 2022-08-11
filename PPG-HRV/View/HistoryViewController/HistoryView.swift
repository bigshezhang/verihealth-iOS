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
    @Environment(\.presentationMode) var presentationMode
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
    
    @ViewBuilder func theDataChartOfPastDays(type: DBDataType) -> some View{
        let typeString = getTypeString(type: type)
        
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                HistoryCellView(type: type, dayTimeStamp: dayStringToTimeStamp(getCurrentDate()))
                    .shadow(color: Color(hex: "#e4e8f7"), radius: 5, x: 5, y: 5)
                    .padding(.leading, -50)
                    .overlay(
                        VStack{
                            HStack{
                                Text("Average \(typeString) of Today")
                                    .foregroundColor(Color("HomeTitleColor"))
                                    .padding(.leading, 40)
                                Spacer()
                            }
                            Spacer()
                        }
                    )
                ForEach(1..<8) { pastDay in
                    HistoryCellView(type: type, dayTimeStamp: dayStringToTimeStamp(getCurrentDate()) - Double(pastDay * 24 * 60 * 60))
                        .shadow(color: Color(hex: "#e4e8f7"), radius: 5, x: 5, y: 5)
                        .padding(.leading, -50)
                        .overlay(
                            VStack{
                                HStack{
                                    Text("Average \(typeString) of \(pastDay) day ago")
                                        .foregroundColor(Color("HomeTitleColor"))
                                        .padding(.leading, 40)
                                    Spacer()
                                }
                                Spacer()
                            }
                        )
                }
            }
            .padding(.leading, 10)
            .padding(.top, 20)
        }
    }
    var body: some View {
        ZStack{
            Color(hex: "#f5f6fa")
                .ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false){
                theDataChartOfPastDays(type: DATA_TYPE_SPO2)
                theDataChartOfPastDays(type: DATA_TYPE_HR)
                theDataChartOfPastDays(type: DATA_TYPE_HRV)
            }
            .padding(.top, 80)
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
