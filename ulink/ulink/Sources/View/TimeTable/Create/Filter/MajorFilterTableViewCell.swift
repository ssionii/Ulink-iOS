//
//  MajorFilterTableViewCell.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/14.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class MajorFilterTableViewCell: UITableViewCell {

    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var myMajorButton: UIButton!
    @IBOutlet weak var checkButtonImage: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
