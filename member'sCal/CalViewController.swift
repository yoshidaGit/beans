//
//  CalViewController.swift
//  member'sCal
//
//  Created by 吉田＿悟志 on 2016/03/20.
//  Copyright © 2016年 yoshidajumokui.llc. All rights reserved.
//

import UIKit

class CalViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var calDisplay: UICollectionView!
    @IBOutlet weak var workDisplay: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//----------------------------------------------------------------------------------コレクションビューセルのサイズ
//        func collectionView(collectionView:UICollectionView,layout collectionViewLayout:UICollectionViewLayout,sizeForItemAtIndexPath indexPath:NSIndexPath) ->CGSize{
//            let size = calDisplay.frame.size.width / 7
//            return CGSize(width:size,height:60)
//            return CGSize(width:20,height:20)
        
//        }
}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        calDisplay.reloadData()
    }
    
//    override func viewDidLayoutSubviews() {
//        func collectionView(collectionView:UICollectionView,layout collectionViewLayout:UICollectionViewLayout,sizeForItemAtIndexPath indexPath:NSIndexPath) ->CGSize{
//            let size = self.view.frame.size.width / 7
//            return CGSize(width:size,height:size)
//        }
//    }
    
    
    
    
//---------------------------------------------------------------------------------コレクションビュー処理
    // セルが表示されるときに呼ばれる処理（1個のセルを描画する毎に呼び出されます
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:dayCell = collectionView.dequeueReusableCellWithReuseIdentifier("calCell1", forIndexPath: indexPath) as! dayCell
        //        cell.lblSample.text = "ラベル\(indexPath.row)";
        //        cell.selectBeans.image = UIImage(named: "1.png")
        return cell
    }
    
    // セクションの数（とりあえず）
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // 表示するセルの数（とりあえず）
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    
    
    
    
 
    
    
    
    
    
    
    
    
//-----------------------------------------------------------------------------------------テーブルビュー処理
    //行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //セルの内容
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "GenbaCell")
        return cell
    }
    
    //行を選択された時に呼ばれる
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
