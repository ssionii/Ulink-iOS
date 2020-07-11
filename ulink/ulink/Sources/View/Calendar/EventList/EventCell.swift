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
        
        
        nameLabel.text = contentInfo.name
        timeLabel.text = contentInfo.start_time
        if (contentInfo.category == "과제"){
            categoryLabel.backgroundColor = UIColor.pink
            categoryLabel.setTitle("과제", for: .normal)
        } else if (contentInfo.category == "수업"){
            categoryLabel.backgroundColor = UIColor.robinSEgg
            categoryLabel.setTitle("수업", for: .normal)
        } else {
            categoryLabel.backgroundColor = UIColor.periwinkleBlue
            categoryLabel.setTitle("시험", for: .normal)
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
