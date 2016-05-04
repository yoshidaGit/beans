//
//  CalViewController.swift
//  member'sCal
//
//  Created by 吉田＿悟志 on 2016/03/20.
//  Copyright © 2016年 yoshidajumokui.llc. All rights reserved.
//

import UIKit

class CalViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate {
    @IBOutlet weak var workDisplay: UITableView!
    
    // MARK: - Properties
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var weekMonth: UIButton!
    //    @IBOutlet weak var daysOutSwitch: UISwitch!
    @IBOutlet weak var beansColection: UICollectionView!

    @IBOutlet weak var beansInTable: UICollectionView!
  
    @IBOutlet weak var plusButton: UIImageView!
   
    @IBOutlet weak var addBeans: UIButton!

    @IBOutlet weak var beansCollectionHeight: NSLayoutConstraint!
    @IBOutlet weak var addBeansTop: NSLayoutConstraint!
    
    @IBOutlet weak var pushButtonScale: UIView!
    
    var shouldShowDaysOut = true
    var animationFinished = true
    
// --------------------------------------------タッチした日付取得
    var selectedDay:DayView!
    var selectDayString:String = ""
    var selectDayDate:NSDate = NSDate()
//---------------------------------------------
    
    var BeansImage:UIImageView = UIImageView()//コレクションビューをタッチしたときに呼ばれるビュー

    
    var WMtitle = "Add Beans"//----------------week/month切替変数 デフォルトがWeek
    
    var calIndex = 0//インデックス保持用
    
    
 //--------------------------------------------------------------------------appDelegateのレコードを取得する変数
    var genbaName = []
    var startTime = []
    var finishTime = []
    var day = []
    var beans = []
    var beansStartTime = []
    var beansFinishTime = []
 //---------------------------------------------------------------------------」
    let Beans:[UIImage] = [
        UIImage(named:"1.png")!,
        UIImage(named:"2.png")!,
        UIImage(named:"3.png")!,
        UIImage(named:"beans1")!,
        UIImage(named:"4")!,
        UIImage(named:"5")!,
    ]
 //------------------------------------------------------------------------------
    var tablefield:[[Int]] = [[2,1,2],[0,0],[1,2,0],[0],[],[1],[],[2,1,0]]//試しのサンプルよう
 //------------------------------------------------------------------------------------------------日付フォーマット
    var df = NSDateFormatter()
    var dfd = NSDateFormatter()

    
    let ad = UIApplication.sharedApplication().delegate as! AppDelegate
    
    // MARK: - Life cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.menuView.firstWeekday = .Sunday
        //TODO: 画面サイズが小さい時はフォントサイズを小さくする必要があるので画面サイズ判定での調整を追加する必要がある
        //monthLabel.font = UIFont.systemFontOfSize(CGFloat(19))
        monthLabel.font = UIFont.boldSystemFontOfSize(CGFloat(25))
        monthLabel.text = CVDate(date: NSDate()).globalDescription
        
        weekMonth.layer.cornerRadius = 3
        plusButton.layer.shadowOpacity = 0.4//プラスボタンに陰を付ける
        plusButton.layer.shadowOffset = CGSizeMake(0,2)
        
        //TODO: 今月以外の日にちをタップしてその月にスクロールしても、タップした日にちが選択されないので非表示にしておく。不具合解消したらON
        calendarView.changeDaysOutShowingState(true)
        shouldShowDaysOut = false
        
