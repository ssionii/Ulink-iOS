//
//  SubjectInfoCellNotExpand.swift
//  ulink
//
//  Created by 양시연 on 2020/07/12.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class SubjectInfoCellNotExpand: UITableViewCell {
    
     static let identifier: String = "subjectInfoCellNotExpand"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var professorNameLabel: UILabel!
    @IBOutlet weak var timeInfoLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var subjectNumberLabel: UILabel!
    

    
    func setSubjectInfoData(name: String, professorName: String, timeInfo: String, room: String, category: String, credit: Int, subjectNum : String){
           
           nameLabel.text = name
           professorNameLabel.text = professorName
           timeInfoLabel.text = timeInfo
           roomLabel.text = room
           courseLabel.text = category
           creditLabel.text = String(credit) + "학점"
            subjectNumberLabel.text = subjectNum
       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
