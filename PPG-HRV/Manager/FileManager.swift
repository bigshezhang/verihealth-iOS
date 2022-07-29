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

    func createTodayDir() -> Void{
        createDirectoryIfNotExists(userData.appDocDir.appending("/\(getCurrentDate())"), &createDirError)
        createDirectoryIfNotExists(userData.appDocDir.appending("/\(getCurrentDate())/CustomMsg"), &createDirError)
        createDirectoryIfNotExists(userData.appDocDir.appending("/\(getCurrentDate())/RawMsg"), &createDirError)
        print("[创建当天储存文件夹是否发生错误] -> ",createDirError)
        userData.todayDirPath = userData.appDocDir.appending("/\(getCurrentDate())")    //刷新userData中当天的文件夹露肩
    }

    func createRealtimeTxt(writeWhat: writeWhat) -> String{     //返回当前的时间便与写入文件
        var currentTime = getCurrentTime()
        
        switch writeWhat{
        case .custom :do {
            createFileIfNotExits(userData.todayDirPath.appending("/CustomMsg/\(currentTime).txt"), createFileError)
            return userData.todayDirPath.appending("/CustomMsg/\(currentTime).txt")
        }
        case .raw :do {
            createFileIfNotExits(userData.todayDirPath.appending("/RawMsg/\(currentTime).txt"), createFileError)
            return userData.todayDirPath.appending("/RawMsg/\(currentTime).txt")
        }
        }
    }
    
    func hourData(hour : String) -> [Int]{
        var hourHRV = [Int]()
        var path = userData.todayDirPath.appending("/Custom")
        for i in 01...60 {
            var minute = String(format: "%02x", i)
            hourHRV.append(averageByMinute(time: hour.appending("-\(minute)")))
        }

        return hourHRV
    }
    
    func averageByMinute(time : String) -> Int{
        var path = userData.todayDirPath.appending("/Custom/\(time).txt")
        if let content = try? String(contentsOfFile: path, encoding: .utf8) {
            let data = content.components(separatedBy: "\n")
            var sum = 0
            for i in 0...data.count {
                sum += Int(data[i])!
            }
            return sum / data.count
        } else {
            return 0
        }
    }
}

enum writeWhat {
    case raw
    case custom
}