        df.dateFormat = "yyyy/MM/dd"
        dfd.dateFormat = "dd MM,yyyy"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {//----------------------ここでデリゲートの変数を代入、テーブルビューを更新
        genbaName = ad.calGenbaName
        startTime = ad.calStartTime
        finishTime = ad.calFinishTime
        day = ad.calDay
        if WMtitle == "Add Beans"{
            beansColection.userInteractionEnabled = true
        }else if WMtitle == "Month Cal"{
            beansColection.userInteractionEnabled = false
        }
        
 //       workDisplay.reloadData()
 //       beansColection.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
       // workDisplay.reloadData()
        BeansImage.image = Beans[0]//タッチで変換が出来るまでとりあえず

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        calendarView.commitCalendarViewUpdate()
        menuView.commitMenuViewUpdate()
        beansColection.layer.cornerRadius = 5
        self.workDisplay.reloadData()
        beansColection.reloadData()
    }
    

 
    
    
    
    
    
    
    
    
    
    
    
    
    
//-----------------------------------------------------------------------------------------------------------------テーブルビュー処理
    //行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genbaName.count
    }
    
    //セルの内容
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .Default, reuseIdentifier: "genbaCell")
        if indexPath.section == 0{
            
            
//            var daySelect = ad.calDay.indexOf(dayView.da
//            if daySelect?.isEmpty == false{
            
            
            
        let cell = tableView.dequeueReusableCellWithIdentifier("genbaCell") as! WorkTableViewCell

            
        cell.start.text = startTime[indexPath.row] as? String
        cell.finish.text = finishTime[indexPath.row] as? String
        cell.workName.text = genbaName[indexPath.row] as? String
            
        
        return cell
    }
        return UITableViewCell()
    }

    
    //行を選択された時に呼ばれる
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        ad.memberIndex = indexPath.row//アップデリゲートに保存
    }
 
    //コレクションビューのデリゲート、データソースを設定
    /*override */func tableView ( tableView : UITableView , willDisplayCell cell : UITableViewCell , forRowAtIndexPath indexPath : NSIndexPath ) {
        guard let TableViewCell = cell as? WorkTableViewCell
            else {
                return
        }
        TableViewCell.setCollectionViewDataSourceDelegate ( self , forRow : indexPath.row )
    }
    
//-----------------------------------------------------------------------------------------セルにデータをセット
    func setCell(cell:WorkTableViewCell,atIndexPath indexPath:NSIndexPath){
       
    }
    



    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//-----------------------------------------------------------------------------------------------------------------------セグエ
    override func prepareForSegue(segue:UIStoryboardSegue,sender:AnyObject?){
        

    }

    @IBAction func returnCal(segue:UIStoryboardSegue){//GenbaViewから戻ってくるとき（genbaMakeOkと統合、使ってない）

    
    }
    
    @IBAction func returnCalCancell(segue:UIStoryboardSegue){//GenbaMakeView,GenbaViewonからキャンセルしてきたとき
    }

