//
//  GenbaMakeViewController.swift
//  member'sCal
//
//  Created by 吉田＿悟志 on 2016/04/17.
//  Copyright © 2016年 yoshidajumokui.llc. All rights reserved.
//

import UIKit

class GenbaMakeViewController: UIViewController {
    @IBOutlet weak var genbaName: UITextField!
    @IBOutlet weak var calSelect: UIButton!
    @IBOutlet weak var allDayButton: UIButton!
    @IBOutlet weak var startDay: UILabel!
    @IBOutlet weak var finishDay: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var finishTime: UILabel!
    @IBOutlet weak var timeSelect: UISegmentedControl!
    @IBOutlet weak var dateSelectPicker: UIDatePicker!
    @IBOutlet weak var timeSelectPicker: UIDatePicker!
    @IBOutlet weak var timeView: UIView!
    
    @IBOutlet weak var datePickerView: UIView!
    
    let ad = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var GMVCGenbaName = ""
    var GMVCStartDay = ""
    var GMVCFinishDay = ""
    var GMVCStartTime = "08:00"//最終的には、オプションビューで編集出来るようにする
    var GMVCFinishTime = "17:00"
    var allDay = false
    var whichDay = false//ピッカーの判定、falseのとき開始日、trueのとき終了日
    let df = NSDateFormatter()
    let dft = NSDateFormatter()
    
    let check:[UIImage] = [
        UIImage(named:"non.png")!,
        UIImage(named:"chack.png")!]
    
    var today:NSDate = NSDate()
    var todayString:String = "08:00"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allDay = false//初期化
        allDayButton.setImage(check[0], forState: .Normal)//初期化
        whichDay = false//初期化
        startDay.clipsToBounds = true
        finishDay.clipsToBounds = true
        datePickerView.layer.cornerRadius = 5
        timeView.layer.cornerRadius = 5
        startDay.layer.cornerRadius = 5
        finishDay.layer.cornerRadius = 5

        df.dateFormat = "yyyy/MM/dd"//日付のデータフォーマット
        dft.dateFormat = "HH:mm"//時間のデータフォーマット
        
