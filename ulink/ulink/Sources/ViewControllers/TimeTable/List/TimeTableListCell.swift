//
//  TimeTableListCell.swift
//  ulink
//
//  Created by 양시연 on 2020/07/05.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class TimeTableListCell: UICollectionViewCell {
    
    static let identifier: String = "TimeTableListCell"
    
    var timeTableIdx : Int = 0
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    
    
    func setTimeTableListCell(idx : Int, name: String, isMain: Int){
        self.timeTableIdx = idx
        self.nameLabel.text = name
        
        if isMain == 0 {
            self.mainImageView.alpha = 0
        }
    }
    
    func setLastTimeTableListCell(){
        self.timeTableIdx = -1
        self.nameLabel.text = ""
         self.mainImageView.removeFromSuperview()
    }
    
}
