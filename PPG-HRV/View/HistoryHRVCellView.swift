//
//  HistoryHRVCellView.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/29.
//

import SwiftUI
import SwiftUICharts


struct HistoryHRVCellView: View {
    var Hour : String
    var data : [Double]
    var body: some View {
            LineChartView(data: data, title: "\(Hour)时", form: ChartForm.small)
    }
}

//struct HistoryHRVCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoryHRVCellView()
//    }
//}
