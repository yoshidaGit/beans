//
//  MemberPlus.swift
//  member'sCal
//
//  Created by 吉田＿悟志 on 2016/03/18.
//  Copyright © 2016年 yoshidajumokui.llc. All rights reserved.
//





//課題　pickerView出現時にnameを押すとキャンセルされる・べつにいいけど、なぜ？





import UIKit

class MemberPlus: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    @IBOutlet weak var namePlus: UITextField!
    @IBOutlet weak var timeScrollInView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var startTime: UIButton!
    @IBOutlet weak var finishTime: UIButton!
    @IBOutlet weak var OK: UIButton!
    @IBOutlet weak var collectView: UICollectionView!
    @IBOutlet weak var StachWeek: UIStackView!
    @IBOutlet weak var mon: UIButton!
    @IBOutlet weak var tue: UIButton!
    @IBOutlet weak var wen: UIButton!
    @IBOutlet weak var thu: UIButton!
    @IBOutlet weak var fri: UIButton!
    @IBOutlet weak var sta: UIButton!
    @IBOutlet weak var sun: UIButton!
    

    var timeWhat:String = "開始"//-----------------------------------------------開始/終了＿時間判定変数
    var timeStart:String = "08:00"
    var timeFinish:String = "17:00"
    let df = NSDateFormatter()//------------------------------------------------ピッカー初期設定用変数
//     df.dateFormat = "HH:mm"
    var dateString = "08:00"//-------------------------------------------------------時間設定用変数
    var name = ""//-------------------------------------------------------------名前
    var beans = 0//-------------------------------------------------------------ビーンズ
    var weekSwitch = ""//-------------------------------------------------------曜日選択用変数
    var monDay = false
    var tueDay = false
    var wenDay = false
    var thuDay = false
    var friDay = false
    var staDay = false
    var sunDay = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTime.setTitle("\(timeStart)",forState: UIControlState.Normal)
        finishTime.setTitle("\(timeFinish)", forState: UIControlState.Normal)
        startTime.layer.cornerRadius = 3
        finishTime.layer.cornerRadius = 3
        OK.layer.cornerRadius = 3

         df.dateFormat = "HH:mm"//-----------------------------------------------日付のフォーマットを決定
        
//        StachWeek.layer.masksToBounds = true---------スタックビューの角を丸くしたいけど・・
//        StachWeek.layer.cornerRadius = 10
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

    
    
    
//------------------------------------------------------------------------------ピッカー関連の処理
//------------------------------------------------------------------------------ピッカーの動的処理
//------------------------------------------------------------------------------①
    func pickerDon(){
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.timeScrollInView.frame = CGRectMake(-(840 - self.view.frame.width),152,840,120)
        })
    }
//-------------------------------------------------------------------------------②
    func pickerOut(){
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.timeScrollInView.frame = CGRectMake(0,152,self.view.frame.width,120)
        })
    }

    @IBAction func chageDatePicker(sender: UIDatePicker) {//---------------------ピッカーアクション③
//        df.dateFormat = "HH:mm"
        dateString = df.stringFromDate(sender.date)
    }
    
//-------------------------------------------------------------------------------開始時間をタップ④
    @IBAction func startTap(sender: UIButton) {
        timeWhat = "開始"
//        datePicker.date = df.dateFromString("08:00")!----デフォルトの時間設定
        pickerDon()//①
        dateString = timeStart
        datePicker.date = df.dateFromString("\(timeStart)")!//ピッカーに時刻をセット
    }
//-------------------------------------------------------------------------------時間を設定して戻る⑤
    @IBAction func backTap(sender: UIButton) {
        timeswitch()//⑦
        pickerOut()//②
    }
//-------------------------------------------------------------------------------終了時間をタップ⑥
    @IBAction func finishiTap(sender: UIButton) {
        timeWhat = "終了"
        pickerDon()//①
        dateString = timeFinish
        datePicker.date = df.dateFromString("\(timeFinish)")!//ピッカーに時刻をセット
    }
//-------------------------------------------------------------------------------時刻を振り分けるfunc⑦
    func timeswitch(){
        if timeWhat == "開始"{
            timeStart = dateString
            startTime.setTitle("\(dateString)", forState: UIControlState.Normal)
            
        }else if timeWhat == "終了"{
            timeFinish = dateString
            finishTime.setTitle("\(dateString)", forState: UIControlState.Normal)
        }
    
    }

 
    
    
    
    
    
    
    
//-------------------------------------------------------------------------------名前の処理
    @IBAction func NamePlus(sender: UITextField) {
        var Name:String? = sender.text!
        if Name == nil{
            Name = ""
        }
        name = Name!
    }
    
    
    
 
    
    
//--------------------------------------------------------------------------------SAVE処理-----とりあえずAppDelegateへ
    func allSave(){
        let ad = UIApplication.sharedApplication().delegate as! AppDelegate
        ad.memberName.append(name)
        ad.memberStart.append(timeStart)
        ad.memberFinish.append(timeFinish)
    }
    

    
    
    
    
    
//---------------------------------------------------------------------------------collectionView処理
    // セルが表示されるときに呼ばれる処理（1個のセルを描画する毎に呼び出されます
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:custumCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell1", forIndexPath: indexPath) as! custumCell
        //        cell.lblSample.text = "ラベル\(indexPath.row)";
        cell.selectBeans.image = UIImage(named: "1.png")
        cell.backgroundColor = UIColor.blackColor()
        return cell
    }
    
    // セクションの数（今回は1つだけです）
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // 表示するセルの数
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20;
    }
    
    
    
    
    
    
    
//
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
        }
    }
 
//------------------------------------------------------------------------------------曜日ボタンアクション
    @IBAction func Mon(sender: UIButton) {
        let x = switchWeek(monDay)
        monDay = x
        switchColor(mon,hantei: monDay)
    }
    
    @IBAction func Tue(sender: UIButton) {
        let x = switchWeek(tueDay)
        tueDay = x
        switchColor(tue,hantei: tueDay)
    }
    
    @IBAction func Wen(sender: UIButton) {
        let x = switchWeek(wenDay)
        wenDay = x
        switchColor(wen,hantei:wenDay)
    }
    
    @IBAction func Thu(sender: UIButton) {
        let x = switchWeek(thuDay)
        thuDay = x
        switchColor(thu,hantei:thuDay)
    }
    
    @IBAction func Fri(sender: UIButton) {
        let x = switchWeek(friDay)
        friDay = x
        switchColor(fri,hantei:friDay)
    }
    
    @IBAction func Sta(sender: UIButton) {
        let x = switchWeek(staDay)
        staDay = x
        switchColor(sta,hantei:staDay)
    }
    
    @IBAction func Sun(sender: UIButton) {
        let x = switchWeek(sunDay)
        sunDay = x
        switchColor(sun,hantei:sunDay)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

