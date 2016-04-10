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

    var memberStack:[Int]? = []//トゥデイメンバーのいれもの、選択された順番を保持
    var checkMark = Dictionary<Int,Bool>()//チェックマーク判定用
//    var memberSelected:NSMutableArray = NSMutableArray()
    var memberSelect = Dictionary<Int,String>()
//    var key:[String]? = []
//    var value:[Int]? = []
    
    var genIndex = 0
    
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
    
 
    override func viewWillAppear(animated: Bool) {
        genIndex = ad.ADIndex
        print(genIndex)
        workName.text = ad.calGenbaName[genIndex]
        startTime.text = ad.calStartTime[genIndex]
        finishTime.text = ad.calFinishTime[genIndex]
        //genIndex = ad.ADIndex
    }
    
    
    
    
    
  
    
    
    
    
    
    
    
    
    

//    ---------------------------------------------------------------------------------コレクションビュー処理
//-------------------------------------------------------------------------------------セルに描画するもの
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1000{
            var cell1:TodayMemberCell = collectionView.dequeueReusableCellWithReuseIdentifier("todayMember", forIndexPath: indexPath) as! TodayMemberCell
            
                     cell1.todayBeans.image = Beans[ad.memberBeans[(memberStack?[indexPath.row])!]]
            
            
            return cell1
        }else if (collectionView.tag == 2000){
            let cell2:SelectMemberCell = collectionView.dequeueReusableCellWithReuseIdentifier("selectBeans", forIndexPath: indexPath) as! SelectMemberCell
                let number = ad.memberBeans[indexPath.row]
                cell2.beansImage.image = Beans[number]
                cell2.layer.cornerRadius = 4
                cell2.beansName.text = ad.memberName[indexPath.row]
            
            //if checkMark.isEmpty != true{
            print("check\(checkMark[indexPath.row])")
                if checkMark[indexPath.row] == true{ checkMark[indexPath.row] = false//辞書にcollectionViewのインデックス番号ととチェック判定用ブールを保持 }else{ checkMark[indexPath.row] = true //辞書にcollectionViewのインデックス番号ととチェック判定用ブールを保持 }
                //if checkMark[indexPath.row] == true{
                    print("true")
                    cell2.chack.hidden = false
                }else{
                    cell2.chack.hidden = true
                    print("false")
                }
           // }

            return cell2

        }
        return UICollectionViewCell()
    }

    
    
//-------------------------------------------------------------------------------------複数のセルを選択する処理
//--------------------------------------------------------------------------------------選択したとき
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        if collectionView.tag == 2000{
            collectionView.allowsMultipleSelection = true
            var cell = collectionView.cellForItemAtIndexPath(indexPath)
           
//            if cell?.selected == true {
                    cell!.alpha = 0


                memberSelect[indexPath.row] = ad.memberName[indexPath.row]
               // memberSelect[ad.memberName[indexPath.row]] = indexPath.row//インデックスと名前を保持（テスト）
                for (key,val) in memberSelect{
                    print("memberName[\(key)] =  \(val)")
                    
                checkMark[indexPath.row] = true//辞書にcollectionViewのインデックス番号ととチェック判定用ブールを保持
                    print(checkMark[indexPath.row])
                print(checkMark.count)
                    
                }
                memberStack?.append(indexPath.row)
                print(memberStack?.count)
                UIImageView.animateWithDuration(0.5, animations: { () -> Void in
                    cell!.alpha = 0.7
                }) { (Bool) -> Void in
                   // cell?.reloadInputViews()
 
                }
                todayMember.reloadData()
//                serectMember.reloadData()
                cell?.selected = true
//                memberSelect[ad.memberName[indexPath.row]] = ad.memberBeans[indexPath.row]
 //               var hogeDic: Dictionary = ["name": "aaa", "num": "aa"]
 //               memberStack?.append(ad.memberBeans[indexPath.row])
//                var hogeDic: Dictionary = ["name":"\(ad.memberName[indexPath.row])", "num": "\(ad.memberBeans[indexPath.row])"]
  //              menberSelected.addObject(hogeDic)
 //               memberSelect?.addObject(ad.memberName[indexPath.row],ad.memberBeans[indexPath.row])
//                todayMember.reloadData()//todyaMemberリロード
 //               serectMember.reloadData()
  //              var test =  menberSelected[indexPath.row]
                
//            print("memberSelect?.count\(memberSelect.count)")
                
//                var testname = test["name"]
                
                
                print(genIndex)
  //              print("menberSelected?.count\(testname)")
 //           }
        }
    }
 
//---------------------------------------------------------------------------------------解除したとき
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        if collectionView.tag == 2000{
            collectionView.allowsMultipleSelection = true
            var cell = collectionView.cellForItemAtIndexPath(indexPath)
    
            if cell?.selected == false {
                
                memberSelect.removeValueForKey(indexPath.row)//メンバーセレクトを削除
                print(memberSelect.count)
                
                
                memberStack?.removeAtIndex((memberStack?.indexOf(indexPath.row))!)//memberStackの配列（要素：選択されたセル、Index:選択された順番)を取り除く
                    print(memberStack?.count)
                
                checkMark.removeValueForKey(indexPath.row)//チェックマークを削除
                print(checkMark.count)
                
                cell?.alpha = 0.5
                UIImageView.animateWithDuration(0.1, animations: { () -> Void in
                    cell!.alpha = 1.0
                })
            }
                cell?.reloadInputViews()
                todayMember.reloadData()
//               serectMember.reloadData()
            }

    }
    
    
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
    
 
    
    
    
    
    
    
    
    
    
    
    
    
    
 //-------------------------------------------------------------------------------------セーブ＆セグエ
    @IBAction func Saveaction(sender: UIBarButtonItem) {
        allSave()
    }
    
    func allSave(){
        if workName.text == nil{
            workName.text = ""
        }
        ad.calGenbaName[genIndex] = workName.text!
        ad.calStartTime[genIndex] = startTime.text!
        ad.calFinishTime[genIndex] = finishTime.text!
        
        var member:[String] = []
        for (key,value) in memberSelect{
 //           memmber.append(value)
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}