//    @IBAction func returnCancellFromBeansEdit(segue:UIStoryboardSegue){//BeansEditTableViewからキャンセルしてきたとき
//        if ad.memberName.count == 0{//ビーンズが0のとき、強制的にmemberPlusへ飛ばす
//            self.performSegueWithIdentifier("BeansPlusReturn", sender: nil)
//        }
//    
//    }
    @IBAction func genbaMakeOK(segue:UIStoryboardSegue){//GenbaMakeViewControllerから戻ってきたとき
        //self.workDisplay.reloadData()
    
    }

    
    
    
    
    
    
    
    
    
    
    
    //--------------------------------------------------------------------------------------------------------------------collectionView処理
    // セルが表示されるときに呼ばれる処理（1個のセルを描画する毎に呼び出されます
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //tagが”50000”のbeansColection:UICollectionview
        if collectionView.tag == 50000{
            if indexPath.section == 0{
                let cell:CalViewBeansCollectionCell = collectionView.dequeueReusableCellWithReuseIdentifier("beansSelectCell", forIndexPath: indexPath) as! CalViewBeansCollectionCell
                    cell.layer.cornerRadius = 4
//                var rect:CGPoint = cell.frame.origin
//                cellRect.append(rect)
//                let pan = UIPanGestureRecognizer(target: self, action: "drugBeans")
//                self.view.addGestureRecognizer(pan)
//                print("gesture")
                cell.beansCollectionSelectImage.image = Beans[ad.memberBeans[indexPath.row]]
                cell.beansCollectionSelectImage.tag = indexPath.row
                cell.beansCollectionName.text = ad.memberName[indexPath.row]
                
                let panG = UIPanGestureRecognizer(target: self, action: "drugBeans:")
                cell.beansCollectionSelectImage.addGestureRecognizer(panG)
                
            return cell
        }
        }else if collectionView.tag != 50000{
            
       // if collectionView.tag == 2{
            if indexPath.section == 0{
                
                let cellIn:CalViewBeansInTableViewToCell = collectionView.dequeueReusableCellWithReuseIdentifier("cellInTableView", forIndexPath: indexPath) as! CalViewBeansInTableViewToCell
                //cellIn.layer.cornerRadius = 4
                cellIn.beansCollectionImage.image = Beans[tablefield[collectionView.tag][indexPath.row]]
                
                return cellIn
            }
        }
        return UICollectionViewCell()
    }
    
    // セクションの数（今回は1つだけです）
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // 表示するセルの数
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 50000{
        return ad.memberName.count
        }/*else if collectionView.tag != 50000{*/
        return tablefield[collectionView.tag].count
    //    }
    }
    
    //セルをタップしたとき
    func collectionView(collectionView:UICollectionView,didSelectItemAtIndexPath indexPath:NSIndexPath){
//        if collectionView.tag == 50000{
//            var beansImage = indexPath.row//セルの番号
//            BeansImage.image = Beans[ad.memberBeans[beansImage]]
//        }
    }

   
    //beansCollectionのセルをドラッグしたときに呼ばれる
    //①cellForItemAtIndexPathでジェスチャを登録、イメージに追加。追加したイメージにタグを付ける②ここでsender.view as! UIImageViewでイメージを呼び出し、タグ番号からイメージを決定
     func drugBeans(sender: UIPanGestureRecognizer) {
        let point:CGPoint = sender.locationInView(self.view)//はじめのポイント

        print(point.x,point.y)
        if sender.state == .Began{
            var num = sender.view as! UIImageView
            BeansImage.image = Beans[ad.memberBeans[num.tag]]
            BeansImage.frame = CGRectMake(point.x ,point.y ,50,50)
            view.addSubview(BeansImage)//ビューに追加
            BeansImage.alpha = 0.8
//            let indexPath:NSIndexPath? = beansColection.indexPathForItemAtPoint(point)//ポイントからindexPathを取得
//            print(indexPath?.row)
//            if indexPath != nil{//nilの対策
//                print("true")
//                BeansImage.image = Beans[ad.memberBeans[(indexPath!.row)]]
//            }
        }
        let drugPoint:CGPoint = CGPoint(x: sender.view!.center.x + point.x - 25,y: sender.view!.center.y - 50 + point.y)//ドラッグ量
        
        BeansImage.frame = CGRectMake(drugPoint.x,drugPoint.y/*point.x,point.y*/,50,50)
       // view.addSubview(BeansImage)//ビューに追加
      //  BeansImage.alpha = 0.9
        //        drugPoint = point
        
        if sender.state == .Ended{
            let dropZone = workDisplay.frame//ワークディスプレイの大きさを取得
            
            if CGRectContainsPoint(dropZone, drugPoint){//引数にCGRect,CGPointを持ち、Boolを返す
                BeansImage.frame = CGRectMake(0,0,50,50)
                
            }else{
                
                self.BeansImage.removeFromSuperview()
            }
        }
    }
   
    
