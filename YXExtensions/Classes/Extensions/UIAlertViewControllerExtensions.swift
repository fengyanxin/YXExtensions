//
//  UIAlertViewControllerExtensions.swift
//  YXExtensions
//
//  Created by 彭鹤 on 2023/3/21.
//

import Foundation

public extension UIAlertController {
    
    //MARK: -- 在指定视图控制器上弹出普通消息提示框
    static func yx_showAlert(message: String, confirm: String, in viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: confirm, style: .cancel))
        viewController.present(alert, animated: true)
    }

    //MARK: -- 在根视图控制器上弹出普通消息提示框
    static func yx_showAlert(message: String, confirm: String) {
        if let vc = UIApplication.shared.windows.first(where: { $0.rootViewController != nil })?.rootViewController {
            yx_showAlert(message: message, confirm: confirm, in: vc)
        }
    }

    //MARK: -- 在指定视图控制器上弹出确认取消框
    static func yx_showConfirm(title: String, message: String, leftTitle: String, rightTitle: String, in viewController: UIViewController, cancel: ((UIAlertAction)->Void)?, confirm: ((UIAlertAction)->Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        //修改title
        let alertControllerStr = NSMutableAttributedString(string: title)
        alertControllerStr.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: 0, length: title.count))
        alert.setValue(alertControllerStr, forKey: "attributedTitle")

        //通过富文本来设置行间距
        let  paraph1 =  NSMutableParagraphStyle ()
        //设置行间距
        paraph1.lineSpacing = 5
        paraph1.alignment   = .center

        //修改message
        let alertControllerMessageStr = NSMutableAttributedString(string: message)
        alertControllerMessageStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 14),range: NSRange(location: 0, length: message.count))
        alertControllerMessageStr.addAttribute(.paragraphStyle, value: paraph1, range: NSRange(location: 0, length: message.count))
        alert.setValue(alertControllerMessageStr, forKey: "attributedMessage")

        let action1 = UIAlertAction(title: leftTitle, style: .default, handler: cancel)
//        action1.setValue(UIColor.lightGray, forKey: "titleTextColor")

        let action2 = UIAlertAction(title: rightTitle, style: .default, handler: confirm)

        alert.addAction(action1)
        alert.addAction(action2)

        viewController.present(alert, animated: true)
    }
    
    //MARK: -- 在指定视图控制器上弹出确认框（只有确认）
    static func yx_showConfirm(title: String, message: String, btntitle: String, in viewController: UIViewController, confirm: ((UIAlertAction)->Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        //修改title
        let alertControllerStr = NSMutableAttributedString(string: title)
        alertControllerStr.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 14), range: NSRange(location: 0, length: title.count))
        alert.setValue(alertControllerStr, forKey: "attributedTitle")

        //通过富文本来设置行间距
        let  paraph1 =  NSMutableParagraphStyle ()
        //设置行间距
        paraph1.lineSpacing = 5
        paraph1.alignment   = .center

        //修改message
        let alertControllerMessageStr = NSMutableAttributedString(string: message)
        alertControllerMessageStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 14),range: NSRange(location: 0, length: message.count))
        alertControllerMessageStr.addAttribute(.paragraphStyle, value: paraph1, range: NSRange(location: 0, length: message.count))
        alert.setValue(alertControllerMessageStr, forKey: "attributedMessage")

        let action2 = UIAlertAction(title: btntitle, style: .default, handler: confirm)
        action2.setValue(UIColor.black, forKey: "titleTextColor")

        alert.addAction(action2)

        viewController.present(alert, animated: true)
    }

    //MARK: -- 在根视图控制器上弹出确认框
    static func yx_showConfirm(title: String, message: String, leftTitle: String, rightTitle: String,cancel:((UIAlertAction)->Void)?,confirm: ((UIAlertAction)->Void)?) {
        if let vc = UIApplication.shared.windows.last(where: { $0.rootViewController != nil })?.rootViewController{
            yx_showConfirm(title: title, message: message, leftTitle: leftTitle, rightTitle: rightTitle, in: vc, cancel: cancel,confirm: confirm)
        }
    }

    //MARK: -- 带输入框的弹框
    static func yx_showInputAlert(title: String, message: String, leftTitle: String, rightTitle: String, in viewController: UIViewController, cancel: ((UIAlertAction)->Void)?, confirm: ((UIAlertAction)->Void)?){

        //初始化UITextField
        var inputText1: UITextField = UITextField();
        let msgAlertCtr = UIAlertController.init(title: title, message: message, preferredStyle: .alert)

        let cancel = UIAlertAction.init(title: leftTitle, style: .cancel, handler: cancel)
        let ok     = UIAlertAction.init(title: rightTitle, style: .default, handler: confirm)

        msgAlertCtr.addAction(cancel)
        msgAlertCtr.addAction(ok)

        //添加textField输入框
        msgAlertCtr.addTextField { (textField) in
            //设置传入的textField为初始化UITextField
            inputText1 = textField
            inputText1.text = ""
        }
        //设置到当前视图
        viewController.present(msgAlertCtr, animated: true, completion: nil)
    }
}
