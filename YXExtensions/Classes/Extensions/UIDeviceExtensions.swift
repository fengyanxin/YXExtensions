//
//  UIDeviceExtensions.swift
//  YXExtensions
//
//  Created by 彭鹤 on 2023/3/21.
//

import Foundation

public extension UIDevice {
    
    static let extensions = UIDeviceExtension()

    struct UIDeviceExtension {
        
        //MARK: -- 获取设备名称
        public var yx_modelName: String {
            var systemInfo = utsname()
            uname(&systemInfo)
            let machineMirror = Mirror(reflecting: systemInfo.machine)
            let identifier = machineMirror.children.reduce("") { identifier, element in
                guard let value = element.value as? Int8, value != 0 else { return identifier }
                return identifier + String(UnicodeScalar(UInt8(value)))
            }

            switch identifier {

            case "iPod1,1":  return "iPod Touch 1"
            case "iPod2,1":  return "iPod Touch 2"
            case "iPod3,1":  return "iPod Touch 3"
            case "iPod4,1":  return "iPod Touch 4"
            case "iPod5,1":  return "iPod Touch (5 Gen)"
            case "iPod7,1":  return "iPod Touch 6"

            case "iPhone3,1", "iPhone3,2", "iPhone3,3":  return "iPhone4"
            case "iPhone4,1":  return "iPhone4s"
            case "iPhone5,1":  return "iPhone5"
            case "iPhone5,2":  return "iPhone5(GSM+CDMA)"
            case "iPhone5,3":  return "iPhone5c(GSM)"
            case "iPhone5,4":  return "iPhone5c(GSM+CDMA)"
            case "iPhone6,1":  return "iPhone5s(GSM)"
            case "iPhone6,2":  return "iPhone5s(GSM+CDMA)"
            case "iPhone7,2":  return "iPhone6"
            case "iPhone7,1":  return "iPhone6Plus"
            case "iPhone8,1":  return "iPhone6s"
            case "iPhone8,2":  return "iPhone6sPlus"
            case "iPhone8,4":  return "iPhoneSE"
            case "iPhone9,1":  return "iPhone7"
            case "iPhone9,2":  return "iPhone7Plus"
            case "iPhone9,3":  return "iPhone7"
            case "iPhone9,4":  return "iPhone7Plus"
            case "iPhone10,1","iPhone10,4":   return "iPhone8"
            case "iPhone10,2","iPhone10,5":   return "iPhone8Plus"
            case "iPhone10,3","iPhone10,6":   return "iPhoneX"
            case "iPhone11,2":                return "iPhoneXS"
            case "iPhone11,4","iPhone11,6":   return "iPhoneXSMax"
            case "iPhone11,8": return "iPhoneXR"
            case "iPhone12,1": return "iPhone11"
            case "iPhone12,3": return "iPhone11Pro"
            case "iPhone12,5": return "iPhone11ProMax"
            case "iPhone12,8": return "iPhoneSE(2nd generation)"
            case "iPhone13,1": return "iPhone12mini"
            case "iPhone13,2": return "iPhone12"
            case "iPhone13,3": return "iPhone12Pro"
            case "iPhone13,4": return "iPhone12ProMax"

            case "iPad1,1":   return "iPad"
            case "iPad1,2":   return "iPad 3G"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":   return "iPad 2"
            case "iPad2,5", "iPad2,6", "iPad2,7":  return "iPad Mini"
            case "iPad3,1", "iPad3,2", "iPad3,3":  return "iPad 3"
            case "iPad3,4", "iPad3,5", "iPad3,6":  return "iPad 4"
            case "iPad4,1", "iPad4,2", "iPad4,3":  return "iPad Air"
            case "iPad4,4", "iPad4,5", "iPad4,6":  return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":  return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":  return "iPad Mini 4"
            case "iPad5,3", "iPad5,4":  return "iPad Air 2"
            case "iPad6,3", "iPad6,4":  return "iPad Pro 9.7"
            case "iPad6,7", "iPad6,8":  return "iPad Pro 12.9"

            case "AppleTV2,1":              return "Apple TV 2"
            case "AppleTV3,1","AppleTV3,2": return "Apple TV 3"
            case "AppleTV5,3":              return "Apple TV 4"

            case "i386", "x86_64", "arm64": return "Simulator"

            default:  return identifier
            }
        }
    }
}

public extension UIDevice{
    
    //MARK: -- 获取设备名称
    static var yx_modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        switch identifier {

        case "iPod1,1":  return "iPod Touch 1"
        case "iPod2,1":  return "iPod Touch 2"
        case "iPod3,1":  return "iPod Touch 3"
        case "iPod4,1":  return "iPod Touch 4"
        case "iPod5,1":  return "iPod Touch (5 Gen)"
        case "iPod7,1":  return "iPod Touch 6"

        case "iPhone3,1", "iPhone3,2", "iPhone3,3":  return "iPhone4"
        case "iPhone4,1":  return "iPhone4s"
        case "iPhone5,1":  return "iPhone5"
        case "iPhone5,2":  return "iPhone5(GSM+CDMA)"
        case "iPhone5,3":  return "iPhone5c(GSM)"
        case "iPhone5,4":  return "iPhone5c(GSM+CDMA)"
        case "iPhone6,1":  return "iPhone5s(GSM)"
        case "iPhone6,2":  return "iPhone5s(GSM+CDMA)"
        case "iPhone7,2":  return "iPhone6"
        case "iPhone7,1":  return "iPhone6Plus"
        case "iPhone8,1":  return "iPhone6s"
        case "iPhone8,2":  return "iPhone6sPlus"
        case "iPhone8,4":  return "iPhoneSE"
        case "iPhone9,1":  return "iPhone7"
        case "iPhone9,2":  return "iPhone7Plus"
        case "iPhone9,3":  return "iPhone7"
        case "iPhone9,4":  return "iPhone7Plus"
        case "iPhone10,1","iPhone10,4":   return "iPhone8"
        case "iPhone10,2","iPhone10,5":   return "iPhone8Plus"
        case "iPhone10,3","iPhone10,6":   return "iPhoneX"
        case "iPhone11,2":                return "iPhoneXS"
        case "iPhone11,4","iPhone11,6":   return "iPhoneXSMax"
        case "iPhone11,8": return "iPhoneXR"
        case "iPhone12,1": return "iPhone11"
        case "iPhone12,3": return "iPhone11Pro"
        case "iPhone12,5": return "iPhone11ProMax"
        case "iPhone12,8": return "iPhoneSE(2nd generation)"
        case "iPhone13,1": return "iPhone12mini"
        case "iPhone13,2": return "iPhone12"
        case "iPhone13,3": return "iPhone12Pro"
        case "iPhone13,4": return "iPhone12ProMax"

        case "iPad1,1":   return "iPad"
        case "iPad1,2":   return "iPad 3G"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":   return "iPad 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":  return "iPad Mini"
        case "iPad3,1", "iPad3,2", "iPad3,3":  return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":  return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":  return "iPad Air"
        case "iPad4,4", "iPad4,5", "iPad4,6":  return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":  return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":  return "iPad Mini 4"
        case "iPad5,3", "iPad5,4":  return "iPad Air 2"
        case "iPad6,3", "iPad6,4":  return "iPad Pro 9.7"
        case "iPad6,7", "iPad6,8":  return "iPad Pro 12.9"

        case "AppleTV2,1":              return "Apple TV 2"
        case "AppleTV3,1","AppleTV3,2": return "Apple TV 3"
        case "AppleTV5,3":              return "Apple TV 4"

        case "i386", "x86_64", "arm64": return "Simulator"

        default:  return identifier
        }
    }
}
