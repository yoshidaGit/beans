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

    var GMVCGenbaName = ""
    var GMVCStartDay = ""
    var GMVCFinishDay = ""
    var GMVCStartTime = ""
    var GMVCFinishTime = ""
    var allDay = false
    var whichDay = false//ピッカーの判定、falseのとき開始日、trueのとき終了日
    let df = NSDateFormatter()
    let dft = NSDateFormatter()
    
    let check:[UIImage] = [
        UIImage(named:"non.png")!,
        UIImage(named:"chack.png")!]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allDay = false//初期化
        allDayButton.setImage(check[0], forState: .Normal)//初期化
        whichDay = false//初期化
        datePickerView.layer.cornerRadius = 5
        timeView.layer.cornerRadius = 5

        df.dateFormat = "yyyy/MM/dd"//日付のデータフォーマット
        dft.dateFormat = "HH:mm"//時間のデータフォーマット
        
    }
    
    override func viewWillAppear(animated:Bool){
        super.viewWillAppear(animated)
        
        //------------------------------------------------------現場フィールドをあらかじめ選択する
//        genbaName.delegate = self
        genbaName.becomeFirstResponder()
        genbaName.text = ""
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func GenbaName(sender: UITextField) {//現場名確定
        GMVCGenbaName = sender.text!
        if sender.text == nil{
            GMVCGenbaName = "新規現場"
        }
        genbaName.text = GMVCGenbaName
        
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
            startDay.alpha = 0.3
            UILabel.animateWithDuration(0.2, animations: { () -> Void in
                self.startDay.alpha = 1.0
            })
        }else{
            GMVCFinishDay = df.stringFromDate(sender.date)
            finishDay.text = GMVCFinishDay
            finishDay.alpha = 0.3
            UILabel.animateWithDuration(0.2, animations: { () -> Void in
               self.finishDay.alpha = 1.0
            })
        }
    }
    
    
    
    @IBAction func dayAndTimeSelect(sender: UISegmentedControl) {//開始日と終了日　選択ボタン
        switch timeSelect.selectedSegmentIndex{
        case 0:
            timeSelect.tintColor = UIColor.imageColor()
            datePickerView.backgroundColor = UIColor.imageColor()
            timeView.backgroundColor = UIColor.imageColor()
            
            whichDay = false
            
        case 1:
            timeSelect.tintColor = UIColor.brownColor()
            datePickerView.backgroundColor = UIColor.brownColor()
            timeView.backgroundColor = UIColor.brownColor()

            whichDay = true
            
            default:
            print("error")
        }
    }
    
    
    
    
    @IBAction func timePicker(sender: UIDatePicker) {//----------------------タイムピッカー
        if whichDay == false{//開始日
            GMVCStartTime = dft.stringFromDate(sender.date)
            startTime.text = GMVCStartTime
            startTime.alpha = 0.3
            UILabel.animateWithDuration(0.2, animations: { () -> Void in
                self.startTime.alpha = 1.0
            })
        }else{
            GMVCFinishTime = dft.stringFromDate(sender.date)
            finishTime.text = GMVCFinishTime
            finishTime.alpha = 0.3
            UILabel.animateWithDuration(0.2, animations: { () -> Void in
                self.finishTime.alpha = 1.0
            })
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
