//
//  DoubleExtensions.swift
//  YXExtensions
//
//  Created by 彭鹤 on 2023/3/21.
//

import Foundation

extension Double {

    // MARK: Double类型取舍，保留几位小数
    /// Rounds the double to decimal places value
    /// 保留几位小数
    func yx_roundTo(places: Int) -> Double {
        
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
