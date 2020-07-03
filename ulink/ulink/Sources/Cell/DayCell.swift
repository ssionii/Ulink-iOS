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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setDayCell(firstDay: Int) {
        dateLabel.text = String(firstDay + 1)
    }
}
