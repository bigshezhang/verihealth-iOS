//
//  HistoryView.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/8/10.
//

import SwiftUI

struct HistoryView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            HistoryCellView()
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
