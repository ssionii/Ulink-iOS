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
    

    
    func setSubjectInfoData(name: String, professorName: String, room: String, category: String, credit: Int, subjectNum : String, day: [Int], dateTime : [String]){
           
           nameLabel.text = name
           professorNameLabel.text = professorName
           timeInfoLabel.text = makeToTimeInfoFormat(day: day, dateTime: dateTime)
           roomLabel.text = room
           courseLabel.text = category
           creditLabel.text = String(credit) + "학점"
            subjectNumberLabel.text = subjectNum
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
