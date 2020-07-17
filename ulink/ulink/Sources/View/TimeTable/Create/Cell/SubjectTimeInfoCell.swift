//
//  SubjectTimeInfoCell.swift
//  ulink
//
//  Created by 양시연 on 2020/07/10.
//  Copyright © 2020 송지훈. All rights reserved.
//
import UIKit

protocol SubjectTimeInfoCellDelegate {

    func didPressDeleteButton(_ tag: Int, message: String?)
    func didPressEditButton(_ idx: Int)
}

class SubjectTimeInfoCell: UITableViewCell {
    
    static let identifier: String = "subjectTimeInfoCell"

    public var delegate: SubjectTimeInfoCellDelegate?
    
    @IBOutlet weak var timeInfoLabel: UILabel!
    @IBOutlet weak var bottomBorder: UIView!
    @IBOutlet weak var trashButton: UIButton!
    
    private var timeIdx = 0
    
    
    @IBAction func toTrash(_ sender: UIButton) {
        
        self.delegate?.didPressDeleteButton(timeIdx, message: timeInfoLabel.text)

    }
    
    public func setTimeInfoText(weekDay: Int, start: String, end: String){
        
        var startTime = start
        var endTime = end
        var resultText = ""
        
        if Int(start.split(separator: ":")[0])! > Int(end.split(separator: ":")[0])! {
            
            startTime = end
            endTime = start
        }
        
        switch weekDay {
        case 0:
            resultText = "월 "
            break
        case 1:
            resultText = "화 "
            break
        case 2:
            resultText = "수 "
            break
        case 3:
            resultText = "목 "
            break
        case 4:
            resultText = "금 "
            break
        case 5:
            resultText = "토 "
            break
        default:
            resultText = "월 "
            break
        }
        
        if startTime.split(separator: ":")[1] == "0" {
            startTime += "0"
        }
        
        if endTime.split(separator: ":")[1] == "0" {
            endTime += "0"
        }
        
        if Int(startTime.split(separator: ":")[0])! < 12 {
            resultText += "오전 " + startTime
        }else if Int(startTime.split(separator: ":")[0])! == 12{
             resultText += "오후 " + startTime
        } else{
            var temp = Int(startTime.split(separator: ":")[0])
            temp = temp! - 12
            
             resultText += "오후 " + String(temp!) + ":" + startTime.split(separator: ":")[1]
        }
        
        resultText += " - "
        
        if Int(endTime.split(separator: ":")[0])! < 12 {
            resultText += "오전 " + endTime
        }else if Int(endTime.split(separator: ":")[0])! == 12{
             resultText += "오후 " + endTime
        }else{
            var temp = Int(endTime.split(separator: ":")[0])
            temp = temp! - 12
            
            resultText +=  "오후 " + String(temp!) + ":" + endTime.split(separator: ":")[1]
        }
        
        timeInfoLabel.text = resultText
        
    }
    
    public func setNum(num: Int){
        self.timeIdx = num
    }
    
    public func removeBottomBorder(){
        bottomBorder.alpha = 0
    }
    
    public func hideTrash(){
        trashButton.alpha = 0
    }
    public func showTrash(){
        trashButton.alpha = 1
    }
    
   override func awakeFromNib() {
        super.awakeFromNib()
    
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapTimeInfoCell)))
    
    }
    
    @objc func tapTimeInfoCell(){
         self.delegate?.didPressEditButton(timeIdx)
    }
}
