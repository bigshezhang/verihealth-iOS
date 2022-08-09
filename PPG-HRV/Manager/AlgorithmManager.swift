//
//  AlgorithmManager.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/8/9.
//

import Foundation
import SwiftUI
import LineChartView

func HeartRateCalc(receivePack: MyBleRecPacket){
    
    var rawData = [UInt16]()      //  解构元组（swift将C中数组强制转换为了元组
    let mirror = Mirror(reflecting: receivePack.data)
    for (_, value) in mirror.children {
        rawData.append(value as! UInt16)
    }
    
    let arrayPtr = UnsafeMutablePointer<UInt16>(&rawData)
    let result = heart_rate_calc(arrayPtr)
    
    if result.err == 0 {
        print("[HRV返回了有效值] -> ", result.sdnn)
        
        if userData.realTimeHRV.count < 31 {        //向HomeView中的实时HRV视图传值
            DispatchQueue.main.async {
                userData.realTimeHRV.append(Double(result.sdnn))
                userData.realTimeHR.append(Double(result.hr))
                
                userData.hrChartData.append(LineChartData(result.hr))
                userData.hrvChartData.append(LineChartData(result.sdnn))
            }
        } else {
            DispatchQueue.main.async {
                userData.realTimeHRV.removeFirst()
                userData.realTimeHRV.append(Double(result.sdnn))
                userData.realTimeHR.removeFirst()
                userData.realTimeHR.append(Double(result.hr))
                
                userData.hrChartData.removeFirst()
                userData.hrvChartData.removeFirst()
                userData.hrChartData.append(LineChartData(result.hr))
                userData.hrvChartData.append(LineChartData(result.sdnn))

            }
        }
        let currentCustomFilePath = FileTool().createRealtimeTxt(writeWhat: .custom)    //输出有效数据到Custom文件
        do {
            let fileHandle = try FileHandle(forWritingTo: URL.init(string: currentCustomFilePath)!)
            fileHandle.seekToEndOfFile()
            try fileHandle.write(contentsOf: "\(result.sdnn)\n".data(using: .utf8)!)
            try fileHandle.close()
        } catch {
            print(error)
        }
    } else {
        print("[收到了无效包]")
    }
    let currentRawFilePath = FileTool().createRealtimeTxt(writeWhat: .raw)        //输出Raw数据到文件
    
    do {
        let fileHandle = try FileHandle(forWritingTo: URL.init(string: currentRawFilePath)!)
        fileHandle.seekToEndOfFile()
        try fileHandle.write(contentsOf: "\(rawData.prefix(Int(receivePack.size)))\n".data(using: .utf8)!)
        try fileHandle.close()
    } catch {
        print(error)
    }
}
