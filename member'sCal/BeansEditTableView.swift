//
//  BeansEditTableView.swift
//  member'sCal
//
//  Created by 吉田＿悟志 on 2016/04/18.
//  Copyright © 2016年 yoshidajumokui.llc. All rights reserved.
//

import UIKit

class BeansEditTableView: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var beansTableView: UITableView!
    
    let ad = UIApplication.sharedApplication().delegate as! AppDelegate
//    var editIndex = 0
    
    let Beans:[UIImage] = [
        UIImage(named:"1.png")!,
        UIImage(named:"2.png")!,
        UIImage(named:"3.png")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    //セルの行数
    func tableView(tableView:UITableView,numberOfRowsInSection section:Int) -> Int{
        return ad.memberName.count
    }
    //セクションの数
    func numberOfSectionsInTableView(tableView:UITableView) -> Int{
        return 1
    }
    
    
    //セルの内容
    func tableView(tablrView:UITableView,cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell{
        if indexPath.section == 0{
        let cell = beansTableView.dequeueReusableCellWithIdentifier("beansEditCell") as! BeansTableViewCell
        cell.beansImage.image = Beans[ad.memberBeans[indexPath.row]]
        cell.beansName.text = ad.memberName[indexPath.row]
            cell.startTime.text = ad.memberStart[indexPath.row]
            cell.finishTime.text = ad.memberFinish[indexPath.row]
            
            
            
            let mon = ad.memberMon[indexPath.row]
//            weekChange(mon, weekName:cell.mon)
            if mon == true{
                cell.mon.backgroundColor = UIColor.brownColor()
                cell.mon.textColor = UIColor.whiteColor()
            }else{
                cell.mon.backgroundColor = UIColor.lightGrayColor()
                cell.mon.textColor = UIColor.grayColor()
            }
            let tue = ad.memberTue[indexPath.row]
            if tue == true{
                cell.tue.backgroundColor = UIColor.brownColor()
                cell.tue.textColor = UIColor.whiteColor()
            }else{
                cell.tue.backgroundColor = UIColor.lightGrayColor()
                cell.tue.textColor = UIColor.grayColor()
            }
            let wen = ad.memberWen[indexPath.row]
            if wen == true{
                cell.wen.backgroundColor = UIColor.brownColor()
                cell.wen.textColor = UIColor.whiteColor()
            }else{
                cell.wen.backgroundColor = UIColor.lightGrayColor()
                cell.wen.textColor = UIColor.grayColor()
            }
            let thu = ad.memberThu[indexPath.row]
            if thu == true{
                cell.thr.backgroundColor = UIColor.brownColor()
                cell.thr.textColor = UIColor.whiteColor()
            }else{
                cell.thr.backgroundColor = UIColor.lightGrayColor()
                cell.thr.textColor = UIColor.grayColor()
            }
            let fri = ad.memberFri[indexPath.row]
            if fri == true{
                cell.fri.backgroundColor = UIColor.brownColor()
                cell.fri.textColor = UIColor.whiteColor()
            }else{
                cell.fri.backgroundColor = UIColor.lightGrayColor()
                cell.fri.textColor = UIColor.grayColor()
            }
            let sta = ad.memberSta[indexPath.row]
            if sta == true{
                cell.stu.backgroundColor = UIColor.brownColor()
                cell.stu.textColor = UIColor.whiteColor()
            }else{
                cell.stu.backgroundColor = UIColor.lightGrayColor()
                cell.stu.textColor = UIColor.grayColor()
            }
            let sun = ad.memberSun[indexPath.row]
            if sun == true{
                cell.sun.backgroundColor = UIColor.brownColor()
                cell.sun.textColor = UIColor.whiteColor()
            }else{
                cell.sun.backgroundColor = UIColor.lightGrayColor()
                cell.sun.textColor = UIColor.grayColor()
            }
            
            
            
//            func weekChange(week:Bool,weekName:UILabel ){
//                if week == true{
//                    cell.weekName.backgroundColor = UIColor.brownColor()
//                }else{
//                    cell.mon.backgroundColor = UIColor.darkGrayColor()
//                }
//            }
            
            return cell
        }
        return UITableViewCell()
    }
    

    
    
    
    
    
    
    
    //セルを選択したとき
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        ad.ADIndex = indexPath.row
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    
    
    
    
    @IBAction func returnBeansCancel(segue:UIStoryboardSegue){//genbaBiewからキャンセルしてきたとき
        //        let GVC = segue.sourceViewController as! GenbaViewController
        //        calIndex = GVC.genIndex
    }
    
    @IBAction func saveAndBack(segue:UIStoryboardSegue){//セーブして戻ってくるとき
       let BED = segue.sourceViewController as! BeansEditDetail
        BED.allSave()
        beansTableView.reloadData()
    }
    
    
    
    
    
    
    
    
    
    
    
    
}