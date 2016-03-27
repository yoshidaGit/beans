//
//  GenbaViewController.swift
//  member'sCal
//
//  Created by 吉田air on 2015/06/14.
//  Copyright (c) 2015年 yoshidajumokui.llc. All rights reserved.
//

import UIKit

class GenbaViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    @IBOutlet weak var workName: UITextField!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var finishTime: UILabel!
    @IBOutlet weak var timeControllView: UIView!
    @IBOutlet weak var todayMember: UICollectionView!
    @IBOutlet weak var serectMember: UICollectionView!
    
    var selectMemberViewC = SelectMemberCollectionView()
    var todayMemberViewC = TodayMemberCollectionView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.serectMember.dataSource = self.selectMemberViewC
        self.todayMember.dataSource = self.todayMemberViewC


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
        
        
    }
    


    //---------------------------------------------------------------------------------コレクションビュー処理
    // セルが表示されるときに呼ばれる処理（1個のセルを描画する毎に呼び出されます
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        
//        let cell:dayCell = collectionView.dequeueReusableCellWithReuseIdentifier("calCell1", forIndexPath: indexPath) as! dayCell
//        //        cell.lblSample.text = "ラベル\(indexPath.row)";
//        //        cell.selectBeans.image = UIImage(named: "1.png")
//        return cell
//    }
//    
//    // セクションの数（とりあえず）
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        return 0
//    }
//    
//    // 表示するセルの数（とりあえず）
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10
//    }
    
}
