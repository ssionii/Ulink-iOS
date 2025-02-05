//
//  ChattingTableViewCell.swift
//  ulink
//
//  Created by 송지훈 on 2020/06/30.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class ChattingTableViewCell: UITableViewCell {
    
    
    static let identifiers : String = "ChattingCell"

    @IBOutlet weak var chattingthumbnailImage: UIImageView!
    @IBOutlet weak var chattingTitle: UILabel!
    @IBOutlet weak var chattingStudentNumber: UILabel!
    @IBOutlet weak var chattingBadge: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        
        

        // Configure the view for the selected state
    }

}
