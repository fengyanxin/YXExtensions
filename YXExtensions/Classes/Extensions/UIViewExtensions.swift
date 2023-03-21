//
//  UIViewExtensions.swift
//  YXExtensions
//
//  Created by fengyanxin on 2023/3/16.
//

public extension UIView {
    
    //MARK: -- 设置渐变色
    func yx_setGradient(startColor: UIColor, endColor: UIColor, locations: Array<NSNumber>, startPoint: CGPoint ,endPoint: CGPoint) {
        
        let gradientLayer = CAGradientLayer()
        //几个颜色
        gradientLayer.colors = [startColor.cgColor,endColor.cgColor]
        //颜色的分界点
        gradientLayer.locations = locations
        //开始
        gradientLayer.startPoint = startPoint
        //结束,主要是控制渐变方向
        gradientLayer.endPoint  = endPoint
        //多大区域
        gradientLayer.frame = self.frame
        //最后作为背景
        self.layer.addSublayer(gradientLayer)
    }
    
    //MARK: -- 设置阴影
    func yx_setVShadow(color: UIColor, width: CGFloat, height: CGFloat, radius: CGFloat, opacity: Float){
        self.layer.shadowColor   = color.cgColor
        //阴影偏移量
        self.layer.shadowOffset  = CGSize(width:width, height:height)
        //定义view的阴影宽度，模糊计算的半径
        self.layer.shadowRadius  = radius
        //定义view的阴影透明度，注意:如果view没有设置背景色阴影也是不会显示的
        self.layer.shadowOpacity = opacity
    }
    
    //MARK: -- 切圆角
    func yx_setCorner(conrners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: conrners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    //MARK: -- 为 view 添加点击事件
    /// 为 view 添加点击事件
    /// - Parameters:
    ///   - target: 点击事件的目标
    ///   - action: 点击事件的响应
    func yx_addOnClickListener(target: AnyObject, action: Selector) {
      /// 创建手势
      let gr = UITapGestureRecognizer(target: target, action: action)
      /// 设置手指🤌个数
      gr.numberOfTapsRequired = 1
      /// 将 UIView 设置为可交互的
      isUserInteractionEnabled = true
      /// 将手势添加到 UIView
      addGestureRecognizer(gr)
    }
}
