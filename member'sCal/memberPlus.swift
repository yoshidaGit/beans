
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
  
    @IBOutlet weak var memberPlusTitle: UILabel!
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
    @IBOutlet weak var beansImage: UIImageView!
    @IBOutlet weak var NoBeansIsCancel: UIBarButtonItem!

    
    let Beans:[UIImage] = [
        UIImage(named:"1.png")!,
        UIImage(named:"2.png")!,
        UIImage(named:"3.png")!,
        UIImage(named:"beans1")!,
        UIImage(named:"4")!,
        UIImage(named:"5")!,
        ]
    
    let ad = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var timeWhat:String = "開始"//-----------------------------------------------開始/終了＿時間判定変数
    var timeStart:String = "08:00"
    var timeFinish:String = "17:00"
    let df = NSDateFormatter()//------------------------------------------------ピッカー初期設定用変数
//     df.dateFormat = "HH:mm"
    var dateString = "08:00"//-------------------------------------------------------時間設定用変数)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let ad = UIApplication.sharedApplication().delegate as! AppDelegate
        startTime.setTitle("\(timeStart)",forState: UIControlState.Normal)
        finishTime.setTitle("\(timeFinish)", forState: UIControlState.Normal)
        startTime.layer.cornerRadius = 3
        finishTime.layer.cornerRadius = 3
        OK.layer.cornerRadius = 3
        beansImage.alpha = 0
        
        //ビーンズがゼロの時
        if ad.memberName.count == 0{
            NoBeansIsCancel.enabled = false
 
        }

         df.dateFormat = "HH:mm"//-----------------------------------------------日付のフォーマットを決定
        
//        StachWeek.layer.masksToBounds = true---------スタックビューの角を丸くしたいけど・・
//        StachWeek.layer.cornerRadius = 10
//        StachWeek.backgroundColor = UIColor.blueColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated:Bool){
        super.viewWillAppear(animated)
        
        //------------------------------------------------------nameフィールドをあらかじめ選択する
        //デリゲートは？
        namePlus.becomeFirstResponder()
        namePlus.text = ""
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
        //--------------------------終了日を開始日より遅くする
        
        let dayFunction = DayAndTimeCompare()
        let DayFunction = dayFunction.dayCompare(timeStart, finish: timeFinish)
        finishTime.setTitle("\(DayFunction)",forState: UIControlState.Normal)
        timeFinish = DayFunction
        finishTime.alpha = 0.1
        
        UIButton.animateWithDuration(0.1,
                                   delay: 0.5,
                                   options: UIViewAnimationOptions.CurveEaseOut,
                                   animations: { () in
                                    self.finishTime.alpha = 1.0
            }, completion: { (Bool) in
                
        })

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
            
            if timeFinish == "00:00"{//午前0時対策
                timeFinish = "24:00"
                dateString = "24:00"
            }
            finishTime.setTitle("\(dateString)", forState: UIControlState.Normal)
        }
    
    }

 
    
    
    
    
    
    
    
//-------------------------------------------------------------------------------名前の処理
    @IBAction func NamePlus(sender: UITextField) {
        var Name:String? = sender.text!
        if Name == nil{
            Name = "new Beans"
        }else if Name == ""{
            Name = "new Beans"
        }
        name = Name!
        namePlus.text = name
    }
    
    
    
 
    
    
    
    
    
    
 //--------------------------------------------------------------------------------
//--------------------------------------------------------------------------------SAVE処理-----とりあえずAppDelegateへ
    func allSave(){
//        let ad = UIApplication.sharedApplication().delegate as! AppDelegate
        if beans == nil{
            beans = 0
        }
        if name == ""{
            name = "new Beans"
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
    
//    //アラート・アクションシート
//    func alert(){
//        let alertController = UIAlertController(
//                title:"Beansを保存します",
//                message:"",
//            preferredStyle:UIAlertControllerStyle.ActionSheet)
//        
//        alertController.addAction(UIAlertAction(
//            title:"OK! カレンダーへGo！",//-------------------------------①へ
//            style: .Default,
//            handler: {action in self.okGo()}))
//        //ライブラリボタンを追加
//        alertController.addAction(UIAlertAction(
//            title:"OK! 更にBeansを追加！",//------------------------------②へ
//            style: .Default,
//            handler: {action in self.okPlus()}))
//        //キャンセル
//        alertController.addAction(UIAlertAction(
//            title:"キャンセル",
//            style: .Cancel,
//            handler:nil))
//        //アラート表示
//        presentViewController(alertController,animated:true,completion:nil)
//    }
//    
//   
//    func okGo(){//-----------------------------------------------------①
//        allSave()
//        UIView.animateWithDuration(0.2, animations: { () -> Void in
//            self.view.frame = CGRectMake(0,-(self.view.frame.height),self.view.frame.width,self.view.frame.height)
//        })
//        self.performSegueWithIdentifier("calGo", sender: nil)
//    }
//    
//    //アラートOK＆ビーンズ追加
//    func okPlus(){
//        allSave()
//        UIView.animateWithDuration(0.2, animations: { () -> Void in
//            self.view.frame = CGRectMake(0,-(self.view.frame.height),self.view.frame.width,self.view.frame.height)
//            
//        })
//        self.performSegueWithIdentifier("makeBeans", sender: nil)
//    }
    
    //Saveボタンを押したとき
    @IBAction func saveAlert(sender: UIBarButtonItem) {
        allSave()
        self.performSegueWithIdentifier("backBeansTable", sender: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
//---------------------------------------------------------------------------------collectionView処理
    // セルが表示されるときに呼ばれる処理（1個のセルを描画する毎に呼び出されます
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell:beansCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell1", forIndexPath: indexPath) as! beansCell
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
        beans = indexPath.row
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
    

        
        
        

    
    //セルを解除したときに呼ばれる
//    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
//        
//    }
//    
    
    
    
    
    
    
    
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
    
    
    
    
    
    
    
    
 //セグエ戻り口
    @IBAction func BeansEditCancell(segue:UIStoryboardSegue){
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

