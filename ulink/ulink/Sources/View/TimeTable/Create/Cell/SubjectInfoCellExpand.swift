//
//  SubjectInfoCell.swift
//  ulink
//
//  Created by 양시연 on 2020/07/10.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class SubjectInfoCellExpand: UITableViewCell {
    
    static let identifier: String = "subjectInfoCellExpand"

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var professorNameLabel: UILabel!
    @IBOutlet weak var timeInfoLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var subjectNumberLabel: UILabel!
    
    @IBOutlet weak var bottomBorder: UIView!
    
    @IBOutlet weak var reviewBtn: UIButton!
    @IBOutlet weak var candidateBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var enrollBtn: UIButton!
    
    
    @IBAction func showReview(_ sender: Any) {
        
    }
    
    @IBAction func storeCandidate(_ sender: Any) {
        
    }
    
    @IBAction func enrollSubject(_ sender: Any) {
        
    }
    
    @IBAction func deleteSubject(_ sender: Any) {
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setSubjectInfoData(name: String, professorName: String, timeInfo: String, room: String, category: String, credit: Int, subjectNum : String){
        
        nameLabel.text = name
        professorNameLabel.text = professorName
        timeInfoLabel.text = timeInfo
        roomLabel.text = room
        courseLabel.text = category
        creditLabel.text = String(credit) + "학점"
        subjectNumberLabel.text = subjectNum
    }
    
    func hideBorder(){
        self.bottomBorder.alpha = 0
    }
    
    func showBorder(){
        self.bottomBorder.alpha = 1
    }
    
    func setCandidateCell(){
        deleteBtn.isEnabled = true
        deleteBtn.alpha = 1
        
        candidateBtn.isEnabled = false
        candidateBtn.alpha = 0
        
    }
    
    func setMainCell(){
        deleteBtn.isEnabled = false
        deleteBtn.alpha = 0
        
        candidateBtn.isEnabled = true
        candidateBtn.alpha = 1
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    


}
