//
//  CreateTimeTableCell.swift
//  ulink
//
//  Created by 양시연 on 2020/07/08.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class CreateTimeTableCell: UICollectionViewCell {
    
    static let identifier: String = "createTimeTableCell"
    
    @IBOutlet weak var timeTableNameLabel: UILabel!
    @IBOutlet weak var timeTable: TimeTable!
    
    var timeTableIdx : Int = 0
    var subjectList : [Subject] = []

    
    func setCreateTimeTableCell(idx: Int, name: String, subjectList: [Subject]){
        
        timeTableNameLabel.text = name
        self.timeTableIdx = idx
        self.subjectList = subjectList
        
    }
    
   
    
}

