//時間と日付を比較して大きい方を返す

import UIKit

class DayAndTimeCompare: UIView {
//    var startDay = ""
//    var startTime = ""
//    var finishDay = ""
//    var finishTime = ""
//    
//    var dateFormatterDay = NSDateFormatter()//日
//    var dateFormatterTime = NSDateFormatter()//時間
//    var dateFormatterAll = NSDateFormatter()//日時
    
    func dayCompare(var start:String,var finish:String) -> String{

        //        dateFormatterDay.dateFormat = "yyyy/MM/dd"
        //        dateFormatterTime.dateFormat = "HH:mm"
        //       dateFormatterAll.dateFormat = "yyyy/MM/dd HH:mm"
        
        if start.compare(finish) == NSComparisonResult.OrderedDescending{
            finish = start
        }
        return finish
    }

}
