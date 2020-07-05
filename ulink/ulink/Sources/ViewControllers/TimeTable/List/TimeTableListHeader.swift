//
//  TimeTableListHeader.swift
//  ulink
//
//  Created by 양시연 on 2020/07/05.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class TimeTableListHeader: UICollectionReusableView {
        
    static let identifier: String = "timeTableListHeader"
    
    @IBOutlet weak var semesterLabel: UILabel!
    
    func setSemester(semester : String){
        
        self.semesterLabel.text = semester
    }
    
    
    
    
}
