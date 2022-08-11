//
//  ColorHelper.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/8/11.
//

import Foundation
import SwiftUI

func getTypeColor(type: DBDataType) -> Color {
    switch type{
    case DATA_TYPE_SPO2: return Color(hex: "#f2a799")
    case DATA_TYPE_HR: return Color(hex: "#ed7171")
    case DATA_TYPE_HRV: return Color(hex: "#80b3f9")
    default: break
    }
    return Color.white
}
