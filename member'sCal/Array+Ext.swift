//
//  Array+Ext.swift
//  member'sCal
//
//  Created by 吉田＿悟志 on 2016/03/31.
//  Copyright © 2016年 yoshidajumokui.llc. All rights reserved.
//

import Foundation

extension Array {
    mutating func indexOfAll<T : Equatable>(obj : T) -> [Int] {
        var indexarray:[Int]=[]
        for (index, objeToCompare) in self.enumerate() {
            guard obj == objeToCompare as! T else { continue }
            indexarray.append(index)
        }
        return indexarray
    }
}
