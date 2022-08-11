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
        let hrModel = HRModel()
        let hrvModel = HRVModel()
        let spo2Model = Spo2Model()
        let timeInterval = Int32(Date().timeIntervalSince1970)
        
        switch type {
        case DATA_TYPE_HR :
            hrModel.timeStamp = timeInterval
            hrModel.value = value
            DataManager.sharedInstance().writeData(hrModel, timeStamp: timeInterval)
            
        case DATA_TYPE_HRV :
            hrvModel.timeStamp = timeInterval
            hrvModel.value = value
            DataManager.sharedInstance().writeData(hrvModel, timeStamp: timeInterval)
            
        case DATA_TYPE_SPO2 :
            spo2Model.timeStamp = timeInterval
            spo2Model.value = value
            DataManager.sharedInstance().writeData(spo2Model, timeStamp: timeInterval)
            
        default: break
        }
    }
    
    func getDataBaseDuringTime(type: DBDataType, start: Int32, end: Int32) -> [Int32 : Int32]{
        let rlmResult = DataManager.sharedInstance().queryData(type, start: start, end: end, userName: "lazyman")
        var dataDic = [Int32 : Int32]()
        if rlmResult.count > 0{
            for index in 0...rlmResult.count - 1 {
                switch type{
                case DATA_TYPE_HR:
                    let object = rlmResult.object(at: index) as! HRModel
                    dataDic.updateValue(object.value, forKey: object.timeStamp)
                case DATA_TYPE_HRV:
                    let object = rlmResult.object(at: index) as! HRVModel
                    dataDic.updateValue(object.value, forKey: object.timeStamp)
                case DATA_TYPE_SPO2:
                    let object = rlmResult.object(at: index) as! Spo2Model
                    dataDic.updateValue(object.value, forKey: object.timeStamp)
                default: break
                }
            }
        }
        return dataDic
    }
    
    func getDataArray(type: DBDataType, start: Int32, end: Int32) -> [Int] {
        let dataDic = getDataBaseDuringTime(type: type, start: start, end: end)
        var dataArrayBySec = [Int](repeating: -1, count: Int(end - start) + 1)
        for cell in dataDic {
            dataArrayBySec[Int(cell.key - start)] = Int(cell.value)
        }
        return dataArrayBySec
    }
    
    func getDataArrayInHourByMin(type: DBDataType, start: Int32) -> [Int] {
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
        return dataArrayByMinute
    }
    
    func getDayDataInDayByHour(type: DBDataType) -> [Int] {
        var dataArray = [Int]()
        for hour in 0...23 {
            let hourInMinArray = DataBaseManager().getDataArrayInHourByMin(type: type, start: Int32(Int(dayStringToTimeStamp(getCurrentDate())) + hour * 3600))
            var tmpSum = Int()
            var validCountInMinute = Int()
            for index in 0...hourInMinArray.count-1{
                tmpSum += hourInMinArray[index]
                if hourInMinArray[index] != 0{
                    validCountInMinute += 1
                }
            }
            if validCountInMinute != 0{
                dataArray.append(tmpSum / validCountInMinute)
            } else {
                dataArray.append(0)
            }
        }
        return dataArray
    }
    
    func getDayDataInDayByMinute(type: DBDataType, start: Int32) -> [Int] {
        var dataArray = [Int]()
        for hour in 0...23 {
            let hourInMinArray = DataBaseManager().getDataArrayInHourByMin(type: type, start: Int32(Int(dayStringToTimeStamp(getCurrentDate())) + hour * 3600))
            dataArray += hourInMinArray
        }
        return dataArray
    }
    
    func getDataArrayInMinuteBySec(type: DBDataType, start: Int32) -> [Int] {
        var dataArray = [Int]()
        let dataFromBase = DataBaseManager().getDataArray(type: type, start: start, end: start + 59)
        for sec in 0...59{
            if dataFromBase[sec] != -1{
                dataArray.append(dataFromBase[sec])
            }
        }
        return dataArray
    }
}
