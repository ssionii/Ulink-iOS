//
//  BoardListTableCell.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/23.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class BoardListTableCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setBoardData(title : String)
    {
        self.titleLabel.text = title
    }

}