//セルの行間？
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInterItemSpacing section: Int) -> CGFloat {

        
        return 0.0
    }
    
    
    
    
    
    
    
    
  
    
    
    
    
    
    
    
    
    
    
    

    
    
    
 //------------------------------------------------------------------------------------------------------------------------プラスボタン
    //ボタンタップ
    @IBAction func genbaPlusgo(sender: AnyObject) {
        self.plusButton.alpha = 0.2
        UIButton.animateWithDuration(0.1, animations: { () -> Void in
            self.plusButton.alpha = 1.0
        })
        self.performSegueWithIdentifier("GenbaMake", sender: nil)
    }

    //ボタン　ドラッグ＆ドロップ
    @IBAction func buttonPun(sender: UIPanGestureRecognizer) {
        var point:CGPoint = sender.translationInView(self.plusButton)
        var movePoint:CGPoint = CGPointMake(sender.view!.center.x + point.x,sender.view!.center.y)
                let scale = pushButtonScale.frame//移動範囲決定
                var drugPoint = sender.locationInView(self.view)//ドラッグポイントをCGPointで取得
                if CGRectContainsPoint(scale,drugPoint){//判定
                    print("ok")
                    sender.view!.center = movePoint
                    sender.setTranslation(CGPointZero, inView: self.plusButton)
                }else{
                    print("false")
        //        sender.view!.center = movePoint
        //        sender.setTranslation(CGPointZero, inView: self.plusButton)
                
                }

//        sender.view!.center = movePoint
//        sender.setTranslation(CGPointZero, inView: self.plusButton)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    //ボタンスワイプ
    @IBAction func memberPlusGoRight(sender: AnyObject) {
        UIButton.animateWithDuration(0.1, animations: { () -> Void in
            self.plusButton.frame = CGRectMake(self.view.frame.width / 2 + 30,self.view.frame.height - 80,60,60)
        })
        self.performSegueWithIdentifier("BeansPlusReturn", sender: nil)
    
    }

    @IBAction func memberPlusGoLeft(sender: AnyObject) {
                    UIButton.animateWithDuration(0.1, animations: { () -> Void in
                self.plusButton.frame = CGRectMake(self.view.frame.width / 2 - 60,self.view.frame.height - 80,60,60)
            })
            self.performSegueWithIdentifier("BeansPlusReturn", sender: nil)
        
    }
    

    
 
    
    
    
    
    
    
 //----------------------------------------------------------------------------------------------ｰｰｰｰｰｰｰｰｰｰｰｰｰｰｰｰｰｰｰｰｰｰｰｰｰｰｰｰｰｰビーンズ追加ボタン
    @IBAction func addBeansButton(sender: UIButton) {
        if WMtitle == "Add Beans"{
 //           calendarView.changeMode(.WeekView)
            WMtitle = "Month Cal"
            //weekMonth.setTitle("\(WMtitle)", forState: UIControlState.Normal)
            addBeans.setTitle("Month Cal", forState: UIControlState.Normal)
            beansColection.userInteractionEnabled = true
                        //アニメーション

            UIScrollView.animateWithDuration(0.2,
//                                       delay: 0,
//                                       options: UIViewAnimationOptions.CurveEaseOut,
                                       animations: { () in
                                       self.beansColection.frame = CGRectMake(16,80,self.calendarView.frame.width,200)
                }, completion: { (Bool) in
                 self.beansCollectionHeight.constant = 200//オートレイアウトの制約を変更
                 self.calendarView.changeMode(.WeekView)
            })
            
          
        }else if WMtitle == "Month Cal"{

            WMtitle = "Add Beans"
            //weekMonth.setTitle("\(WMtitle)", forState: UIControlState.Normal)
            addBeans.setTitle("Add Beans", forState: UIControlState.Normal)
            beansColection.userInteractionEnabled = false
            self.addBeansTop.constant = 200
                        //アニメーション
          
        UIScrollView.animateWithDuration(0.3,
//
                                         animations: { () in
                                          
                                            self.beansCollectionHeight.constant = 5
                                            self.addBeansTop.constant = 5
            }, completion: { (Bool) in
                self.addBeansTop.constant = 5

        })
            UIView.animateWithDuration(0.3,
                                             delay: 0,
                                             options: UIViewAnimationOptions.CurveEaseOut,
                                             animations: { () in
                                              self.calendarView.changeMode(.MonthView)
                                               
                }, completion: { (Bool) in
        })
        }
    }
    
}




















