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

    override func awakeFromNib() {
        super.awakeFromNib()
    
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAddTimeInfoCell)))
        
    }
    
    @objc func tapAddTimeInfoCell(){
               
        self.delegate?.didPressAddBtn(idx: 0)
    }
    
}
