//
//  MemberPlus2.swift
//  member'sCal
//
//  Created by 吉田＿悟志 on 2016/04/02.
//  Copyright © 2016年 yoshidajumokui.llc. All rights reserved.
//

import UIKit

class MemberPlus2: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    @IBOutlet weak var memberPlusTitle: UILabel!
    @IBOutlet weak var startTime: UIButton!
    @IBOutlet weak var finishTime: UIButton!
    @IBOutlet weak var OK: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
   
    @IBOutlet weak var namePlus: UITextField!
    @IBOutlet weak var timeScrollInView: UIView!
    @IBOutlet weak var mon: UIButton!
    @IBOutlet weak var tue: UIButton!
    @IBOutlet weak var wen: UIButton!
    @IBOutlet weak var thu: UIButton!
    @IBOutlet weak var fri: UIButton!
    @IBOutlet weak var sta: UIButton!
    @IBOutlet weak var sun: UIButton!
    
    @IBOutlet weak var beansImage: UIImageView!
    @IBOutlet weak var collectView: UICollectionView!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var trushButton: UIBarButtonItem!
    
    let ad = UIApplication.sharedApplication().delegate as! AppDelegate
    
    let Beans:[UIImage] = [
        UIImage(named:"1.png")!,
        UIImage(named:"2.png")!,
        UIImage(named:"3.png")!
    ]
    
    
    var timeWhat:String = "開始"//-----------------------------------------------開始/終了＿時間判定変数
    var timeStart:String = "08:00"
    var timeFinish:String = "17:00"
    let df = NSDateFormatter()//------------------------------------------------ピッカー初期設定用変数
    //     df.dateFormat = "HH:mm"
    var dateString = "08:00"//-------------------------------------------------------時間設定用変数
    var name = ""//-------------------------------------------------------------名前
    var beans:Int?//-------------------------------------------------------------ビーンズ
    //    var weekSwitch = ""//-------------------------------------------------------曜日選択用変数
    var monDay = false
    var tueDay = false
    var wenDay = false
    var thuDay = false
    var friDay = false
    var staDay = false
    var sunDay = false
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        startTime.setTitle("\(timeStart)",forState: UIControlState.Normal)
        finishTime.setTitle("\(timeFinish)", forState: UIControlState.Normal)
        startTime.layer.cornerRadius = 3
        finishTime.layer.cornerRadius = 3
        OK.layer.cornerRadius = 3
        
        df.dateFormat = "HH:mm"//-----------------------------------------------日付のフォーマットを決定
        
        //キャンセルボタン,ゴミ箱ボタン
        if ad.memberName.count == 0{
            cancelButton.enabled = false
            trushButton.enabled = false
        }
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

    @IBAction func changeDatePicker(sender: UIDatePicker) {
        dateString = df.stringFromDate(sender.date)
    }
    
    
    @IBAction func startTap(sender: UIButton) {
        timeWhat = "開始"
        //        datePicker.date = df.dateFromString("08:00")!----デフォルトの時間設定
        pickerDon()//①
        dateString = timeStart
        datePicker.date = df.dateFromString("\(timeStart)")!//ピッカーに時刻をセット
    }
    
    @IBAction func backTap(sender: UIButton) {
        timeswitch()//⑦
        pickerOut()//②
    }
    
    
    @IBAction func finishTap(sender: UIButton) {
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
    
    
    
//------------------------------------------------名前の処理
    @IBAction func NamePlus(sender: UITextField) {
        var Name:String? = sender.text!
        if Name == nil{
            Name = ""
        }
        name = Name!

    }
    
    

    
    //--------------------------------------------------------------------------------SAVE処理-----とりあえずAppDelegateへ
    func allSave(){
//        let ad = UIApplication.sharedApplication().delegate as! AppDelegate
        if beans == nil{
            beans = 0
        }
        ad.memberName.append(name)
        ad.memberStart.append(timeStart)
        ad.memberFinish.append(timeFinish)
        ad.memberBeans.append((beans)!)
        ad.memberMon.append(monDay)
        ad.memberTue.append(tueDay)
        ad.memberWen.append(wenDay)
        ad.memberThu.append(thuDay)
        ad.memberFri.append(friDay)
        ad.memberSta.append(staDay)
        ad.memberSun.append(sunDay)
    }
    
    //アラート・アクションシート
    func alert(){
        let alertController = UIAlertController(
            title:"Beansを保存します",
            message:"",
            preferredStyle:UIAlertControllerStyle.ActionSheet)
        
        alertController.addAction(UIAlertAction(
            title:"OK! カレンダーへGo！",//-------------------------------①へ
            style: .Default,
            handler: {action in self.okGo()}))
        //ライブラリボタンを追加
        alertController.addAction(UIAlertAction(
            title:"OK! 更にBeansを追加！",//------------------------------②へ
            style: .Default,
            handler: {action in self.okPlus()}))
        //キャンセル
        alertController.addAction(UIAlertAction(
            title:"キャンセル",
            style: .Cancel,
            handler:nil))
        //アラート表示
        presentViewController(alertController,animated:true,completion:nil)
    }
    
    func okGo(){//-----------------------------------------------------①
        allSave()
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.view.frame = CGRectMake(0,-(self.view.frame.height),self.view.frame.width,self.view.frame.height)
        })
        self.performSegueWithIdentifier("calGo2", sender: nil)
    }
    
    func okPlus(){
        allSave()
        //--------------------------------------------メンバープラス2のviewControllerを追加
        
        //      let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //       let Plus = storyboard.instantiateViewControllerWithIdentifier("ViewGoust") as! MemberPlus2
//        let Plus = self.storyboard!.instantiateViewControllerWithIdentifier("ViewGoust") as! MemberPlus2
//        
//        
//        self.addChildViewController(Plus)
//        //        self.didMoveToParentViewController(Plus)
//        let goustView = Plus.view
//        self.view.superview!.insertSubview(goustView, atIndex: 0)//atIndexはレイヤーの順番
//        goustView.frame = CGRectMake(0,0,self.view.frame.width,self.view.frame.height)
//        //        self.view.superview?.insertSubview(goustView, atIndex: 0)//atIndexはレイヤーの順番
//        Plus.didMoveToParentViewController(self)
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.view.frame = CGRectMake(0,-(self.view.frame.height / 2),self.view.frame.width,self.view.frame.height)
        })
        self.performSegueWithIdentifier("backRemake", sender: nil)
    }
    
    @IBAction func saveAlert(sender: UIBarButtonItem) {
        alert()
    }
    
    //キャンセルボタン
    @IBAction func cancellButton(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("calCancell2", sender: nil)

    }
  
    
    
    
    
    
    
    
    
    //---------------------------------------------------------------------------------collectionView処理
    // セルが表示されるときに呼ばれる処理（1個のセルを描画する毎に呼び出されます
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell:beansCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell1", forIndexPath: indexPath) as! beansCell
       
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
        beans = indexPath.row
        print(beans)
        self.beansImage.image = Beans[indexPath.row]// as UIImage
        beansImage.alpha = 0
        UIImageView.animateWithDuration(0.5, animations: { () -> Void in
            self.beansImage.alpha = 1.0
        })
        self.beansImage.frame = CGRectMake(41,106,0,0)
        //        self.beansImage.alpha = 1.0
        UIImageView.animateWithDuration(0.2,
                                        delay:0,
                                        // バネの弾性力. 小さいほど弾性力は大きくなる.
            usingSpringWithDamping: 0.3,
            // 初速度.
            initialSpringVelocity: 5,
            options: [],
            animations: { () -> Void in
                self.beansImage.frame = CGRectMake(16,81,50,50)
        }) { (Bool) -> Void in
        }
        var cell = collectionView.cellForItemAtIndexPath(indexPath)
        cell!.alpha = 0.1
        UICollectionViewCell.animateWithDuration(0.8, animations: { () -> Void in
            cell!.alpha = 1.0
            print(self.beans!)
        })
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
            weekOK.alpha = 0.1
            UIButton.animateWithDuration(0.5, animations: { () -> Void in
                weekOK.alpha = 1.0
            })
            
        }
    }
    
    
    
    
    
    
    
    
    
    //------------------------------------------------------------------------------------曜日ボタンアクション
   
    @IBAction func Mon(sender: UIButton) {
        monDay = switchWeek(monDay)
        switchColor(mon,hantei: monDay)
    }
    
    
    @IBAction func Tue(sender: UIButton) {
        tueDay = switchWeek(tueDay)
        switchColor(tue,hantei: tueDay)
    }
    
    
    @IBAction func Wen(sender: UIButton) {
        wenDay = switchWeek(wenDay)
        switchColor(wen,hantei:wenDay)
    }
    
    
    @IBAction func Thu(sender: UIButton) {
        thuDay = switchWeek(thuDay)
        switchColor(thu,hantei:thuDay)
    }
    
    
    @IBAction func Fri(sender: UIButton) {
        friDay = switchWeek(friDay)
        switchColor(fri,hantei:friDay)

    }
    
    
    @IBAction func Sta(sender: UIButton) {
        staDay = switchWeek(staDay)
        switchColor(sta,hantei:staDay)
    }
    
    
    
    @IBAction func Sun(sender: UIButton) {
        sunDay = switchWeek(sunDay)
        switchColor(sun,hantei:sunDay)
    }
    
    
    
    
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
