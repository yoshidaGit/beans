//
//  GenbaViewController.swift
//  member'sCal
//
//  Created by 吉田air on 2015/06/14.
//  Copyright (c) 2015年 yoshidajumokui.llc. All rights reserved.
//

import UIKit

class GenbaViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var workName: UITextField!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var finishTime: UILabel!
    @IBOutlet weak var timeControllView: UIView!
    @IBOutlet weak var todayMember: UICollectionView!
    @IBOutlet weak var serectMember: UICollectionView!
    
    var ad = UIApplication.sharedApplication().delegate as! AppDelegate//---------------appDelegateを取得

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    let Beans:[UIImage] = [
        UIImage(named:"1.png")!,
        UIImage(named:"2.png")!,
        UIImage(named:"3.png")!
    ]
    
    

//    ---------------------------------------------------------------------------------コレクションビュー処理
//     セルが表示されるときに呼ばれる処理（1個のセルを描画する毎に呼び出されます
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        if( collectionView.tag == 1000 ) { return numberOfRows1() } if( collectionView.tag == 2000 ) { return numberOfRows2() }
        
        switch collectionView.tag{
        case 1000:
            let cell1:TodayMemberCell = collectionView.dequeueReusableCellWithReuseIdentifier("todayMember", forIndexPath: indexPath) as! TodayMemberCell
            cell1.todayBeans.image = UIImage(named:"1png")
            return cell1
            
        case 2000:
            let cell2:SelectMemberCell = collectionView.dequeueReusableCellWithReuseIdentifier("selectBeans", forIndexPath: indexPath) as! SelectMemberCell
            var number = ad.memberBeans[indexPath.row]
            cell2.beansImage.image = Beans[number]
            cell2.beansName.text = ad.memberName[indexPath.row]
            return cell2
        default:return UICollectionViewCell()
    }
    }
    
    // セクションの数（とりあえず）
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if collectionView.tag == 1000{
            return 0
        }else{
            return 0
        }
    }
    
    // 表示するセルの数（とりあえず）
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1000{
            return ad.calBeans.count
        }else{
            return ad.calBeans.count
        }
    }
    
}
