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
    
    func writeHRData(value: Int){
        let timeInterval:TimeInterval = Date().timeIntervalSince1970
        let dataModel = HRModel()
        dataModel.timeStamp = Int32(timeInterval)
        dataModel.value = Int32(value)
        DataManager.sharedInstance().writeData(dataModel, timeStamp: Int32(Date().timeIntervalSince1970))
        print("[HR数据库信息] ->", DataManager.sharedInstance().queryAllData(DATA_TYPE_HR, userName: "lazyman").count)
    }
    
    func writeHRVData(value: Int){
        let timeInterval:TimeInterval = Date().timeIntervalSince1970
        let dataModel = HRVModel()
        dataModel.timeStamp = Int32(timeInterval)
        dataModel.value = Int32(value)
        DataManager.sharedInstance().writeData(dataModel, timeStamp: Int32(Date().timeIntervalSince1970))
        print("[HRV数据库信息] ->", DataManager.sharedInstance().queryAllData(DATA_TYPE_HRV, userName: "lazyman").count)
    }
    
    func writeSpo2Data(value: Int){
        let timeInterval:TimeInterval = Date().timeIntervalSince1970
        let dataModel = Spo2Model()
        dataModel.timeStamp = Int32(timeInterval)
        dataModel.value = Int32(value)
        DataManager.sharedInstance().writeData(dataModel, timeStamp: Int32(Date().timeIntervalSince1970))
        print("[Spo2数据库信息] ->", DataManager.sharedInstance().queryAllData(DATA_TYPE_HRV, userName: "lazyman").count)
    }
}
