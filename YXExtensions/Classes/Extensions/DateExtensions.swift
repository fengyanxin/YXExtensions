//
//  DateExtensions.swift
//  YXExtensions
//
//  Created by 彭鹤 on 2023/3/21.
//

import Foundation

public extension Date{
    
    //MARK: -- 12小时制的时间类型
    enum YX_TimeFormat12Hour: String {
        case YYYYMMDD          = "YYYY-MM-dd"
        case YYYYMMDDHH        = "YYYY-MM-dd hh a"
        case YYYYMMDDHHMM      = "YYYY-MM-dd hh:mm a"
        case YYYYMMDDHHMMSS    = "YYYY-MM-dd hh:mm:ss a"
        case YYYYMMDDHHMMSSsss = "YYYY-MM-dd HH:mm:ss.SSS"
    }
    
    //MARK: -- 12小时制的时间类型
    enum YX_TimeFormat24Hour: String {
        case YYYYMMDD          = "YYYY-MM-dd"
        case YYYYMMDDHH        = "YYYY-MM-dd HH"
        case YYYYMMDDHHMM      = "YYYY-MM-dd HH:mm"
        case YYYYMMDDHHMMSS    = "YYYY-MM-dd HH:mm:ss"
        case YYYYMMDDHHMMSSsss = "YYYY-MM-dd HH:mm:ss.SSS"
    }
}

public extension Date{
    
    //MARK: -- 获取当前时间戳 -秒级 -10位
    var yx_getTimeInterval : String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return "\(timeStamp)"
    }

    //MARK: -- 获取当前时间戳 -毫秒级 - 13位
    var yx_getTimeIntervalMilli : String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return "\(millisecond)"
    }
}

public extension Date{
    
    //MARK: -- 获取当前时间（YYYY-MM-dd HH:mm）
    static func yx_getCurrentTime() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "YYYY-MM-dd HH:mm"// 自定义时间格式
        // GMT时间 转字符串，直接是系统当前时间
        return dateformatter.string(from: Date())
    }
    
    //MARK: -- 获取当前时间（YYYY-MM-dd HH:mm:ss）
    static func yx_getAllCurrentTime() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "YYYY-MM-dd HH:mm:ss"// 自定义时间格式
        // GMT时间 转字符串，直接是系统当前时间
        return dateformatter.string(from: Date())
    }
    
    //MARK: -- 获取当前时间（YYYY-MM-dd HH:mm）
    static func yx_getTimeWithDateFormat(dateString: String) -> String {

        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "YYYY-MM-dd HH:mm"// 自定义时间格式
        let date = dateformatter.date(from: dateString)

        // GMT时间 转字符串，直接是系统当前时间
        return dateformatter.string(from: date ?? Date())
    }

    //MARK: -- 时间戳转成字符串
    static func yx_timeIntervalToString(timeInterval:Double, _ dateFormat:String? = "yyyy-MM-dd HH:mm:ss") -> String {

        //是否精确到毫秒级
        var date:Date!
        if String(timeInterval).count >= 13{
            date = Date.init(timeIntervalSince1970: timeInterval/1000)
        }else{
            date = Date.init(timeIntervalSince1970: timeInterval)
        }
        let formatter = DateFormatter.init()
        if dateFormat == nil {
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }else{
            formatter.dateFormat = dateFormat
        }
        formatter.locale = Locale.init(identifier: "zh_CN")
        return formatter.string(from: date as Date)
    }

//    //MARK:- 字符串转时间戳
//    static func yx_StringTotimeInterval(_ dateFormat:String? = "yyyy-MM-dd HH:mm:ss") -> String {
//          if self.isEmpty {
//              return ""
//          }
//          let format = DateFormatter.init()
//          format.dateStyle = .medium
//          format.timeStyle = .short
//          if dateFormat == nil {
//              format.dateFormat = "yyyy-MM-dd HH:mm:ss"
//          }else{
//              format.dateFormat = dateFormat
//          }
//          let date = format.date(from: self)
//          return String(date!.timeIntervalSince1970)
//    }

    //MARK: -- 日期 -> 字符串
    static func yx_dateToString(_ date: Date, dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }
    
    //MARK: -- 字符串 -> 日期
    static func yx_stringToDate(_ string: String, dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.date(from: string)
        return date!
    }

    //MARK: -- 返回对应日期是周几
    static func yx_getWeekDayByDate(date: Date) -> String{
       guard let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian) else {
           return ""
       }
       let components = calendar.components([.weekOfYear,.weekOfMonth,.weekday,.weekdayOrdinal], from: date)
       /*
       //今年的第几周
       let weekOfYear = components.weekOfYear!
       //这个月第几周
       let weekOfMonth = components.weekOfMonth!
       //这个月第几周
       let weekdayOrdinal = components.weekdayOrdinal!*/
       //周几
       let weekday = components.weekday!
       //调整前  1、2、3、4、5、6、7 分别对应 周日、周一、周二、周三、周四、周五、周六
       let cnWeekday = [7, 1, 2, 3, 4, 5, 6]
       //调整后  1、2、3、4、5、6、7 分别对应 周一、周二、周三、周四、周五、周六、周日

        //星期
       let array = ["周日","周一","周二","周三","周四","周五","周六"]
       let newWeekDay = cnWeekday[weekday-1]
       let week = array[newWeekDay]

       return week
   }
   
   //MARK: -- 计算当前日期和输入的日期相差几天
   func daysBetweenDate(toDate: Date) -> Int {
        let components = Calendar.current.dateComponents([.day],from: self,to: toDate)
        return components.day ?? 0
   }
}
