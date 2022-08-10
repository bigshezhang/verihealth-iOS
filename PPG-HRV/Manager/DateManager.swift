//
//  DateManager.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/29.
//

import Foundation


func getCurrentDate() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY-MM-dd"
    formatter.timeZone = TimeZone.init(identifier: "Asia/Beijing")
    return formatter.string(from: Date())
}

func getCurrentTime() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH-mm"
    formatter.timeZone = TimeZone.init(identifier: "Asia/Beijing")
    return formatter.string(from: Date())
}

func getCurrentHour() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH"
    formatter.timeZone = TimeZone.init(identifier: "Asia/Beijing")
    return formatter.string(from: Date())
}

//func getTimeStamp() -> Int {
//    return Date().timeIntervalSince(1970)
//}
