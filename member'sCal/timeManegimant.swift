//
//  timeManegimant.swift
//  member'sCal
//
//  Created by 吉田＿悟志 on 2016/05/04.
//  Copyright © 2016年 yoshidajumokui.llc. All rights reserved.
//

//表示するビューをEnabled true　にする！

import UIKit

class timeManegimant: UIView {
    @IBOutlet weak var stackView: UIView!
    @IBOutlet weak var InView: UIView!
    @IBOutlet weak var min: UIImageView!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var max: UIImageView!
    @IBOutlet weak var maxLabel: UILabel!
    
    @IBOutlet weak var one: UIView!
    @IBOutlet weak var two: UIView!
    @IBOutlet weak var three: UIView!
    @IBOutlet weak var four: UIView!
    @IBOutlet weak var five: UIView!
    @IBOutlet weak var six: UIView!
    
    
    class func instance() -> timeManegimant{
        return UINib(nibName: "timeManegiment", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! timeManegimant
    }
    
    var startTime = ""
    var finishTime = ""
    
    
    func firstLoad(){
        one.layer.cornerRadius = 3
        two.layer.cornerRadius = 3
        three.layer.cornerRadius = 3
        four.layer.cornerRadius = 3
        five.layer.cornerRadius = 3
        six.layer.cornerRadius = 3
        min.frame = CGRectMake(InView.center.x - 100,InView.center.y/* - 36*/,40,40)
        max.frame = CGRectMake(InView.center.x - 40,InView.center.y /*- 36*/,40,40)
//        min.translatesAutoresizingMaskIntoConstraints = true
//        max.translatesAutoresizingMaskIntoConstraints = true
        
    }
    
    @IBAction func minDrug(sender: UIPanGestureRecognizer) {
        let point:CGPoint = sender.translationInView(self.min)
        let movePoint:CGPoint = CGPointMake(sender.view!.center.x + point.x,sender.view!.center.y)
        
        let dropZone = InView.frame
        //var drugPoint = sender.locationInView(self.view)//ドラッグポイントを取得
        if CGRectContainsPoint(dropZone, movePoint){
            sender.view!.center = movePoint
            sender.setTranslation(CGPointZero, inView: self.min)//移動蓄積値をゼロにしている
            UILabel.animateWithDuration(0.1, animations: { () -> Void in
                self.minLabel.center.x = self.min.center.x
            })
        }else{//ここには何も書かないので何もおこらない
        }
        
        //ボタン同士が接触しない命令
        if movePoint.x >= max.center.x {
            max.center.x = min.center.x + 5
        }
        
        if sender.state == .Ended{
            if movePoint.x >= max.center.x {
                max.center.x = min.center.x + 5
            }
            startTime = time(Int(min.center.x - InView.frame.origin.x))
            print("start",startTime)
        }
    }
    
    @IBAction func maxDrug(sender: UIPanGestureRecognizer) {
        let point:CGPoint = sender.translationInView(self.max)
        let movePoint:CGPoint = CGPointMake(sender.view!.center.x + point.x,sender.view!.center.y)
        
        let dropZone = InView.frame
        if CGRectContainsPoint(dropZone, movePoint){
            sender.view!.center = movePoint
            sender.setTranslation(CGPointZero, inView: self.max)//移動蓄積値をゼロにしている
            
            UILabel.animateWithDuration(0.1, animations: { () -> Void in
                self.maxLabel.center.x = self.max.center.x
            })
        }else{
        }
        if movePoint.x <= min.center.x{
            min.center.x = max.center.x - 5
        }
        
        if sender.state == .Ended{
            finishTime = time(Int(max.center.x - InView.frame.origin.x))
            print("finish",finishTime)
        }
    }
    
    func time(ten:Int) -> String{
        var str = ""
        var point = 0
        point = 48 * ten / Int(InView.frame.width)
        switch  point {
        case 0..<1:
            str = "00:00"
        case 1..<2:
            str = "00:30"
        case 2..<3:
            str = "01:00"
        case 3..<4:
            str = "01:30"
        case 4..<5:
            str = "02:00"
        case 5..<6:
            str = "02:30"
        case 6..<7:
            str = "03:00"
        case 7..<8:
            str = "03:30"
        case 8..<9:
            str = "04:00"
        case 9..<10:
            str = "04:30"
        case 10..<11:
            str = "05:00"
        case 11..<12:
            str = "05:30"
        case 12..<13:
            str = "06:00"
        case 13..<14:
            str = "06:30"
        case 14..<15:
            str = "07:00"
        case 15..<16:
            str = "07:30"
        case 16..<17:
            str = "08:00"
        case 17..<18:
            str = "08:30"
        case 18..<19:
            str = "09:00"
        case 19..<20:
            str = "09:30"
        case 20..<21:
            str = "10:00"
        case 21..<22:
            str = "10:30"
        case 22..<23:
            str = "11:00"
        case 23..<24:
            str = "11:30"
        case 24..<25:
            str = "12:00"
        case 25..<26:
            str = "12:30"
        case 26..<27:
            str = "13:00"
        case 27..<28:
            str = "13:30"
        case 28..<29:
            str = "14:00"
        case 29..<30:
            str = "14:30"
        case 30..<31:
            str = "15:00"
        case 31..<32:
            str = "15:30"
        case 32..<33:
            str = "16:00"
        case 33..<34:
            str = "16:30"
        case 34..<35:
            str = "17:00"
        case 35..<36:
            str = "17:30"
        case 36..<37:
            str = "18:00"
        case 37..<38:
            str = "18:30"
        case 38..<39:
            str = "19:00"
        case 39..<40:
            str = "19:30"
        case 40..<41:
            str = "20:00"
        case 41..<42:
            str = "20:30"
        case 42..<43:
            str = "21:00"
        case 43..<44:
            str = "21:30"
        case 44..<45:
            str = "22:00"
        case 45..<46:
            str = "22:30"
        case 46..<47:
            str = "23:00"
        case 47..<48:
            str = "23:30"
        case 48...49:
            str = "24:00"
            
        default:
            str = "24:00"
            
            
        }
        return str
    }
    
    
    
    
    
    
    
    
    

    
    
  }