 //       var today:NSDate = NSDate()
        todayString = df.stringFromDate(today) as String
        print(todayString)
        
    }
    
    override func viewWillAppear(animated:Bool){
        super.viewWillAppear(animated)
        
        //------------------------------------------------------現場フィールドをあらかじめ選択する
//        genbaName.delegate = self
        genbaName.becomeFirstResponder()
        genbaName.text = ""
        //------------------------------------------------------カレンダーから取得した日にちをあらかじめ入れておく
       GMVCStartDay = todayString//とりあえず、本日の日付を入れておく（本当はカレンダーから）
        GMVCFinishDay = GMVCStartDay//nilが入るクラッシュ対策
        startDay.text = GMVCStartDay
        finishDay.text = GMVCStartDay
        dateSelectPicker.date = df.dateFromString(GMVCStartDay)!
        
        
    }
   
    
    
    //-----------------------------------------------------------開始日アニメーション
    func startFlash(){
        
            startDay.backgroundColor = UIColor.imageColor()
            startDay.textColor = UIColor.whiteColor()
            //startTime.backgroundColor = UIColor.imageColorAlpha()
            startDay.alpha = 0.1
            startTime.alpha = 0.1
            finishDay.backgroundColor = UIColor.clearColor()
            finishDay.textColor = UIColor.blackColor()
            //finishTime.backgroundColor = UIColor.clearColor()
            
            UITextField.animateWithDuration(0.8, animations: { () -> Void in
                self.startDay.alpha = 1.0
                self.startTime.alpha = 1.0
            })
        
    }
    func finishFrash(){//----------------------------------------終了日アニメーション
        startDay.backgroundColor = UIColor.clearColor()
        startDay.textColor = UIColor.blackColor()
        //startTime.backgroundColor = UIColor.clearColor()
        finishDay.backgroundColor = UIColor.brownColor()
        finishDay.textColor = UIColor.whiteColor()
        //finishTime.backgroundColor = UIColor.brownColor()
        finishDay.alpha = 0.1
        finishTime.alpha = 0.1
        UITextField.animateWithDuration(0.8, animations: { () -> Void in
            self.finishDay.alpha = 1.0
            self.finishTime.alpha = 1.0
        })
        
    }
    
    
    
    
    
    
    
    
    
    
    @IBAction func GenbaName(sender: UITextField) {//現場名確定
        
        if sender.text == nil{
            genbaName.text = "新規現場"
        }else if sender.text == ""{
            genbaName.text = "新規現場"
        }
        GMVCGenbaName = genbaName.text!
        //アニメーション
        if whichDay == false{
            startFlash()
            caseZero()
        }else{
            finishFrash()
            caseOne()
        }
        
    }
    
    
    @IBAction func allDayJudge(sender: UIButton) {//-------------------オールデイボタンで終日判定
        if allDay == false{
            allDay = true
            allDayButton.setImage(check[1], forState: .Normal)
            startTime.enabled = false
            finishTime.enabled = false
            timeSelectPicker.hidden = true
        }else{
            allDay = false
            allDayButton.setImage(check[0], forState: .Normal)
            startTime.enabled = true
            finishTime.enabled = true
            timeSelectPicker.hidden = false
        }
    }
    
    
    
    @IBAction func datePicker(sender: UIDatePicker) {//---------------------------デートピッカー
        if whichDay == false{//開始日
            GMVCStartDay = df.stringFromDate(sender.date)
            startDay.text = GMVCStartDay
            startFlash()
        }else{
            GMVCFinishDay = df.stringFromDate(sender.date)
            finishDay.text = GMVCFinishDay
            finishFrash()
        }
        let dayFunction = DayAndTimeCompare()
        let DayFunction = dayFunction.dayCompare(GMVCStartDay, finish: GMVCFinishDay)
        
        if finishDay.text != DayFunction{//最大の日にちを取得し、もし開始日が終了日より未来だったら訂正する。さらにピッカーも修正する
        finishDay.text = DayFunction
        GMVCFinishDay = DayFunction
        dateSelectPicker.date = df.dateFromString(GMVCFinishDay)!//ピッカーと日時を合わせる
        }
        finishDay.text = DayFunction
        GMVCFinishDay = DayFunction
    }
    
    
 
    
    
    //-----------------------------------------------------------------------------------開始と終了を切り替える一連のファンクション
    @IBAction func dayAndTimeSelect(sender: UISegmentedControl) {//開始日と終了日　選択ボタン
        switch timeSelect.selectedSegmentIndex{
        case 0:
            startFlash()
            caseZero()
            
        case 1:
            finishFrash()
            caseOne()
            
        default:
            print("error")
        }
    }
    func caseZero(){
        timeSelect.tintColor = UIColor.imageColor()
        datePickerView.backgroundColor = UIColor.imageColor()
        timeView.backgroundColor = UIColor.imageColor()
        
        whichDay = false
            dateSelectPicker.date = df.dateFromString(GMVCStartDay)!//ピッカーに開始日を入力
            timeSelectPicker.date = dft.dateFromString(GMVCStartTime)!//ピッカーに開始時間を入力
    }
    func caseOne(){
        timeSelect.tintColor = UIColor.brownColor()
        datePickerView.backgroundColor = UIColor.brownColor()
        timeView.backgroundColor = UIColor.brownColor()
        
        whichDay = true
        dateSelectPicker.date = df.dateFromString(GMVCFinishDay)!//ピッカーに終了日を入力
        timeSelectPicker.date = dft.dateFromString(GMVCFinishTime)!
    }
 //-----------------------------------------------------------------------------------------ここまで
    
    
    
    
    @IBAction func timePicker(sender: UIDatePicker) {//----------------------タイムピッカー
        if whichDay == false{//開始日
            GMVCStartTime = dft.stringFromDate(sender.date)
            startTime.text = GMVCStartTime
            startFlash()
        }else{
            GMVCFinishTime = dft.stringFromDate(sender.date)
            finishTime.text = GMVCFinishTime
            finishFrash()
        }
        let timeFunction = DayAndTimeCompare()
        let TimeFunction = timeFunction.dayCompare(GMVCStartTime, finish: GMVCFinishTime)
        
        if finishTime.text != TimeFunction{//最大の日にちを取得し、もし開始日が終了日より未来だったら訂正する。さらにピッカーも修正する
            finishTime.text = TimeFunction
            GMVCFinishTime = TimeFunction
            timeSelectPicker.date = dft.dateFromString(GMVCFinishTime)!//ピッカーと日時を合わせる
        }
        finishTime.text = TimeFunction
        GMVCFinishTime = TimeFunction
        
    }
 
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func startTap(sender: UITapGestureRecognizer) {//開始日をタップ
        timeSelect.selectedSegmentIndex = 0
        startFlash()
        caseZero()
    }
    @IBAction func finishTap(sender: UITapGestureRecognizer) {//終了日をタップ
       timeSelect.selectedSegmentIndex = 1
        finishFrash()
        caseOne()
    }
    
    @IBAction func startTimeTap(sender: UITapGestureRecognizer) {//開始時間をタップ
        timeSelect.selectedSegmentIndex = 0
        startFlash()
        caseZero()
    }
    
    @IBAction func finishTimeTap(sender: UITapGestureRecognizer) {//終了時間をタップ
        timeSelect.selectedSegmentIndex = 1
        finishFrash()
        caseOne()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func saveAndReturn(sender: UIBarButtonItem) {//saveボタンを押したとき
        allSave()
        
        self.performSegueWithIdentifier("GenbaMakeOK", sender: nil)
    }
    
    
    func allSave(){//-----------------------------------NSDate型で日付を返す
        if allDay == true{//オールデイをチェック
            GMVCStartTime = "00:00"
            GMVCFinishTime = "24:00"
        }
        let NSStartDay = df.dateFromString(GMVCStartDay)//NSDate型に変換
        let NSFinishDay = df.dateFromString(GMVCFinishDay)
        
        let cal = NSCalendar(calendarIdentifier:NSCalendarIdentifierGregorian)
        let componentsByDay = cal!.components([.Day], fromDate: NSStartDay!, toDate: NSFinishDay!, options: NSCalendarOptions())//開始日と終了日の差分を得る
        let x = componentsByDay.day//差分の日にち（Int)
        
        //差分ぶんの日を取得、var NSdaysにアペンド
        var NSdays:[NSDate] = []
        var days:[String] = []//試しにStringでも出力
        for i in 0...x{
            var datePlus = NSDate(timeInterval: Double(i)*24*60*60,sinceDate:NSStartDay!)
            NSdays.append(datePlus)
            
            var stringPlus = df.stringFromDate(datePlus)
            days.append(stringPlus)
        }
        
        //アップデリゲートに保存、差分ぶんの日にちがアペンドされる
        for plus:Int in 0...x{
            ad.calDay.append(days[plus])
            //ad.NDCalDay.append(NSDays[plus])//--------NSDate型、まだ未設定
            ad.calGenbaName.append(GMVCGenbaName)
            ad.calStartTime.append(GMVCStartTime)
            ad.calFinishTime.append(GMVCFinishTime)
        }
        
        
    }
 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
