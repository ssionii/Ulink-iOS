//
//  CreateTimeTableCell.swift
//  ulink
//
//  Created by 양시연 on 2020/07/08.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class CreateTimeTableCell: UICollectionViewCell , TimeTableDataSource, TimeTableDelegate {
    
   
    static let identifier: String = "createTimeTableCell"
    
    @IBOutlet weak var timeTableNameLabel: UILabel!
    @IBOutlet weak var timeTable: TimeTable!
    
    var timeTableIdx : Int = 0
    var subjectList = [SubjectModel]() {
        didSet {
            self.timeTable.reloadData()
        }
    }
    private let daySymbol = [ "월", "화", "수", "목", "금"]
    
    override func awakeFromNib() {
           super.awakeFromNib()
           
           setTimeTable()
        
           timeTable.delegate = self
           timeTable.dataSource = self
       }

    
    func setCreateTimeTableCell(idx: Int, name: String, subjectList: [SubjectModel]){
        
        timeTableNameLabel.text = name
        self.timeTableIdx = idx
        self.subjectList = subjectList
        
        print("subjectList in cell", subjectList)
        
    }
    
    func setTimeTable(){
        
        timeTable.roundCorners([.bottomLeft, .bottomRight], radius: 30)
        
        timeTable.widthOfTimeAxis = 18
    }
    
    func timeTable(timeTable: TimeTable, at dayPerIndex: Int) -> String {
        return daySymbol[dayPerIndex]
    }
       
    func numberOfDays(in timeTable: TimeTable) -> Int {
        return daySymbol.count
    }
       
    func subjectItems(in timeTable: TimeTable) -> [SubjectModel] {
        return subjectList
    }
       
     func timeTable(timeTable: TimeTable, selectedSubjectIdx: Int, isSubject : Bool){
        
    }
    
    func timeTableHintCount(hintCount: Int) {
           
    }
       
}

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }

}
