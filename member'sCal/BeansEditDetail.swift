//
//  BeansEditDetail.swift
//  member'sCal
//
//  Created by 吉田＿悟志 on 2016/04/19.
//  Copyright © 2016年 yoshidajumokui.llc. All rights reserved.
//

import UIKit

class BeansEditDetail: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    @IBOutlet weak var confirmBeans: UIImageView!
    @IBOutlet weak var beansName: UITextField!
    @IBOutlet weak var startTime: UIButton!
    @IBOutlet weak var finishTime: UIButton!
    
    @IBOutlet weak var mon: UIButton!
    @IBOutlet weak var tue: UIButton!
    @IBOutlet weak var wen: UIButton!
    @IBOutlet weak var thu: UIButton!
    @IBOutlet weak var fri: UIButton!
    @IBOutlet weak var sta: UIButton!
    @IBOutlet weak var sun: UIButton!

    @IBOutlet weak var beansCollectionView: UICollectionView!
    @IBOutlet weak var slideView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var OK: UIButton!
    
    let ad = UIApplication.sharedApplication().delegate as! AppDelegate
    var index = 0
    let df = NSDateFormatter()//------------------------------------------------ピッカー初期設定用変数
    var dateString = "08:00"//-------------------------------------------------------時間設定用変数
    var timeWhat:String = "開始"//-----------------------------------------------開始/終了＿時間判定変数
    
    let Beans:[UIImage] = [
        UIImage(named:"1.png")!,
        UIImage(named:"2.png")!,
        UIImage(named:"3.png")!
    ]
    
    var name = ""
    var start = ""
    var finish = ""
    var Rmon = false
    var Rtue = false
    var Rwen = false
    var Rthu = false
    var Rfri = false
    var Rsta = false
    var Rsun = false
    var beansNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //アップデリゲートのインデックスを参照
        index = ad.ADIndex
        name = ad.memberName[index]
        start = ad.memberStart[index]
        finish = ad.memberFinish[index]
        Rmon = ad.memberMon[index]
        Rtue = ad.memberTue[index]
        Rwen = ad.memberWen[index]
        Rthu = ad.memberThu[index]
        Rfri = ad.memberFri[index]
        Rsta = ad.memberSta[index]
        Rsun = ad.memberSun[index]
        beansNumber = ad.memberBeans[index]
        
        //インデックスデータを反映
        beansName.text = name
        startTime.setTitle(start,forState: UIControlState.Normal)
        finishTime.setTitle(finish, forState: UIControlState.Normal)
        confirmBeans.image = Beans[beansNumber]
        switchColor(mon, hantei: Rmon)
        switchColor(tue, hantei: Rtue)
        switchColor(wen, hantei: Rwen)
        switchColor(thu, hantei: Rthu)
        switchColor(fri, hantei: Rfri)
        switchColor(sta, hantei: Rsta)
        switchColor(sun, hantei: Rsun)
        
        
        startTime.layer.cornerRadius = 3
        finishTime.layer.cornerRadius = 3
        OK.layer.cornerRadius = 3
       // beansImage.alpha = 0
    
        df.dateFormat = "HH:mm"//-----------------------------------------------日付のフォーマットを決定
        
    }
    
    
    
    //------------------------------------------------------------------------------ピッカー関連の処理
    //------------------------------------------------------------------------------ピッカーの動的処理
    //------------------------------------------------------------------------------①
    func pickerDon(){
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.slideView.frame = CGRectMake(-(840 - self.view.frame.width),152,840,120)
        })
    }
    //-------------------------------------------------------------------------------②
    func pickerOut(){
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.slideView.frame = CGRectMake(0,152,self.view.frame.width,120)
        })
    }
    
    @IBAction func changeDatePicker(sender: UIDatePicker) {//ピッカーアクション③
         dateString = df.stringFromDate(sender.date)
    }

    
    @IBAction func startTap(sender: UIButton) {//開始時間をタップ④
        timeWhat = "開始"
        //        datePicker.date = df.dateFromString("08:00")!----デフォルトの時間設定
        pickerDon()//①
        dateString = start
        datePicker.date = df.dateFromString("\(start)")!//ピッカーに時刻をセット
    }
    
    @IBAction func backTap(sender: UIButton) {//時間を設定して戻る⑤
            timeswitch()//⑦
            pickerOut()//②
    }
    
    @IBAction func finishTap(sender: UIButton) {//終了時間をタップ⑥
        timeWhat = "終了"
        pickerDon()//①
        dateString = finish
        datePicker.date = df.dateFromString("\(finish)")!//ピッカーに時刻をセット
    }
    
    //-------------------------------------------------------------------------------時刻を振り分けるfunc⑦
    func timeswitch(){
        if timeWhat == "開始"{
            start = dateString
            startTime.setTitle("\(dateString)", forState: UIControlState.Normal)
            
        }else if timeWhat == "終了"{
            finish = dateString
            finishTime.setTitle("\(dateString)", forState: UIControlState.Normal)
        }
        
    }

    
    
    
    
    
    
    
    
    
    
    @IBAction func namePlus(sender: UITextField) {//名前の処理
        var Name:String? = sender.text!
        if Name == nil{
            Name = ""
        }
        name = Name!
    }
    
    
    
    
    
    
    
    
    
    
    //--------------------------------------------------------------------------------SAVE処理-----とりあえずAppDelegateへ
    func allSave(){
        //        let ad = UIApplication.sharedApplication().delegate as! AppDelegate
       
        ad.memberName[index] = name
        ad.memberStart[index] = start
        ad.memberFinish[index] = finish
        ad.memberBeans[index] = beansNumber
        ad.memberMon[index] = Rmon
        ad.memberTue[index] = Rtue
        ad.memberWen[index] = Rwen
        ad.memberThu[index] = Rthu
        ad.memberFri[index] = Rfri
        ad.memberSta[index] = Rsta
        ad.memberSun[index] = Rsun
    }

    

    
    
    
    
    
    
    
    
    
    
    
    
    //---------------------------------------------------------------------------------collectionView処理
    // セルが表示されるときに呼ばれる処理（1個のセルを描画する毎に呼び出されます
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell:beansCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell3", forIndexPath: indexPath) as! beansCell
            //        cell.lblSample.text = "ラベル\(indexPath.row)";
            collectionView.allowsMultipleSelection = false
            cell.layer.cornerRadius = 4
            cell.selectBeans.image = Beans[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    // セクションの数（今回は1つだけです）
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // 表示するセルの数
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Beans.count
    }
    
    //セルをタップしたとき
    func collectionView(collectionView:UICollectionView,didSelectItemAtIndexPath indexPath:NSIndexPath){
        beansNumber = indexPath.row
        self.confirmBeans.image = Beans[indexPath.row]// as UIImage
        confirmBeans.alpha = 0
        UIImageView.animateWithDuration(0.5, animations: { () -> Void in
            self.confirmBeans.alpha = 1.0
        })
        self.confirmBeans.frame = CGRectMake(41,106,0,0)
        UIImageView.animateWithDuration(0.2,
                                        delay:0,
                                        // バネの弾性力. 小さいほど弾性力は大きくなる.
            usingSpringWithDamping: 0.3,
            // 初速度.
            initialSpringVelocity: 5,
            options: [],
            animations: { () -> Void in
                self.confirmBeans.frame = CGRectMake(16,81,50,50)
        }) { (Bool) -> Void in
        }
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        cell!.alpha = 0.1
        UICollectionViewCell.animateWithDuration(0.8, animations: { () -> Void in
            cell!.alpha = 1.0
//            print(self.beans!)
        })
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //-----------------------------------------------------------------------------------曜日取得処理
    //-----------------------------------------------------------------------------------true/false判定関数
    func switchWeek(var week:Bool) ->Bool{
        if week == false{
            week = true
        }else {
            week = false
        }
        return week
    }
    //------------------------------------------------------------------------------------動的ボタン変色関数・
    func switchColor(weekOK:UIButton,hantei:Bool){
        if hantei == false{
            weekOK.backgroundColor = UIColor.darkGrayColor()
            weekOK.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        }else{
            weekOK.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            weekOK.backgroundColor = UIColor.brownColor()
            weekOK.alpha = 0.1
            UIButton.animateWithDuration(0.5, animations: { () -> Void in
                weekOK.alpha = 1.0
            })
        }
    }
    
    //------------------------------------------------------------------------------------曜日ボタンアクション
    
    @IBAction func monB(sender: UIButton) {
        Rmon = switchWeek(Rmon)
        switchColor(mon, hantei: Rmon)
    }
   
    @IBAction func tueB(sender: UIButton) {
        Rtue = switchWeek(Rtue)
        switchColor(tue, hantei: Rtue)
    }
    
    @IBAction func wenB(sender: UIButton) {
        Rwen = switchWeek(Rwen)
        switchColor(wen, hantei: Rwen)
    }
    @IBAction func thuB(sender: UIButton) {
        Rthu = switchWeek(Rthu)
        switchColor(thu, hantei: Rthu)
    }
    @IBAction func friB(sender: UIButton) {
        Rfri = switchWeek(Rfri)
        switchColor(fri, hantei: Rfri)
    }
    @IBAction func staB(sender: UIButton) {
        Rsta = switchWeek(Rsta)
        switchColor(sta, hantei: Rsta)
    }
    @IBAction func sunB(sender: UIButton) {
        Rsun = switchWeek(Rsun)
        switchColor(sun, hantei: Rsun)
    }

//    @IBAction func Mon(sender: UIButton) {
//        monDay = switchWeek(monDay)
//        switchColor(mon,hantei: monDay)
//    }
//    
//    @IBAction func Tue(sender: UIButton) {
//        tueDay = switchWeek(tueDay)
//        switchColor(tue,hantei: tueDay)
//    }
//    
//    @IBAction func Wen(sender: UIButton) {
//        wenDay = switchWeek(wenDay)
//        switchColor(wen,hantei:wenDay)
//    }
//    
//    @IBAction func Thu(sender: UIButton) {
//        thuDay = switchWeek(thuDay)
//        switchColor(thu,hantei:thuDay)
//    }
//    
//    @IBAction func Fri(sender: UIButton) {
//        friDay = switchWeek(friDay)
//        switchColor(fri,hantei:friDay)
//    }
//    
//    @IBAction func Sta(sender: UIButton) {
//        staDay = switchWeek(staDay)
//        switchColor(sta,hantei:staDay)
//    }
//    
//    @IBAction func Sun(sender: UIButton) {
//        sunDay = switchWeek(sunDay)
//        switchColor(sun,hantei:sunDay)
//    }
 
    
    
}
