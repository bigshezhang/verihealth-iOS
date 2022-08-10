//
//  FakeDataGenarater.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/8/9.
//

import Foundation

class FakeDataGenerator {
    func chartDataGenerator(){
        print("[正在生成FakeData]")
        userData.realTimeSpo2.append(Double.random(in: 0.98...1))
        userData.realTimeHR.append(Double.random(in: 60...70))
        userData.realTimeHRV.append(Double.random(in: 120...140))
        userData.lossRate = Double.random(in: 0...5)
        userData.mistakeRate = Double.random(in: 0...5)
        
        userData.realTimeSpo2.append(Double.random(in: 0.98...1))
        userData.realTimeHR.append(Double.random(in: 60...70))
        userData.realTimeHRV.append(Double.random(in: 120...140))
        userData.lossRate = Double.random(in: 0...5)
        userData.mistakeRate = Double.random(in: 0...5)
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            userData.realTimeSpo2.append(Double.random(in: 0.98...1))
            userData.realTimeHR.append(Double.random(in: 60...70))
            userData.realTimeHRV.append(Double.random(in: 120...140))
            userData.lossRate = Double.random(in: 0...0.05)
            userData.mistakeRate = Double.random(in: 0...0.05)
        }
    }
}
