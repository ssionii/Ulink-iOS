//
//  AddTimeInfoCell.swift
//  ulink
//
//  Created by 양시연 on 2020/07/14.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

protocol AddTimeInfoCellDelegate {

    func didPressAddBtn(idx: Int)
}

class AddTimeInfoCell: UITableViewCell {
    
    static let identifier: String = "addTimeInfoCell"
    public var delegate : AddTimeInfoCellDelegate?

    @IBOutlet weak var contentBackgroundView: UIView!
    
    @IBAction func addTimeInfo(_ sender: Any) {
        
        self.delegate?.didPressAddBtn(idx: 0)
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    
        // Initialization code
    }
    
}
