//
//  SubjectInfoCell.swift
//  ulink
//
//  Created by 양시연 on 2020/07/10.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

protocol SubjectInfoCellExpandDelegate {
    func showReview(subjectIdx: Int)
    func storeCandidate(subjectIdx: Int)
    func enrollSubject(tag: Int, subjectIdx: Int, subjectItems: [SubjectModel])
    func deleteSubject(subjectIdx : Int)
}

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
    
    public var delegate : SubjectInfoCellExpandDelegate?
    
    private var subjectIdx : Int = 0
    private var day = [Int]()
    private var dateTime = [String]()
    
    
    @IBAction func showReview(_ sender: Any) {
        
        print("showReview")
        
        delegate?.showReview(subjectIdx: self.subjectIdx)
    }
    
    @IBAction func storeCandidate(_ sender: Any) {
        
        print("stroeCandidate")
        
        delegate?.storeCandidate(subjectIdx: self.subjectIdx)
    }
    
    @IBAction func enrollSubject(_ sender: Any) {
        
        print("showReview")
        
        var subjectList = [SubjectModel]()
        
        for (index, dayItem) in day.enumerated() {
            
            let startTime = dateTime[index].split(separator: "-")[0]
            let endTime = dateTime[index].split(separator: "-")[1]
            
            let subject = SubjectModel.init(subjectName: nameLabel.text!, roomName: roomLabel.text!, subjectDay: TimeTableDay(rawValue: dayItem)!.rawValue, startTime: String(startTime), endTime: String(endTime), backgroundColor: 0)
            
            subjectList.append(subject)
        }
       
        
        
        delegate?.enrollSubject(tag: (sender as! UIButton).tag,  subjectIdx: self.subjectIdx, subjectItems: subjectList)
    }
    
    @IBAction func deleteSubject(_ sender: Any) {
        delegate?.deleteSubject(subjectIdx: self.subjectIdx)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setSubjectInfoData(name: String, professorName: String, room: String, category: String, credit: Int, subjectNum : String, day: [Int], dateTime : [String]){
        
        nameLabel.text = name
        professorNameLabel.text = professorName
        timeInfoLabel.text = makeToTimeInfoFormat(day: day, dateTime: dateTime)
        roomLabel.text = room
        courseLabel.text = category
        creditLabel.text = String(credit) + "학점"
        subjectNumberLabel.text = subjectNum
        self.day = day
        self.dateTime = dateTime
        
    }
    
    private func makeToTimeInfoFormat(day : [Int], dateTime : [String]) -> String {
           
        var result = ""
           
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

    


}