// MARK: - CVCalendarViewDelegate & CVCalendarMenuViewDelegate

extension CalViewController: CVCalendarViewDelegate, CVCalendarMenuViewDelegate {
    
    /// Required method to implement!
    func presentationMode() -> CalendarMode {
        return .MonthView
    }
    
    /// Required method to implement!
    func firstWeekday() -> Weekday {
        return .Sunday
    }
    
    // MARK: Optional methods
    
    func shouldShowWeekdaysOut() -> Bool {
        return shouldShowDaysOut
    }
    
    func shouldAnimateResizing() -> Bool {
        return true // Default value is true
    }
    
    //TODO: 不必要に何度もコールされているので、必用時以外を無処理でスルーする判定が必要**********************************************ここで日付を取得
    func didSelectDayView(dayView: CVCalendarDayView, animationDidFinish: Bool) {
        print("\(dayView.date.commonDescription) is selected! デフォルト")
        print("\(df.dateFromString(dayView.date.OKDate)!)　func OKDate　をNSDateに変換")
        print(dayView.date.OKDate)
        
        selectedDay = dayView
        selectDayDate = df.dateFromString(dayView.date.OKDate)!
        selectDayString = dayView.date.OKDate
        
    }
    
//    func pushDayView() {
//        let dayViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("DayView") as! DayViewController
//        //pushViewController(dayViewController, animated: true)
//        presentViewController(dayViewController, animated: true, completion: nil)
//        
//    }
    
