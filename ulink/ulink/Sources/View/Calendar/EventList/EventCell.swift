//
//  EventTableViewCell.swift
//  ulink
//
//  Created by SeongEun on 2020/07/10.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
    
    static let identifier: String = "eventCell"
    
    @IBOutlet weak var categoryLabel: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cellColorView: UIView!
    
    //오늘 날짜 데이터
    let cal = Calendar(identifier: .gregorian)
    let today = Date()
    var todayMonth = Calendar.current.component(.month, from: Date())
    var todayYear = Calendar.current.component(.year, from: Date())
    var todayDate = Calendar.current.component(.day, from: Date())
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellColorView.backgroundColor = UIColor.whiteThree
        
        // Initialization code
        categoryLabel.layer.cornerRadius = 11
        cellColorView.layer.cornerRadius = 19
        
        self.selectedBackgroundView?.backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(_ contentInfo: NoticeData){
        
        nameLabel.text = contentInfo.name + " " + contentInfo.title
        if (contentInfo.category == "과제"){
            categoryLabel.backgroundColor = UIColor.pink
            categoryLabel.setTitle("과제", for: .normal)
            timeLabel.text = contentInfo.endTime
        } else if (contentInfo.category == "수업"){
            categoryLabel.backgroundColor = UIColor.robinSEgg
            categoryLabel.setTitle("수업", for: .normal)
            timeLabel.text = ""
        } else {
            categoryLabel.backgroundColor = UIColor.periwinkleBlue
            categoryLabel.setTitle("시험", for: .normal)
            timeLabel.text = contentInfo.startTime
        }
    }

    func getDday(date: String) -> Int{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let myDay = dateFormatter.date(from: date)
        
        let start = cal.startOfDay(for: today)
        let end = cal.startOfDay(for: myDay!)
        
        let components = cal.dateComponents([.day], from: start, to: end)
        
        return components.day!
    }
    
    func changeViewColor(_ dateInfo: String){
        var dDay = getDday(date: dateInfo)
        if (dDay == 0){
            cellColorView.backgroundColor = UIColor.paleGreyTwo
        }
    }
}
