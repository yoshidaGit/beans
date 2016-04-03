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

    var memberStack:[Int]? = []//トゥデイメンバーのいれもの
    var memberSelect = Dictionary<String,Int>()
//    var memberSelect:[Int] = []
    
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
//-------------------------------------------------------------------------------------セルに描画するもの
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1000{
            var cell1:TodayMemberCell = collectionView.dequeueReusableCellWithReuseIdentifier("todayMember", forIndexPath: indexPath) as! TodayMemberCell
//            cell1.todayBeans.image = Beans[memberStack![indexPath.row]]
            
 //           cell1.todayBeans.image =
            
            
            
            
            return cell1
        }else if (collectionView.tag == 2000){
            let cell2:SelectMemberCell = collectionView.dequeueReusableCellWithReuseIdentifier("selectBeans", forIndexPath: indexPath) as! SelectMemberCell
                let number = ad.memberBeans[indexPath.row]
                cell2.beansImage.image = Beans[number]
                cell2.layer.cornerRadius = 4
                        cell2.beansName.text = ad.memberName[indexPath.row]
                        return cell2
        }
        return UICollectionViewCell()
    }

    
    
//--------------------------------------------------------------------------------------複数のセルを選択する処理
//--------------------------------------------------------------------------------------選択したとき
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        if collectionView.tag == 2000{
            collectionView.allowsMultipleSelection = true
            var cell = collectionView.cellForItemAtIndexPath(indexPath)
           
            if cell?.selected == true {

                cell?.backgroundColor = UIColor.yanaginezu()
//                memberSelect[ad.memberName[indexPath.row]] = ad.memberBeans[indexPath.row]
                
                memberStack?.append(ad.memberBeans[indexPath.row])
                todayMember.reloadData()//todyaMemberリロード
            }
        }
    }
 
//---------------------------------------------------------------------------------------解除したとき
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        if collectionView.tag == 2000{
            collectionView.allowsMultipleSelection = true
            var cell = collectionView.cellForItemAtIndexPath(indexPath)
            
            if cell?.selected == false {
//                memberSelect.append(indexPath.row)
                cell?.backgroundColor = UIColor.clearColor()
                if memberStack?.count == 1{//--------------------配列が0になるときとまだ残ってるときの処理を分岐（クラッシュ対策）
                    memberStack?.removeAll()
                }else{
                memberStack?.removeAtIndex(ad.memberBeans[indexPath.row])
                }
//                if memberStack?.removeAtIndex(ad.memberBeans[indexPath.row]) == nil{
//                    memberStack?.removeAll()
//                }
                todayMember.reloadData()
            }
        }
    }
    
//    func memberSelect(select:Int) -> Int{
//        
//    }
//    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//---------------------------------------------------------------------------------------」ここまで
    


    
    // セクションの数（とりあえず）
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if collectionView.tag == 1000{
            return 1
        }else{
            return 1
        }
    }
    
    // 表示するセルの数（とりあえず）
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1000{
            return (memberStack?.count)!
        }else{
            return ad.memberBeans.count
        }
    }
}