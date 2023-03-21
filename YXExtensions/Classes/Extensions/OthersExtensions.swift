//
//  OthersExtensions.swift
//  YXExtensions
//
//  Created by 彭鹤 on 2023/3/21.
//

import Foundation
import UIKit

//MARK: -- 常用方法

//MARK: -- 动态计算Label高度
func yx_getLabelHeight(str: String, font: UIFont, width: CGFloat)-> CGFloat {

    let statusLabelText: NSString = str as NSString
    let size = CGSize(width: width, height: CGFloat(MAXFLOAT))
    let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin,
                                               attributes: [NSAttributedString.Key.font : font],
                                               context: nil).size
    return strSize.height
}

//MARK: -- 字典转json字符串
func yx_getJsonStringFromDictionary(dictionary: NSDictionary) -> NSString {
    
    if (!JSONSerialization.isValidJSONObject(dictionary)) {
        print("无法解析出JSONString")
        return ""
    }
    guard let data: NSData? = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData? else{return ""}
    let JSONString = NSString(data: data! as Data, encoding: String.Encoding.utf8.rawValue)
    return JSONString!
}

//MARK: -- JSONString 转换为字典
func yx_getDictionaryFromJsonString(jsonString: String) ->NSDictionary {
    let jsonData:Data = jsonString.data(using: .utf8)!
    let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
    if dict != nil {
        return dict as! NSDictionary
    }
    return NSDictionary()
}

//MARK: -- Dictionary扩展
extension Dictionary {
    
    //MARK: -- Dictionary转化成json打印
    func yx_jsonPrint() {
        let ff = try! JSONSerialization.data(withJSONObject:self, options: [])
        let str = String(data:ff, encoding: .utf8)
        print(str!)
    }
}

//MARK: -- Array扩展
extension Array {
    
    //MARK: -- Array转化成json打印
    func yx_jsonPrint() {
        let ff = try! JSONSerialization.data(withJSONObject:self, options: [])
        let str = String(data:ff, encoding: .utf8)
        print(str!)
    }
}

//MARK: -- NSMutableAttributedString扩展
extension NSMutableAttributedString {
    //MARK: - 偏移量
    /// 设置上下偏移量 正数上移，负数下移
    public func opAddBaselineOffset(_ offset: Float, range: NSRange) {
        if self.length < range.location + range.length { return }
        let attrs = [NSAttributedString.Key.baselineOffset: offset]
        self.addAttributes(attrs, range: range)
    }
}

//MARK: -- 去设置界面
func yx_openSystemSettings() {
    let url = URL(string: UIApplication.openSettingsURLString)
    if let url = url {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.openURL(url)
        }
    }
}
