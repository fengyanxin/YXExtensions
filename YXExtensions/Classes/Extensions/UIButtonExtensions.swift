//
//  UIButtonExtensions.swift
//  YXExtensions
//
//  Created by fengyanxin on 2023/3/16.
//

public enum UIButtonImageAndTitlePositionType{
    case imageIsLeft    //图片在左，文字在右
    case imageIsRight   //图片在右，文字在左
    case imageIsTop     //图片在上，文字在下
    case imgageIsBottom //图片在下，文字在上
}

public extension UIButton {
    
    //MARK: -- 调整 button 图片和文字的位置
    func yx_setUpButtonImageAndTitlePositionWith(padding: CGFloat, type: UIButtonImageAndTitlePositionType){
        let imageRect: CGRect = self.imageView?.frame ?? CGRect.init()
        let titleRect: CGRect = self.titleLabel?.frame ?? CGRect.init()
        let selfWidth: CGFloat  = self.frame.size.width
        let selfHeight: CGFloat = self.frame.size.height
        let totalHeight = titleRect.size.height + padding + imageRect.size.height
        switch type {
        case .imageIsLeft:
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: padding / 2, bottom: 0, right: -padding / 2)
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -padding / 2, bottom: 0, right: padding / 2)
        case .imageIsRight:
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(imageRect.size.width + padding/2), bottom: 0, right: (imageRect.size.width + padding/2))
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: (titleRect.size.width + padding / 2), bottom: 0, right: -(titleRect.size.width +  padding/2))
        case .imageIsTop :
            self.titleEdgeInsets = UIEdgeInsets(top: ((selfHeight - totalHeight) / 2 + imageRect.size.height + padding - titleRect.origin.y), left: (selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2, bottom: -((selfHeight - totalHeight) / 2 + imageRect.size.height + padding - titleRect.origin.y), right: -(selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2)
            self.imageEdgeInsets = UIEdgeInsets(top: ((selfHeight - totalHeight) / 2 - imageRect.origin.y), left: (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2), bottom: -((selfHeight - totalHeight) / 2 - imageRect.origin.y), right: -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2))
        case .imgageIsBottom:
            self.titleEdgeInsets = UIEdgeInsets(top: ((selfHeight - totalHeight) / 2 - titleRect.origin.y), left: (selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2, bottom: -((selfHeight - totalHeight) / 2 - titleRect.origin.y), right: -(selfWidth/2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2)
            self.imageEdgeInsets = UIEdgeInsets(top: ((selfHeight - totalHeight) / 2 + titleRect.size.height + padding - imageRect.origin.y), left: (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2), bottom: -((selfHeight - totalHeight) / 2 + titleRect.size.height + padding - imageRect.origin.y), right: -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2))
        default:
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}
