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
//    @IBOutlet weak var ContentBackgroundViewConstant: NSLayoutConstraint!
    
    @IBOutlet weak var contentBackgroundView: UIView!
    
    @IBOutlet weak var timeTableWidthConstant: NSLayoutConstraint!
    @IBOutlet weak var weekSpacing: NSLayoutConstraint!
    
    var timeTableIdx : Int = 0
    var subjectList = [SubjectModel]() {
        didSet {
            self.timeTable.reloadData()
        }
    }
    private let daySymbol = [ "월", "화", "수", "목", "금"]
    
    override func awakeFromNib() {
           super.awakeFromNib()
           
        
        setSpacingForDevice()
        contentBackgroundView.layer.cornerRadius = 30
        
//        ContentBackgroundViewConstant.constant = UIScreen.main.bounds.size.width - 22
        timeTableWidthConstant.constant = UIScreen.main.bounds.size.width - 22

           setTimeTable()
        
           timeTable.delegate = self
           timeTable.dataSource = self
       }

    
    
    func setSpacingForDevice()
    {
        
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        
        switch height{
            
        case 450.0 ... 667.0 : // 6 6s 7 8
            
            self.weekSpacing.constant = 53
            
            break
            
        case 730.0 ... 810.0: // 6s+, 7+ 8+
            self.weekSpacing.constant = 53
            break
            
        case 812.0 ... 890.0: //X, XS
            
            //11pro
            self.weekSpacing.constant = 53
            
            break
        
        case 896.0:         // XS MAX
            //11
            self.weekSpacing.constant = 65
            break
           
        default:
            break
            
        }
        
    }
    
    func setCreateTimeTableCell(idx: Int, name: String, subjectList: [SubjectModel]){
        
        timeTableNameLabel.text = name
        self.timeTableIdx = idx
        self.subjectList = subjectList
        
        print("subjectList in cell", subjectList)
        
    }
    
    func setTimeTable(){
        
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        
        switch height{
            
        case 450.0 ... 667.0 : // 6 6s 7 8
            
            timeTable.widthOfTimeAxis = 16
            
        case 730.0 ... 810.0: // 6s+, 7+ 8+
               timeTable.widthOfTimeAxis = 16
            
        case 812.0 ... 890.0: //X, XS
               timeTable.widthOfTimeAxis = 16
        
        case 896.0:         // XS MAX
                timeTable.widthOfTimeAxis = 19
        default:
                timeTable.widthOfTimeAxis = 16
            
        }
        
        
        timeTable.roundCorners([.bottomLeft, .bottomRight], radius: 30)
        
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
