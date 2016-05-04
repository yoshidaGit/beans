//
//  UIButtonIBDesignable.swift
//  member'sCal
//
//  Created by 吉田＿悟志 on 2016/05/04.
//  Copyright © 2016年 yoshidajumokui.llc. All rights reserved.
//

import UIKit


@IBDesignable
class UIButtonIBDesignable: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clearColor() {
        didSet {
            layer.borderColor = borderColor.CGColor
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            setNeedsDisplay()
        }
    }
    
    // when you want to change highlighted color
    override var highlighted: Bool {
        didSet {
            if (highlighted) {
                layer.removeAnimationForKey("borderColor")
                layer.borderColor = borderColor.colorWithAlphaComponent(0.2).CGColor
            } else {
                layer.borderColor = borderColor.CGColor
                let color = CABasicAnimation(keyPath: "borderColor")
                color.duration = 0.2
                color.fromValue = borderColor.colorWithAlphaComponent(0.2).CGColor
                color.toValue = borderColor.CGColor
                layer.addAnimation(color, forKey: "borderColor")
            }
        }
    }
}
