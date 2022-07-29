//
//  UnbindTuple.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/29.
//

import Foundation

func unbindTuple (data: (UInt16,UInt16,UInt16,UInt16,UInt16,UInt16,UInt16,UInt16,UInt16,UInt16,UInt16,UInt16,UInt16,UInt16,UInt16,UInt16,UInt16,UInt16,UInt16,UInt16,UInt16,UInt16,UInt16,UInt16,UInt16,UInt16,UInt16,UInt16,UInt16,UInt16,UInt16,UInt16,UInt16,UInt16,UInt16,UInt16)) -> [UInt16] {
    
    let (the1, the2,the3, the4,the5, the6,the7, the8,the9, the10,the11, the12,the13, the14,the15, the16,the17, the18,the19, the20,the21, the22,the23, the24,the25, the26,the27, the28,the29, the30,the31, the32,the33, the34,the35, the36) = data
    var array = [UInt16]()
    array.append(the1)
    array.append(the2)
    array.append(the3)
    array.append(the4)
    array.append(the5)
    array.append(the6)
    array.append(the7)
    array.append(the8)
    array.append(the9)
    array.append(the10)
    array.append(the11)
    array.append(the12)
    array.append(the13)
    array.append(the14)
    array.append(the15)
    array.append(the16)
    array.append(the17)
    array.append(the18)
    array.append(the19)
    array.append(the20)
    array.append(the21)
    array.append(the22)
    array.append(the23)
    array.append(the24)
    array.append(the25)
    array.append(the26)
    array.append(the27)
    array.append(the28)
    array.append(the29)
    array.append(the30)
    array.append(the31)
    array.append(the32)
    array.append(the33)
    array.append(the34)
    array.append(the35)
    array.append(the36)
    
    return array
}