    func presentedDateUpdated(date: CVDate) {
        if monthLabel.text != date.globalDescription && self.animationFinished {
            let updatedMonthLabel = UILabel()
            updatedMonthLabel.textColor = monthLabel.textColor
            updatedMonthLabel.font = monthLabel.font
            updatedMonthLabel.textAlignment = .Center
            updatedMonthLabel.text = date.globalDescription
            updatedMonthLabel.sizeToFit()
            updatedMonthLabel.alpha = 0
            updatedMonthLabel.center = self.monthLabel.center
            
            let offset = CGFloat(48)
            updatedMonthLabel.transform = CGAffineTransformMakeTranslation(0, offset)
            updatedMonthLabel.transform = CGAffineTransformMakeScale(1, 0.1)
            
            UIView.animateWithDuration(0.35, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.animationFinished = false
                self.monthLabel.transform = CGAffineTransformMakeTranslation(0, -offset)
                self.monthLabel.transform = CGAffineTransformMakeScale(1, 0.1)
                self.monthLabel.alpha = 0
                
                updatedMonthLabel.alpha = 1
                updatedMonthLabel.transform = CGAffineTransformIdentity
                
                }) { _ in
                    
                    self.animationFinished = true
                    self.monthLabel.frame = updatedMonthLabel.frame
                    self.monthLabel.text = updatedMonthLabel.text
                    self.monthLabel.transform = CGAffineTransformIdentity
                    self.monthLabel.alpha = 1
                    updatedMonthLabel.removeFromSuperview()
            }
            
            self.view.insertSubview(updatedMonthLabel, aboveSubview: self.monthLabel)
        }
    }
    
    func topMarker(shouldDisplayOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }
    
    func dotMarker(shouldShowOnDayView dayView: CVCalendarDayView) -> Bool {
        let day = dayView.date.day
        //        let randomDay = Int(arc4random_uniform(31))
        //        if day == randomDay {
        //            return true
        //        }
        
        return false
    }
    
    func dotMarker(colorOnDayView dayView: CVCalendarDayView) -> [UIColor] {
        
        let red = CGFloat(arc4random_uniform(600) / 255)
        let green = CGFloat(arc4random_uniform(600) / 255)
        let blue = CGFloat(arc4random_uniform(600) / 255)
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
        
        let numberOfDots = Int(arc4random_uniform(3) + 1)
        switch(numberOfDots) {
        case 2:
            return [color, color]
        case 3:
//            return [UIColor.whiteColor()]//変化なし
            return [color, color, color]
        default:
            return [color] // return 1 dot
//            return [UIColor.whiteColor()]//変化なし
        }
    }
    
    func dotMarker(shouldMoveOnHighlightingOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }
    
    func dotMarker(sizeOnDayView dayView: DayView) -> CGFloat {
        return 13
    }
    
    
    func weekdaySymbolType() -> WeekdaySymbolType {
        return .Short
    }
    
    func selectionViewPath() -> ((CGRect) -> (UIBezierPath)) {
        return { UIBezierPath(rect: CGRectMake(0, 0, $0.width, $0.height)) }
    }
    
    func shouldShowCustomSingleSelection() -> Bool {
        return false
    }
    
    func preliminaryView(viewOnDayView dayView: DayView) -> UIView {
        let circleView = CVAuxiliaryView(dayView: dayView, rect: dayView.bounds, shape: CVShape.Circle)
        circleView.fillColor = .colorFromCode(0xCCCCCC)
        return circleView
    }
    
    func preliminaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        if (dayView.isCurrentDay) {
            return true
        }
        return false
    }
    
    func supplementaryView(viewOnDayView dayView: DayView) -> UIView {
        let π = M_PI
        
        let ringSpacing: CGFloat = 3.0
        let ringInsetWidth: CGFloat = 1.0
        let ringVerticalOffset: CGFloat = 1.0
        var ringLayer: CAShapeLayer!
        let ringLineWidth: CGFloat = 4.0
        let ringLineColour: UIColor = UIColor.mahogany()//.blueColor()
        
        let newView = UIView(frame: dayView.bounds)
        
        let diameter: CGFloat = (newView.bounds.width) - ringSpacing
        let radius: CGFloat = diameter / 2.0
        
        let rect = CGRectMake(newView.frame.midX-radius, newView.frame.midY-radius-ringVerticalOffset, diameter, diameter)
        
        ringLayer = CAShapeLayer()
        newView.layer.addSublayer(ringLayer)
        
        ringLayer.fillColor = nil
        ringLayer.lineWidth = ringLineWidth
        ringLayer.strokeColor = ringLineColour.CGColor
        
        let ringLineWidthInset: CGFloat = CGFloat(ringLineWidth/2.0) + ringInsetWidth
        let ringRect: CGRect = CGRectInset(rect, ringLineWidthInset, ringLineWidthInset)
        let centrePoint: CGPoint = CGPointMake(ringRect.midX, ringRect.midY)
        let startAngle: CGFloat = CGFloat(-π/2.0)
        let endAngle: CGFloat = CGFloat(π * 2.0) + startAngle
        let ringPath: UIBezierPath = UIBezierPath(arcCenter: centrePoint, radius: ringRect.width/2.0, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        ringLayer.path = ringPath.CGPath
        ringLayer.frame = newView.layer.bounds
        
        return newView
    }
    
    func supplementaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        //demo
        //        if (Int(arc4random_uniform(3)) == 1) {
        //            return true
        //        }
        
        return false
    }
}


// MARK: - CVCalendarViewAppearanceDelegate

extension CalViewController: CVCalendarViewAppearanceDelegate {
    func dayLabelPresentWeekdayInitallyBold() -> Bool {
        return false
    }
    
    func spaceBetweenDayViews() -> CGFloat {
        return 2
    }
}

// MARK: - IB Actions

extension CalViewController {
    @IBAction func switchChanged(sender: UISwitch) {
        if sender.on {
            calendarView.changeDaysOutShowingState(false)
            shouldShowDaysOut = true
        } else {
            calendarView.changeDaysOutShowingState(true)
            shouldShowDaysOut = false
        }
    }
    
