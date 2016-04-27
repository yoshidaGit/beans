//
//  WorkTableViewCell.swift
//  member'sCal
//
//  Created by 吉田＿悟志 on 2016/03/20.
//  Copyright © 2016年 yoshidajumokui.llc. All rights reserved.
//

import UIKit

class WorkTableViewCell: UITableViewCell/*,UICollectionViewDelegate,UICollectionViewDataSource */{
    @IBOutlet weak var start: UILabel!
    @IBOutlet weak var finish: UILabel!
    @IBOutlet weak var workName: UILabel!
    
    @IBOutlet weak var memberCollectionView: UICollectionView!
    
    func setCollectionViewDataSourceDelegate < D : protocol < UICollectionViewDataSource , UICollectionViewDelegate >> ( dataSourceDelegate : D , forRow row : Int ) { memberCollectionView . delegate = dataSourceDelegate
        memberCollectionView . dataSource = dataSourceDelegate
        memberCollectionView . tag = row
        memberCollectionView . reloadData () }
    
    
    
    
    
    
    
    
//    let ad = UIApplication.sharedApplication().delegate as! AppDelegate
//    let Beans:[UIImage] = [
//        UIImage(named:"1.png")!,
//        UIImage(named:"2.png")!,
//        UIImage(named:"3.png")!
//    ]
////    beansCollectionInTableView.Delegate = CalViewController()
//    
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        //tagが”1”のbeansColection:UICollectionview
//        
//            if indexPath.section == 0{
//                let cell:CalViewBeansInTableViewToCell = collectionView.dequeueReusableCellWithReuseIdentifier("cellInTableView", forIndexPath: indexPath) as! CalViewBeansInTableViewToCell
//                cell.layer.cornerRadius = 4
//                cell.beansCollectionImage.image = Beans[ad.memberBeans[indexPath.row]]
//                //cell.beansCollectionName.text = ad.memberName[indexPath.row]
//                return cell
//            
//        }
//        
//        
//     return UICollectionViewCell()
//    
//    }
//        
//    // セクションの数（今回は1つだけです）
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    // 表示するセルの数
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 5
//    }
//    
//    //セルをタップしたとき
//    func collectionView(collectionView:UICollectionView,didSelectItemAtIndexPath indexPath:NSIndexPath){
//        
//    }
    
        
        
        
    
   
}
