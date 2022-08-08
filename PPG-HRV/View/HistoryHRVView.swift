//
//  HistoryHRVView.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/29.
//

import SwiftUI
import SwiftUICharts

struct HistoryHRVView: View {
    var timeCross = [0,1,2,3,4,5]   //回看六小时以内数据
    var body: some View {
        LazyVGrid(columns: [GridItem(.fixed(170)), GridItem(.fixed(170))]){
            ForEach(timeCross, id: \.self){ index in
                HistoryHRVCellView(Hour: String(format: "%02d", Int(getCurrentHour())! - index),data: FileTool().hourData(hour: String(format: "%02d", Int(getCurrentHour())! - index)))
                    .onAppear{
                        print("\(String(format: "%02d", Int(getCurrentHour())! - index))")
                    }
            }
        }
    }
}

struct HistoryHRVView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryHRVView()
    }
}