 //-------------------------------------------------------ビーンズ編集
    @IBAction func weekAndMonth(sender: UIButton) {
        
//        if WMtitle == "Edit Beans"{
//            WMtitle = "Month Cal"
//            weekMonth.setTitle("\(WMtitle)", forState: UIControlState.Normal)
//            addBeans.setTitle("Month Cal", forState: UIControlState.Normal)
//            beansColection.userInteractionEnabled = true
//            //アニメーション
//            
//            UIScrollView.animateWithDuration(0.2,
//                                             //                                       delay: 0,
//                //                                       options: UIViewAnimationOptions.CurveEaseOut,
//                animations: { () in
//                    self.beansColection.frame = CGRectMake(16,80,self.calendarView.frame.width,230)
//                }, completion: { (Bool) in
//                    self.beansCollectionHeight.constant = 230//オートレイアウトの制約を変更
//                    self.calendarView.changeMode(.WeekView)
//            })
//        }else if WMtitle == "Month Cal"{
//            WMtitle = "Edit Beans"
//            weekMonth.setTitle("\(WMtitle)", forState: UIControlState.Normal)
//            addBeans.setTitle("Edit Beans", forState: UIControlState.Normal)
//            beansColection.userInteractionEnabled = false
//            self.addBeansTop.constant = 200
//            //アニメーション
//            
//            UIScrollView.animateWithDuration(0.3,
//                                             //
//                animations: { () in
//                    
//                    self.beansCollectionHeight.constant = 5
//                    self.addBeansTop.constant = 5
//                }, completion: { (Bool) in
//                    self.addBeansTop.constant = 5
//                    
//            })
//            UIView.animateWithDuration(0.3,
//                                       delay: 0,
//                                       options: UIViewAnimationOptions.CurveEaseOut,
//                                       animations: { () in
//                                        self.calendarView.changeMode(.MonthView)
//                                        
//                }, completion: { (Bool) in
//            })
//        }
        
    }


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func todayMonthView() {
        calendarView.toggleCurrentDayView()
    }
    
    /// Switch to WeekView mode.
    @IBAction func toWeekView(sender: AnyObject) {
        calendarView.changeMode(.WeekView)
    }
    
    /// Switch to MonthView mode.
    @IBAction func toMonthView(sender: AnyObject) {
        calendarView.changeMode(.MonthView)
    }
    
    @IBAction func loadPrevious(sender: AnyObject) {
        calendarView.loadPreviousView()
    }
    
    
    @IBAction func loadNext(sender: AnyObject) {
        calendarView.loadNextView()
    }
}

// MARK: - Convenience API Demo

extension CalViewController {
    func toggleMonthViewWithMonthOffset(offset: Int) {
        let calendar = NSCalendar.currentCalendar()
        //        let calendarManager = calendarView.manager
        let components = Manager.componentsForDate(NSDate()) // from today
        
        components.month += offset
        
        let resultDate = calendar.dateFromComponents(components)!
        
        self.calendarView.toggleViewWithDate(resultDate)
    }
    
    func didShowNextMonthView(date: NSDate)
    {
        //        let calendar = NSCalendar.currentCalendar()
        //        let calendarManager = calendarView.manager
        let components = Manager.componentsForDate(date) // from today
        
        print("Showing Month: \(components.month) : \(date)")
        
        monthLabel.text = CVDate(date: date).globalDescription //スワイプで次月へ移動時に年月ラベルを次月に更新
    }
    
    
    func didShowPreviousMonthView(date: NSDate)
    {
        //        let calendar = NSCalendar.currentCalendar()
        //        let calendarManager = calendarView.manager
        let components = Manager.componentsForDate(date) // from today
        
        print("Showing Month: \(components.month) : \(date)")
        monthLabel.text = CVDate(date: date).globalDescription //スワイプで前月へ移動時に年月ラベルを前月に更新
    }
    
}


