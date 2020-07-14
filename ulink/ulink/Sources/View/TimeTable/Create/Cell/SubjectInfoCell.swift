//
//  SubjectInfoCell.swift
//  ulink
//
//  Created by 양시연 on 2020/07/15.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

protocol SubjectInfoCellDelegate {
    func showReview(idx: Int)
    func deleteSubject(idx: Int)
    func addCandidate(idx: Int)
    func enrollSubject(subjectIdx: Int, subjectItems: [SubjectModel])
}

class SubjectInfoCell: UITableViewCell {
    
     static let identifier: String = "subjectInfoCell"
    
    public var delegate : SubjectInfoCellDelegate?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var professorNameLabel: UILabel!
    @IBOutlet weak var timeInfoLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var subjectNumberLabel: UILabel!
    @IBOutlet weak var subjectBackgroundView: UIView!
    
    @IBOutlet weak var reviewBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var candidateBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var deleteBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var enrollBtnHeight: NSLayoutConstraint!
    
    @IBOutlet weak var reviewBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var candidateBtn: UIButton!
    @IBOutlet weak var enrollBtn: UIButton!
    @IBOutlet weak var bottomBorder: UIView!
    
    private var subjectIdx : Int = 0
    private var nameText = ""
    private var professorNameText = ""
    private var roomText = ""
    private var courseText = ""
    private var creditNum = 0
    private var subjectNumberText = ""
    private var day = [Int]()
    private var dateTime = [String]()
    
    private var num = 0
    
    private var btnHeight = CGFloat(24)
    public var isExpended = false
    
    @IBAction func showReview(_ sender: Any) {
        delegate?.showReview(idx: subjectIdx)
    }
    
    @IBAction func deleteSubject(_ sender: Any) {
        delegate?.deleteSubject(idx: subjectIdx)
    }
    
    @IBAction func addCandidate(_ sender: Any) {
        delegate?.addCandidate(idx: subjectIdx)
        
    }
    
    @IBAction func enrollSubject(_ sender: Any) {
      
        var subjectList = [SubjectModel]()
               
        for (index, dayItem) in day.enumerated() {
                   
            let startTime = dateTime[index].split(separator: "-")[0]
            let endTime = dateTime[index].split(separator: "-")[1]
                   
            let subject = SubjectModel.init(subjectName: nameLabel.text!, roomName: roomLabel.text!, professorName: "", subjectDay: dayItem + 1, startTime: String(startTime), endTime: String(endTime), backgroundColor: 0, day: day, dateTime: dateTime)
                   
            subjectList.append(subject)
        }
        
        delegate?.enrollSubject(subjectIdx: subjectIdx, subjectItems: subjectList)
        
    }
    
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        

    }
    
    func setSubjectInfoData(name: String, professorName: String, room: String, category: String, credit: Int, subjectNum : String, day: [Int], dateTime : [String], num: Int){

        nameLabel.text = name
        professorNameLabel.text = professorName
        timeInfoLabel.text = makeToTimeInfoFormat(day: day, dateTime: dateTime)
        roomLabel.text = room
        courseLabel.text = category
        creditLabel.text = String(credit) + "학점"
        subjectNumberLabel.text = subjectNum
        
        self.day = day
        self.dateTime = dateTime
        self.num = num
    }
    
    private func makeLabel(){
        nameLabel.text = nameText
        professorNameLabel.text = professorNameText
        timeInfoLabel.text = makeToTimeInfoFormat(day: day, dateTime: dateTime)
        roomLabel.text = roomText
        courseLabel.text = courseText
        creditLabel.text = String(creditNum) + "학점"
        subjectNumberLabel.text = subjectNumberText
    }
    
    private func makeToTimeInfoFormat(day : [Int], dateTime : [String]) -> String {
           
        var result = ""
           
        if(day.count > 0){
           for i in 0 ... day.count - 1 {
               switch day[i] {
               case 0:
                   result += "월 "
                   break
               case 1:
                   result += "화 "
                   break
               case 2:
                   result += "수 "
                   break
               case 3:
                   result += "목 "
                   break
               case 4:
                   result += "금 "
                   break
               case 5:
                   result += "토 "
                   break
               default:
                   result += "월 "
                   break
               }
               
               result += dateTime[i].split(separator: "-")[0]
               result += " - "
               result += dateTime[i].split(separator: "-")[1]
               
               if i != day.count - 1 {
                   result += ", "
               }
           }
        }
           
        return result
           
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

        setState(selected)
    }
         
    func setState(_ selected: Bool) {
        if(selected){
            if isExpended {
                smallBtn()
                isExpended = false
            }else{
                bigBtn()
                isExpended = true
            }
        }else {
            smallBtn()
            isExpended = false
        }
    
    }
    
    private func bigBtn(){
        reviewBtnHeight.constant = btnHeight
        deleteBtnHeight.constant = btnHeight
        candidateBtnHeight.constant = btnHeight
        enrollBtnHeight.constant = btnHeight
    }
    
    private func smallBtn(){
        reviewBtnHeight.constant = 0
        deleteBtnHeight.constant = 0
        candidateBtnHeight.constant = 0
        enrollBtnHeight.constant = 0
    }
         
}
