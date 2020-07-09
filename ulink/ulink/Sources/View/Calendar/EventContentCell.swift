//
//  EventContentCell.swift
//  ulink
//
//  Created by SeongEun on 2020/07/08.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class EventContentCell: UITableViewCell {

    static let identifier: String = "eventContentCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cellColorView: UIView!
    @IBOutlet weak var categoryLabel: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        categoryLabel.layer.cornerRadius = 11
        cellColorView.layer.cornerRadius = 19
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
