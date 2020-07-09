//
//  NoticeDetailTableCell.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/08.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class NoticeDetailTableCell: UITableViewCell {

    
    
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var noticeLabel: UILabel!
    
    @IBOutlet weak var dDayLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
