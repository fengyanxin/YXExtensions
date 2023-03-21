//
//  StringExtensions.swift
//  YXExtensions
//
//  Created by 彭鹤 on 2023/3/21.
//

import Foundation

public extension String {
    
    //MARK: -- 类型转换
    func yx_toDouble() -> Double? {
       return Double(self)
    }
    func yx_toFloat() -> Float? {
       return Float(self)
    }
    func yx_toInt() -> Int? {
       return Int(self)
    }
    func yx_toURL() -> NSURL? {
       return NSURL(string: self)
    }
    
    //MARK: -- 将原始的url编码为合法的url
    func yx_urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }

    //MARK: -- 将编码后的url转换回原始的url
    func yx_urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }

    //MARK: -- 获取字符串字节长度
    func yx_getStringByteLength() ->Int{
        var bytes: [UInt8] = []
        for char in self.utf8{
            bytes.append(char.advanced(by:0))
        }
        print("\(self)长度:\(bytes.count)")
        return bytes.count
    }

    //MARK: -- 去掉首尾空格
    var yx_removeHeadAndTailSpace: String {
        let whitespace = NSCharacterSet.whitespaces
        return self.trimmingCharacters(in: whitespace)
    }
    
    //MARK: -- 去掉首尾空格 包括后面的换行 \n
    var yx_removeHeadAndTailSpacePro: String {
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        return self.trimmingCharacters(in: whitespace)
    }
    
    //MARK: -- 去掉所有空格
    var yx_removeAllSapce: String {
        return self.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }

    //MARK: -- 去掉中文空格占位符
    var yx_removeChineseSapce: String {
        var str: String = ""
        for character in self {
            print(character)
            print(character.unicodeScalars[character.unicodeScalars.startIndex].value)
            if character.unicodeScalars[character.unicodeScalars.startIndex].value != 8198 {
                str.append(character)
            }
        }
        return str
    }
    
    //MARK: -- 去掉首尾空格 后 指定开头空格数
    func yx_beginSpaceNum(num: Int) -> String {
        var beginSpace = ""
        for _ in 0..<num {
            beginSpace += " "
        }
        return beginSpace + self.yx_removeHeadAndTailSpacePro
    }

    //MARK: -- 是否匹配正则
    func yx_isMatchRegularExp(_ pattern: String) -> Bool {
        guard let reg = try? NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive) else {
            return false
        }
        let result = reg.matches(in: self, options: .reportProgress, range: NSMakeRange(0, self.count))
        return (result.count > 0)
    }
    
    //MARK: -- 使用正则表达式替换
    func yx_pregReplace(pattern: String, with: String,
                     options: NSRegularExpression.Options = []) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: options)
        return regex.stringByReplacingMatches(in: self, options: [],
                                              range: NSMakeRange(0, self.count),
                                              withTemplate: with)
    }
    
    //MARK: -- 去掉emoji符号
    func yx_disable_emoji(_ pattern: String, with str: String) -> Bool {

        guard let reg = try? NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive) else {
            return false
        }
        let result = reg.stringByReplacingMatches(
            in: str,
            options: [],
            range: NSRange(location: 0, length: NSString(string: str).length),
            withTemplate: "")
        return (result.count > 0)
    }

    //MARK: -- 判断是不是9宫格
    func yx_isNineKeyBoard(_ string: String?) -> Bool {
        let other = "➋➌➍➎➏➐➑➒"
        let len = string?.count ?? 0
        for _ in 0..<len {
            if !((other as NSString).range(of: string ?? "").location != NSNotFound) {
                return false
            }
        }
        return true
    }
    
    //MARK: -- H5地址参数解析
    var yx_parametersFromQueryString: [String: String]? {
        guard let components = URLComponents(url: (URL(string: self))!, resolvingAgainstBaseURL: true),
              let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }

    //MARK: -- 将HTML转化成富文本
    var yx_htmlToAttributedString: NSAttributedString? {
        let width = UIScreen.main.bounds.width-20
        var html = "<head><style>img{max-width:\(width) !important;height:auto}</style></head>\(self)"
        html = html.replacingOccurrences(of: "<img", with: "<img width=\"\(width)\"")
        html = html.replacingOccurrences(of: "<p>", with: "")
        html = html.replacingOccurrences(of: "</p>", with: "")

        guard let data = html.data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }

    //MARK: -- 将HTML转化成富文本，然后转化成字符串
    var yx_htmlToString: String {
        return yx_htmlToAttributedString?.string ?? ""
    }
}

//MARK: -- 静态方法
public extension String{

    //MARK: -- 将秒数转化成时间字符串 （00m00s）
    static func FormatDate(second: Int) ->String{

        let formatter = DateComponentsFormatter.init()

       //.pad为0:00:00格式 其他的我测试为 当时分秒任意为0时省略
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = NSCalendar.Unit(rawValue: NSCalendar.Unit.minute.rawValue | NSCalendar.Unit.second.rawValue)
//        //.positional 是数字:数字:数字格式 其他选项我测试为中文格式
//        formatter.unitsStyle = DateComponentsFormatter.UnitsStyle.positional

        //00:00:00
        let str = formatter.string(from:TimeInterval(second)) ?? ""
        let array :[String] = str.components(separatedBy: ":")

        var returnStr = ""
        if Int(array[0]) == 0{
            returnStr = "0m\(array[1])s"
        }else{
            if Int(array[1]) == 0{
                returnStr = "\(array[0])m0s"
            }else{
                returnStr = "\(array[0])m\(array[1])s"
            }
        }
        return returnStr
    }
}
