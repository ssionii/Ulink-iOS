//
//  ChattingTableViewCell.swift
//  ulink
//
//  Created by 송지훈 on 2020/06/30.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class ChattingTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var chattingRoomTitle: UILabel!
    static let identifiers : String = "ChattingCell"
    @IBOutlet weak var chattingNumberBadge: UILabel!
    
    @IBOutlet weak var chattingUserCountLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        
    
        

    func setChattingCellData(title:String,number:String){
            
        
        chattingRoomTitle.text = title
        chattingNumberBadge.clipsToBounds = true
        chattingNumberBadge.text = number
        chattingNumberBadge.layer.cornerRadius = chattingNumberBadge.font.pointSize * 1.2 / 2
        chattingNumberBadge.backgroundColor = .red
        chattingNumberBadge.textColor = .white
        
        

            
            
        }
        
        

        // Configure the view for the selected state
    }

}
