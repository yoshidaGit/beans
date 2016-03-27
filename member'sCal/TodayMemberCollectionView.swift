//
//  TodayMemberCollectionView.swift
//  member'sCal
//
//  Created by 吉田＿悟志 on 2016/03/27.
//  Copyright © 2016年 yoshidajumokui.llc. All rights reserved.
//

import UIKit

class TodayMemberCollectionView: NSObject,UICollectionViewDataSource {
    
    
    
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:TodayMemberCell = collectionView.dequeueReusableCellWithReuseIdentifier("todayMember", forIndexPath: indexPath) as! TodayMemberCell
        //        cell.lblSample.text = "ラベル\(indexPath.row)";
        //        cell.selectBeans.image = UIImage(named: "1.png")
        return cell
    }
    
    // セクションの数（とりあえず）
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 0
    }
    
    // 表示するセルの数（とりあえず）
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

}
