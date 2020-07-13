//
//  RealTimeSearchCell.swift
//  ulink
//
//  Created by SeongEun on 2020/07/13.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class RealTimeSearchCell: UITableViewCell {
    
    static let identifier: String = "realTimeSearchCell"
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func show(titleString: String){
        titleLabel.text = titleString
    }
    
}
