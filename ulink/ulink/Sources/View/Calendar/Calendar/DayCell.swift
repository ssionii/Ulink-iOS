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
    
    var colors = [UIColor.periwinkleBlueTwo, UIColor.babyPurple, UIColor.lightblue, UIColor.powderPink, UIColor.periwinkleBlue, UIColor.skyBlueTwo, UIColor.pink, UIColor.easterPurple, UIColor.robinSEgg, UIColor.skyBlue]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.addBorder(edge: [.top], color: UIColor.veryLightPink, thickness: 1)
        
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
    
    func setEvent(eventName: [NoticeData]){
        for i in 0...eventName.count-1 {
            eventLabels[i].isHidden = false
            eventLabels[i].setTitle(eventName[i].name, for: .normal)
            eventLabels[i].backgroundColor = colors[eventName[i].color]
        }
    }
    
    func clearEvent(){
        for i in 0...4 {
            eventLabels[i].layer.cornerRadius = 3
            eventLabels[i].isHidden = true
        }
    }
}
