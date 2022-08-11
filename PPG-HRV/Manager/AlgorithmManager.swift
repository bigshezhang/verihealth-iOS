//
//  AlgorithmManager.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/8/9.
//

import Foundation
import SwiftUI
import CoreSDK

func HeartRateCalc(receivePack: RawDataPacket){
    let result = bridge(BridgeData(size: receivePack.size, data: receivePack.data))
    
    if result.ret == 0 {
        print("[HRV返回了有效值] -> ", result.sdnn)
        print("[计算了心率] ->", result.hr)
        
        if userData.realTimeHRV.count < 31 {        //向HomeView中的实时HRV视图传值
            DispatchQueue.main.async {
                userData.realTimeHRV.append(Double(result.sdnn))
                userData.realTimeHR.append(Double(result.hr))
                DataBaseManager().writeData(type: DATA_TYPE_HR, value: Int32(userData.realTimeHR.last!))
                DataBaseManager().writeData(type: DATA_TYPE_HRV, value: Int32(userData.realTimeHRV.last!))
            }
        } else {
            DispatchQueue.main.async {
                userData.realTimeHRV.removeFirst()
                userData.realTimeHRV.append(Double(result.sdnn))
                userData.realTimeHR.removeFirst()
                userData.realTimeHR.append(Double(result.hr))
                DataBaseManager().writeData(type: DATA_TYPE_HR, value: Int32(userData.realTimeHR.last!))
                DataBaseManager().writeData(type: DATA_TYPE_HRV, value: Int32(userData.realTimeHRV.last!))
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
}
