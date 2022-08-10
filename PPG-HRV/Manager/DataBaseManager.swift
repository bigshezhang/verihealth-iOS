//
//  DataBaseManager.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/8/10.
//

import Foundation
import SwiftUI
import CoreSDK

class DataBaseManager : NSObject, ObservableObject {
    override init() {
        DataManager.sharedInstance().dataBaseInit("lazyman", device: userData.currDevice)
    }
    
    func writeData(type: DBDataType, value: Int32){
        var hrModel = HRModel()
        var hrvModel = HRVModel()
        var spo2Model = Spo2Model()
        let timeInterval = Int32(Date().timeIntervalSince1970)
        
        switch type {
        case DATA_TYPE_HR :
            hrModel.timeStamp = timeInterval
            hrModel.value = value
            DataManager.sharedInstance().writeData(hrModel, timeStamp: timeInterval)
            print("[HR数据库信息] ->", DataManager.sharedInstance().queryAllData(DATA_TYPE_HR, userName: "lazyman").count)
            
        case DATA_TYPE_HRV :
            hrvModel.timeStamp = timeInterval
            hrvModel.value = value
            DataManager.sharedInstance().writeData(hrvModel, timeStamp: timeInterval)
            print("[HRV数据库信息] ->", DataManager.sharedInstance().queryAllData(DATA_TYPE_HRV, userName: "lazyman").count)
            
        case DATA_TYPE_SPO2 :
            spo2Model.timeStamp = timeInterval
            spo2Model.value = value
            DataManager.sharedInstance().writeData(spo2Model, timeStamp: timeInterval)
            print("[Spo2数据库信息] ->", DataManager.sharedInstance().queryAllData(DATA_TYPE_HRV, userName: "lazyman").count)
            
        default: break
        }
    }
    
//    func writeHRData(value: Int){
//        let timeInterval:TimeInterval = Date().timeIntervalSince1970
//        let dataModel = HRModel()
//        dataModel.timeStamp = Int32(timeInterval)
//        dataModel.value = Int32(value)
//        DataManager.sharedInstance().writeData(dataModel, timeStamp: Int32(Date().timeIntervalSince1970))
//        print("[HR数据库信息] ->", DataManager.sharedInstance().queryAllData(DATA_TYPE_HR, userName: "lazyman").count)
//    }
//
//    func writeHRVData(value: Int){
//        let timeInterval:TimeInterval = Date().timeIntervalSince1970
//        let dataModel = HRVModel()
//        dataModel.timeStamp = Int32(timeInterval)
//        dataModel.value = Int32(value)
//        DataManager.sharedInstance().writeData(dataModel, timeStamp: Int32(Date().timeIntervalSince1970))
//        print("[HRV数据库信息] ->", DataManager.sharedInstance().queryAllData(DATA_TYPE_HRV, userName: "lazyman").count)
//    }
//
//    func writeSpo2Data(value: Int){
//        let timeInterval:TimeInterval = Date().timeIntervalSince1970
//        let dataModel = Spo2Model()
//        dataModel.timeStamp = Int32(timeInterval)
//        dataModel.value = Int32(value)
//        DataManager.sharedInstance().writeData(dataModel, timeStamp: Int32(Date().timeIntervalSince1970))
//        print("[Spo2数据库信息] ->", DataManager.sharedInstance().queryAllData(DATA_TYPE_HRV, userName: "lazyman").count)
//    }
    
    func getDataBaseDuringTime(type: DBDataType, start: Int32, end: Int32) -> [Int32 : Int32]{
        let rlmResult = DataManager.sharedInstance().queryData(type, start: start, end: end, userName: "lazyman")
        
        var dataDic = [Int32 : Int32]()
        print("[rlmCount]", rlmResult.count)
        
        if rlmResult.count > 0{
            for index in 0...rlmResult.count - 1 {
                let object = rlmResult.object(at: index) as! HRModel
                dataDic.updateValue(object.value, forKey: object.timeStamp)
            }
        }
        return dataDic
    }
    
    func getDataArray(type: DBDataType, start: Int32, end: Int32) -> [Int] {
        let dataDic = getDataBaseDuringTime(type: type, start: start, end: end)
        var dataArrayBySec = [Int](repeating: -1, count: Int(end - start) + 1000)
        for cell in dataDic {
            dataArrayBySec[Int(cell.key - start)] = Int(cell.value)
        }
        return dataArrayBySec
    }
    
    func getDataArrayByHour(type: DBDataType, start: Int32) -> [Int] {
        let dataArrayBySec = getDataArray(type: type, start: start, end: start + 3599)
        var dataArrayByMinute = [Int]()
        for min in 0...59 {
            var tmpSum = Int()
            var validCount = Int()
            for sec in 0...59{
                if dataArrayBySec[min * 60 + sec] != -1{
                    tmpSum += dataArrayBySec[min * 60 + sec]
                    validCount += 1
                }
            }
            if validCount != 0 {
                dataArrayByMinute.append(tmpSum / validCount)
            } else {
                dataArrayByMinute.append(0)
            }
        }
        print("[一小时内HR] -> ", dataArrayByMinute)
        return dataArrayByMinute
    }
}
