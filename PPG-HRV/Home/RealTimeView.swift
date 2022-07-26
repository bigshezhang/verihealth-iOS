//
//  RealTimeView.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/26.
//

import SwiftUI
import SwiftUICharts

struct RealTimeView: View {
    @State var realTimeData : [Double] = [66, 80]
    
    func startTimer(){
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            realTimeData.append(Double.random(in: 60..<80))
        }
    }
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .foregroundColor(.white)
                
            
            LineView(data: realTimeData, title: "233")
                .padding()
//                .padding()
                .onAppear{
                    startTimer()
                }
        }
    }
}

struct RealTimeView_Previews: PreviewProvider {
    static var previews: some View {
        RealTimeView()
    }
}
