//
//  EventListHeaderCellTableViewCell.swift
//  ulink
//
//  Created by SeongEun on 2020/07/10.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class EventListHeaderCell: UITableViewCell {
    
    static let identifier: String = "eventListHeaderCell"

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dDayLabel: UILabel!
    
    //오늘 날짜 데이터
    let cal = Calendar(identifier: .gregorian)
    let today = Date()
    var todayMonth = Calendar.current.component(.month, from: Date())
    var todayYear = Calendar.current.component(.year, from: Date())
    var todayDate = Calendar.current.component(.day, from: Date())
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dateLabel.textColor = UIColor.brownGrey
        dDayLabel.textColor = UIColor.purpleishBlue
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(_ eventInfo: EventList){
        dateLabel.text = getWeekDay(date: eventInfo.date)
        
        var dDay = getDday(date: eventInfo.date)
        if (dDay == 0){
            dDayLabel.text = "D-day"
        } else {
            dDayLabel.text = "D-" + String(getDday(date: eventInfo.date))
        }
        
    }
    
    
    //날짜 스트링 맹글기
    func getWeekDay(date: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let myDay = dateFormatter.date(from: date)
        
        let first = cal.dateComponents([.day], from: myDay!).day
        let weekday = cal.dateComponents([.weekday], from: myDay!)
        var stringWeekday: String
        switch weekday.weekday {
        case 1:
            stringWeekday = "일"
        case 2:
            stringWeekday = "월"
        case 3:
            stringWeekday = "화"
        case 4:
            stringWeekday = "수"
        case 5:
            stringWeekday = "목"
        case 6:
            stringWeekday = "금"
        case 7:
            stringWeekday = "토"
        default:
            stringWeekday = "일"
        }
        
        let dateString = String(first!) + "일 (" + stringWeekday + ")"
        
        return dateString
    }
    
    //디데이,,,,,
    func getDday(date: String) -> Int{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let myDay = dateFormatter.date(from: date)
        
        let start = cal.startOfDay(for: today)
        let end = cal.startOfDay(for: myDay!)
        
        let components = cal.dateComponents([.day], from: start, to: end)
        
        
        return components.day!
    }

}
