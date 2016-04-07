//
//  CalViewController.swift
//  member'sCal
//
//  Created by 吉田＿悟志 on 2016/03/20.
//  Copyright © 2016年 yoshidajumokui.llc. All rights reserved.
//

import UIKit

class CalViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var workDisplay: UITableView!
    
    // MARK: - Properties
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var weekMonth: UIButton!
    //    @IBOutlet weak var daysOutSwitch: UISwitch!
    
    var shouldShowDaysOut = true
    var animationFinished = true
    
    var selectedDay:DayView!
    
    var WMtitle = ""//----------------week/month切替変数
    
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
    
    
    let ad = UIApplication.sharedApplication().delegate as! AppDelegate
    
    // MARK: - Life cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.menuView.firstWeekday = .Sunday
        //TODO: 画面サイズが小さい時はフォントサイズを小さくする必要があるので画面サイズ判定での調整を追加する必要がある
        //monthLabel.font = UIFont.systemFontOfSize(CGFloat(19))
        monthLabel.font = UIFont.boldSystemFontOfSize(CGFloat(25))
        monthLabel.text = CVDate(date: NSDate()).globalDescription
        
        //TODO: 今月以外の日にちをタップしてその月にスクロールしても、タップした日にちが選択されないので非表示にしておく。不具合解消したらON
        calendarView.changeDaysOutShowingState(true)
        shouldShowDaysOut = false
        
        WMtitle = "Week"//-----------------カレンダー表示のデフォルトを"Week"に
        weekMonth.setTitle("\(WMtitle)", forState: UIControlState.Normal)
        
        
        //-------------------------------------------------------------------appDelegateの変数を代入
        let ad = UIApplication.sharedApplication().delegate as! AppDelegate
       genbaName = ad.calGenbaName
        startTime = ad.calStartTime
        finishTime = ad.calFinishTime
       day = ad.calDay
//
//        beansStartTime = ad.calStartTime
//        beansFinishTime = ad.calFinishTime
//        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
//            var ad = UIApplication.sharedApplication().delegate as! AppDelegate
        
        workDisplay.reloadData()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        calendarView.commitCalendarViewUpdate()
        menuView.commitMenuViewUpdate()
    }
    

    
    
    
    
    
    
    
    
//-----------------------------------------------------------------------------------------テーブルビュー処理
    //行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genbaName.count
    }
    
    //セルの内容
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .Default, reuseIdentifier: "genbaCell")
        if indexPath.section == 0{
            
        let cell = tableView.dequeueReusableCellWithIdentifier("genbaCell") as! WorkTableViewCell
        cell.start.text = startTime[indexPath.row] as! String
        cell.finish.text = finishTime[indexPath.row] as! String
        cell.workName.text = genbaName[indexPath.row] as! String
            

        return cell
    }
        return UITableViewCell()
    }

    
    //行を選択された時に呼ばれる
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        ad.ADIndex = indexPath.row//アップデリゲートに保存
    }
 

//-----------------------------------------------------------------------------------------セルにデータをセット
    func setCell(cell:WorkTableViewCell,atIndexPath indexPath:NSIndexPath){
        
    }
    



    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//------------------------------------------------------------------------------------------セグエ
    override func prepareForSegue(segue:UIStoryboardSegue,sender:AnyObject?){
        
        
        
//        if (segue.identifier == "GenbaDetailGo"){
//          ad.ADIndex = calIndex//アップデリゲートに保存
//            print(ad.ADIndex)
//        var GVC = segue.destinationViewController as! GenbaViewController
//            GVC.genIndex = calIndex
 //           print(calIndex)
//        GVC.workName?.text = genbaName[calIndex] as! String
//        GVC.startTime?.text = startTime[calIndex] as! String
//        GVC.finishTime?.text = finishTime[calIndex] as! String
//        }
    }

    @IBAction func returnCal(segue:UIStoryboardSegue){//GenbaViewから戻ってくるとき
//        let GVC = segue.sourceViewController as! GenbaViewController
//        calIndex = GVC.genIndex
//        let VC = GenbaViewController()
//        var memberInThisGenba = VC.memberSelect
//        var val:[String] = []
//        ad.calBeansName.append
//        for (x,value) in memberInThisGenba {
//            val.append(value)
//        }
    
    }
    
    @IBAction func returnCalCancell(segue:UIStoryboardSegue){//genbaBiewからキャンセルしてきたとき
        let GVC = segue.sourceViewController as! GenbaViewController
        calIndex = GVC.genIndex
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
    
    //TODO: 不必要に何度もコールされているので、必用時以外を無処理でスルーする判定が必要
    func didSelectDayView(dayView: CVCalendarDayView, animationDidFinish: Bool) {
        print("\(dayView.date.commonDescription) is selected!")
        selectedDay = dayView
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
            return [color, color, color]
        default:
            return [color] // return 1 dot
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
    
 //-------------------------------------------------------week/month統合
    @IBAction func weekAndMonth(sender: UIButton) {
        if WMtitle == "Week"{
            calendarView.changeMode(.WeekView)
            WMtitle = "Month"
            weekMonth.setTitle("\(WMtitle)", forState: UIControlState.Normal)
        }else if WMtitle == "Month"{
            calendarView.changeMode(.MonthView)
            WMtitle = "Week"
            weekMonth.setTitle("\(WMtitle)", forState: UIControlState.Normal)
        }
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


