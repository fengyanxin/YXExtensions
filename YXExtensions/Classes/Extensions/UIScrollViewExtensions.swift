//
//  UIScrollViewExtensions.swift
//  YXExtensions
//
//  Created by 彭鹤 on 2023/3/21.
//

import Foundation

extension UIScrollView {

    //MARK: -- scrollView滑动到底部
    func yx_scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        setContentOffset(bottomOffset, animated: true)
    }
    
    //MARK: -- 截长屏Image
    var yx_screenshotLongImage: UIImage? {

        var image: UIImage? = nil
        let savedContentOffset = contentOffset
        let savedFrame = frame

        contentOffset = .zero
        frame = CGRect(x: 0, y: 0,
                       width: contentSize.width,
                       height: contentSize.height)

        UIGraphicsBeginImageContext(frame.size)
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: frame.size.width,
                   height: frame.size.height),
            false,
            UIScreen.main.scale)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        print("contentSize == \(contentSize)")
        contentOffset = savedContentOffset
        frame = savedFrame
        return image
    }
}
