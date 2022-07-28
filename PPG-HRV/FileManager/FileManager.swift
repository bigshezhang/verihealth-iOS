//
//  FileManager.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/28.
//

import Foundation
import SwiftUI
import BaseFramework
import BleFramework

final class FileTool{
    @State var createDirError : NSError? //收集错误信息
    @State var createFileError : String?
    
    func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        formatter.timeZone = TimeZone.init(identifier: "Asia/Beijing")
        return formatter.string(from: Date())
    }
    
    func getCurrentTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH时mm分ss.S秒"
        formatter.timeZone = TimeZone.init(identifier: "Asia/Beijing")
        return formatter.string(from: Date())
    }

    func createTodayDir() -> Void{
        createDirectoryIfNotExists(userData.appDocDir.appending("/\(getCurrentDate())"), &createDirError)
        print("[创建当天储存文件夹是否发生错误] -> ",createDirError)
        userData.todayDirPath = userData.appDocDir.appending("/\(getCurrentDate())")    //刷新userData中当天的文件夹露肩
    }
    
    func createRealtimeTxt() -> String{     //返回当前的时间便与写入文件
        var currentTime = getCurrentTime()
        createFileIfNotExits(userData.todayDirPath.appending("/\(getCurrentTime()).txt"), createFileError)
        print("[创建当前时刻的文件是否发生错误] -> ", createFileError)
        return currentTime
    }
}
