//
//  UIColorExtensions.swift
//  YXExtensions
//
//  Created by 彭鹤 on 2023/3/21.
//

import Foundation

public extension UIColor {
    
    // MARK: -- 16进制字符串转换成颜色
    // Hex String -> UIColor
    convenience init(hexString: String) {
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)

        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }

        var color: UInt32 = 0
        scanner.scanHexInt32(&color)

        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask

        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1)
    }

    // MARK: -- 颜色色值转换成16进制字符串
    // UIColor -> Hex String
    var yx_hexString: String? {
        var red: CGFloat   = 0
        var green: CGFloat = 0
        var blue: CGFloat  = 0
        var alpha: CGFloat = 0

        let multiplier = CGFloat(255.0)

        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
        if red < 0 {
            red = red + 1
        }
        if green < 0 {
            green = green + 1
        }
        if blue < 0 {
            blue  = blue + 1
        }
        if alpha < 0 {
            alpha = alpha + 1
        }
        if alpha == 1.0 {
            return String(
                format: "%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier)
            )
        }
        else {
            return String(
                format: "%02lX%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier),
                Int(alpha * multiplier)
            )
        }
    }
}

