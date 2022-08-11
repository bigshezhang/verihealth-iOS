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

func getCurrentHourFullSize() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY-MM-dd-HH"
    formatter.timeZone = TimeZone.init(identifier: "Asia/Beijing")
    return formatter.string(from: Date())
}

func getCurrentMinuteFullSize() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY-MM-dd-HH-mm"
    formatter.timeZone = TimeZone.init(identifier: "Asia/Beijing")
    return formatter.string(from: Date())
}

func dayStringToTimeStamp(_ time: String) -> TimeInterval {
    let dateformatter = DateFormatter()
    dateformatter.dateFormat = "YYYY-MM-dd"// 自定义时间格式
    let date = dateformatter.date(from: time)
    return (date?.timeIntervalSince1970)!
}

func hourStringToTimeStamp(_ time: String) -> TimeInterval {
    let dateformatter = DateFormatter()
    dateformatter.dateFormat = "YYYY-MM-dd-HH"// 自定义时间格式
    let date = dateformatter.date(from: time)
    return (date!.timeIntervalSince1970)
}

func minuteStringToTimeStamp(_ time: String) -> TimeInterval {
    let dateformatter = DateFormatter()
    dateformatter.dateFormat = "YYYY-MM-dd-HH-mm"// 自定义时间格式
    let date = dateformatter.date(from: time)
    return (date?.timeIntervalSince1970)!
}

//func getTimeStamp() -> Int {
//    return Date().timeIntervalSince(1970)
//}
