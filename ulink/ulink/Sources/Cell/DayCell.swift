//
//  DayCell.swift
//  ulink
//
//  Created by SeongEun on 2020/07/03.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class DayCell: UICollectionViewCell {
    static let identifier: String = "dayCell"
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet var eventLabels: [UIButton]!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        clearEvent()
        dateLabel.backgroundColor = UIColor.white
    }
    
    func setDayCell(firstDay: Int, textColor: Int) {
        dateLabel.text = String(firstDay + 1)
        if (textColor == 0) {
            dateLabel.textColor = UIColor.veryLightPink
            dateLabel.backgroundColor = UIColor.white
        } else if (textColor == 1){
            dateLabel.textColor = UIColor.purpleishBlue
            dateLabel.backgroundColor = UIColor.white
        } else if (textColor == 2){
            dateLabel.textColor = UIColor.darkGray
            dateLabel.backgroundColor = UIColor.white
        } else {
            //오늘
            dateLabel.textColor = UIColor.white
            dateLabel.backgroundColor = UIColor.purpleishBlue
            dateLabel.layer.cornerRadius = 7
            dateLabel.layer.masksToBounds = true
        }
    }
    
    func setEvent(eventName: [String], color: [UIColor]){
        print("eventColor", color)
        print("eventcount", color.count)
        for i in 0...color.count-1 {
            eventLabels[i].isHidden = false
            eventLabels[i].backgroundColor = color[i]
            eventLabels[i].setTitle(eventName[i], for: .normal)
        }
    }
    
    func clearEvent(){
        for i in 0...4 {
            eventLabels[i].layer.cornerRadius = 3
            eventLabels[i].isHidden = true
        }
    }
    
    func showBorder(row: Int){
        if (row < 7){
            self.layer.addBorder(edge: [.top], color: UIColor.clear, thickness: 1)
        } else if (row >= 7){
            self.layer.addBorder(edge: [.top], color: UIColor.veryLightPink, thickness: 1)
        }
    }
}
