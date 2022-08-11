//
//  FakeDataGenarater.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/8/9.
//

import Foundation
import CoreSDK

class FakeDataGenerator {
    func chartDataGenerator(){
        print("[正在生成FakeData]")
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if userData.realTimeHR.count < 30{
                userData.realTimeHR.append(Double.random(in: 60...190))
            } else {
                userData.realTimeHR.removeFirst()
                userData.realTimeHR.append(Double.random(in: 60...190))
            }
            
            if userData.realTimeHRV.count < 30{
                userData.realTimeHRV.append(Double.random(in: 120...160))
            } else {
                userData.realTimeHRV.removeFirst()
                userData.realTimeHRV.append(Double.random(in: 120...160))
            }
            
            if userData.realTimeSpo2.count < 30{
                userData.realTimeSpo2.append(Double.random(in: 0.96...1))
            } else {
                userData.realTimeSpo2.removeFirst()
                userData.realTimeSpo2.append(Double.random(in: 0.96...1))
            }
            
            DataBaseManager().writeData(type: DATA_TYPE_HR, value: Int32(userData.realTimeHR.last!))
            DataBaseManager().writeData(type: DATA_TYPE_HRV, value: Int32(userData.realTimeHRV.last!))
            DataBaseManager().writeData(type: DATA_TYPE_SPO2,value: Int32(userData.realTimeSpo2.last!))

            userData.lossRate = Double.random(in: 0...0.05)
            userData.mistakeRate = Double.random(in: 0...0.05)
            
//            DataBaseManager().getDataBaseDuringTime()
        }
    }
}
