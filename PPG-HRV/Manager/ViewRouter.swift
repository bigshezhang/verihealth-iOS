//
//  ViewRouter.swift
//  PPG-HRV
//
//  Created by 李子鸣 on 2022/7/20.
//

import Foundation

final class ViewRouter: ObservableObject {
    @Published var currentPage: Page = .Home
    @Published var isTabBarShow = true
}


enum Page{
    case Home
    case Page1
    case Page2
//    case DeviceDictView
}
