//
//  UIColor+Ext.swift
//  member'sCal
//
//  Created by Junichi Sakonaka on 2016/03/22.
//  Copyright © 2016年 yoshidajumokui.llc. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    // http://www.colordic.org/w/
    
    class func sunday() -> UIColor {
        return hexStr("d70035", alpha: 1.0) // carmine
    }
    
    class func saturday() -> UIColor {
        return hexStr("26499d", alpha: 1.0) // oriental blue
    }

    class func kurocha() -> UIColor {
        return hexStr("583822", alpha: 1.0)
    }
    
    class func mahogany() -> UIColor {
        return hexStr("6b3f31", alpha: 1.0)
    }
    
    class func yanaginezu() -> UIColor{
        return hexStr("c8d5bb",alpha:  1.0)
    }
    
    class func imageColor() -> UIColor{
        return hexStr("3f261a",alpha:  1.0)
    }
    
    class func imageColorAlpha() -> UIColor{
        return hexStr("3f261a",alpha:  0.5)
    }
    
    
    class func hexStr (var hexStr : NSString, let alpha : CGFloat) -> UIColor {
        hexStr = hexStr.stringByReplacingOccurrencesOfString("#", withString: "")
        let scanner = NSScanner(string: hexStr as String)
        var color: UInt32 = 0
        if scanner.scanHexInt(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r,green:g,blue:b,alpha:alpha)
        } else {
            print("invalid hex string")
            return UIColor.whiteColor();
        }
    }
}
