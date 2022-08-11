//
//  AlgorithmManager.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/8/9.
//

import Foundation
import SwiftUI

func HeartRateCalc(receivePack: RawDataPacket){
    
    var rawData = [UInt16]()
    var usedData = [UInt16]()      //  解构元组（swift将C中数组强制转换为了元组
    let mirror = Mirror(reflecting: receivePack.data)
    for (_, value) in mirror.children {
        rawData.append(value as! UInt16)
    }
    
    for index in 0...receivePack.size - 1{
        if index % 2 == 0{
            usedData.append(rawData[Int(index)])
        }
    }
    
    let arrayPtr = UnsafeMutablePointer<UInt16>(&usedData)
    let result = heart_rate_calc(arrayPtr)
    
    if result.err == 0 {
        print("[HRV返回了有效值] -> ", result.sdnn)
        
//        if userData.realTimeHRV.count < 31 {        //向HomeView中的实时HRV视图传值
//            DispatchQueue.main.async {
//                userData.realTimeHRV.append(Double(result.sdnn))
//                userData.realTimeHR.append(Double(result.hr))
//            }
//        } else {
//            DispatchQueue.main.async {
//                userData.realTimeHRV.removeFirst()
//                userData.realTimeHRV.append(Double(result.sdnn))
//                userData.realTimeHR.removeFirst()
//                userData.realTimeHR.append(Double(result.hr))
//                
//            }
//        }
        
        print("[计算了心率] ->")
        
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
        try fileHandle.write(contentsOf: "\(usedData.prefix(Int(receivePack.size)))\n".data(using: .utf8)!)
        try fileHandle.close()
    } catch {
        print(error)
    }
}
