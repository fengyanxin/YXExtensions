//
//  UIImageExtensions.swift
//  YXExtensions
//
//  Created by 彭鹤 on 2023/3/21.
//

import Foundation


public extension UIImage{
    
    //渐变色方向
    enum YX_GradientImageDirectionType{
        case leftBottomToRightBottom //横向
        case RightTopToRightBottom   //纵向
        case leftTopToRightBottom    //斜向
    }

    //MARK: -- 通过输入rgb值返回一个该颜色的img
    static func yx_getRenderImageWithColor(_ color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return UIImage()
        }
        context.setFillColor(color.cgColor);
        context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height));
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img ?? UIImage()
    }

    //MARK: -- 通过输入一个颜色数组返回一个渐变色的img
    
    static func yx_getGradientImageWithColors(withColors colors: [CGColor], imgSize: CGSize, direction: YX_GradientImageDirectionType) -> UIImage? {

        var arRef: [CGColor] = []
        for ref in colors{
            guard let ref = ref as? CGColor else {
                continue
            }
            if let color = ref as? CGColor {
                arRef.append(color)
            }
        }
        UIGraphicsBeginImageContextWithOptions(imgSize, true, 1)
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        let colorSpace = colors.last?.colorSpace
        var gradient: CGGradient? = nil
        gradient = CGGradient(colorsSpace: colorSpace, colors: arRef as CFArray, locations: nil)

        var start = CGPoint(x: 0.0, y: 0.0)

        if direction == .RightTopToRightBottom{
            start = CGPoint(x: imgSize.width, y: 0.0)
        }else if direction == .leftBottomToRightBottom{
            start = CGPoint(x: 0.0, y: imgSize.height)
        }else if direction == .leftBottomToRightBottom{
            start = CGPoint(x: 0.0, y: 0.0)
        }

        let end   = CGPoint(x: imgSize.width, y: imgSize.height)
        context?.drawLinearGradient(gradient!, start: start, end: end, options: .drawsBeforeStartLocation)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        context?.restoreGState()
        UIGraphicsEndImageContext()
        return image
    }
}
