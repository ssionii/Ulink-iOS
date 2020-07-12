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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellColorView.backgroundColor = UIColor.paleGreyTwo
        
        // Initialization code
        categoryLabel.layer.cornerRadius = 11
        cellColorView.layer.cornerRadius = 19
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(_ contentInfo: Event){
        
        print("set 호출됨")
        
        nameLabel.text = contentInfo.name
        if (contentInfo.category == "과제"){
            categoryLabel.backgroundColor = UIColor.pink
            categoryLabel.setTitle("과제", for: .normal)
            timeLabel.text = contentInfo.end_time
        } else if (contentInfo.category == "수업"){
            categoryLabel.backgroundColor = UIColor.robinSEgg
            categoryLabel.setTitle("수업", for: .normal)
            timeLabel.text = ""
        } else {
            categoryLabel.backgroundColor = UIColor.periwinkleBlue
            categoryLabel.setTitle("시험", for: .normal)
            timeLabel.text = contentInfo.start_time
        }
    }
    
    func changeViewColor(isToday: Bool){
        if (isToday == false){
            cellColorView.backgroundColor = UIColor.paleGreyTwo
        } else {
            cellColorView.backgroundColor = UIColor.whiteThree
        }
    }
}
