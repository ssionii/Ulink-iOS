//
//  DetailEventCell.swift
//  ulink
//
//  Created by SeongEun on 2020/07/06.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class DetailEventCell: UICollectionViewCell {
    static let identifier: String = "detailEventCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.cornerRadius = 20
    }
}
