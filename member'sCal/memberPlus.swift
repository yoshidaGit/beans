//
//  memberCenter.swift
//  member'sCal
//
//  Created by 吉田air on 2015/06/14.
//  Copyright (c) 2015年 yoshidajumokui.llc. All rights reserved.
//

import UIKit

class memberPlus: UIViewController {
    @IBOutlet weak var firstLabel: UILabel!//メンバーを作成/変更します
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var member: UITextField!
    @IBOutlet weak var allDay: UIImageView!
    @IBOutlet weak var memberStartTime: UILabel!
    @IBOutlet weak var memberFinishTime: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var finishLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
   
//デートピッカーの判定用
    var timeCase:Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//時刻を角丸にする
        memberStartTime.layer.cornerRadius = 4
        memberFinishTime.layer.cornerRadius = 4
        memberStartTime.clipsToBounds = true
        memberFinishTime.clipsToBounds = true
//ラベルを角丸にする
        startLabel.layer.cornerRadius = 4
        finishLabel.layer.cornerRadius = 4
        startLabel.clipsToBounds = true
        finishLabel.clipsToBounds = true
//ピッカーをグレイにする
        self.timePicker.backgroundColor = UIColor.grayColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//メンバー設定
    var Beens = ""
    var BeensStart = ""
    var BeensFinish = ""
    var BeensColor:Int = 0//ナンバーでビーンズを割り当てる
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
//テキストフィールド入力
    @IBAction func memberOK(sender: UITextField) {
        if sender.text != nil{
            Beens = sender.text
        }
    }
    
//キーボードを下げる
    func keyBoard(){
        self.view.endEditing(true)
    }

//８：００開始時刻をタップ
    @IBAction func startTime(sender: AnyObject) {

        //判定用変数
        timeCase = true
        UIDatePicker.animateWithDuration(0.2,animations: {() -> Void in
            self.timePicker.frame = CGRectMake(0,60, self.scrollView.frame.width,80)
        })
        self.startLabel.backgroundColor = UIColor.brownColor()
        self.startLabel.textColor = UIColor.whiteColor()
        keyBoard()
    }
    
//24：00終了時間をタップ
    @IBAction func finishTime(sender: AnyObject) {
        timeCase = false
        UIDatePicker.animateWithDuration(0.2,animations: {() -> Void in
            self.timePicker.frame = CGRectMake(0,80, self.scrollView.frame.width,80)
        })
        self.finishLabel.backgroundColor = UIColor.brownColor()
        self.finishLabel.textColor = UIColor.whiteColor()
        keyBoard()
        }


//all day 動的ボタン チェックを入れる
    @IBAction func allDayTap(sender: AnyObject) {
        
    }
 
//デイトピッカー
    @IBAction func workTime(sender: UIDatePicker) {
        let df = NSDateFormatter()
        df.dateFormat = "HH:mm"
        BeensStart = df.stringFromDate(sender.date)
        memberStartTime.text = BeensStart
//Viewを戻す
        UIDatePicker.animateWithDuration(0.2,animations: {() -> Void in
            self.timePicker.frame = CGRectMake(0,-150, self.scrollView.frame.width,80)
        })
//startLabelを戻す
        self.startLabel.backgroundColor = UIColor.clearColor()
        self.startLabel.textColor = UIColor.blackColor()
    }

}
