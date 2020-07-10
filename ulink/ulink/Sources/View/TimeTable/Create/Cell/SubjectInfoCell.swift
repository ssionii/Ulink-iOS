//
//  SubjectInfoCell.swift
//  ulink
//
//  Created by 양시연 on 2020/07/10.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class SubjectInfoCell: UITableViewCell {
    
    static let identifier: String = "subjectInfoCell"

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var professorNameLabel: UILabel!
    @IBOutlet weak var timeInfoLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var bottomBorder: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setSubjectInfoData(name: String, professorName: String, timeInfo: String, room: String, category: String, credit: Int){
        
        nameLabel.text = name
        professorNameLabel.text = professorName
        timeInfoLabel.text = timeInfo
        roomLabel.text = room
        courseLabel.text = category
        creditLabel.text = String(credit) + "학점"
    }
    
    func hideBorder(){
        self.bottomBorder.alpha = 0
    }
    
    func showBorder(){
           self.bottomBorder.alpha = 1
       }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    


}
