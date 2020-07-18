//
//  NoticeDetailTableCell.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/08.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class NoticeDetailTableCell: UITableViewCell {

    
    
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var noticeLabel: UILabel!
    
    @IBOutlet weak var dDayLabelImage: UIImageView!
    @IBOutlet weak var dDayLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setImage(imageIdx : Int)
    {
        if (imageIdx == 1)
        {
            if let image = UIImage(named: "chattingNoticeLabelBgHw"){
                
                
                dDayLabelImage.image = image
                
                
                
            }
            
        }
            
        else if(imageIdx == 2)
        {
            if let image = UIImage(named: "chattingNoticeLabelExamBg"){
                
                dDayLabelImage.image = image
                
                
                
            }
            
        }
            
        else
        {
            if let image = UIImage(named: "ioChattingNoticClassMoreIcDday"){
                
                dDayLabelImage.image = image
                
                
                
            }
            
        }
    }
    
    
    func setData(title : String, date : String, start : String, end : String)
    {
        var subtitle : String = ""
        var dDay : String = ""
        let dateArray = date.components(separatedBy: "-")
        
        var day : String = ""
        print(dateArray)
        
        day = dateArray[1] + "/" + dateArray[2]

     
        
        
        if start == "-1"
        {
            subtitle =  "~ " + end
        }
        
        if end == "-1"
        {
            subtitle = ""
        }
        
        
        
        let calendar = Calendar.current

        let date = Date()
        var noticeDate = DateComponents()
        
        noticeDate.year = Int(dateArray[0])
        noticeDate.month = Int(dateArray[1])
        noticeDate.day = Int(dateArray[2])
        noticeDate.hour = 0
        noticeDate.minute = 0
        noticeDate.second = 0
        

        let date1 = calendar.startOfDay(for: date)
        let date2 = calendar.startOfDay(for: calendar.date(from: noticeDate)!)

        let components = calendar.dateComponents([.day], from: date1, to: date2)
    
    
        print("components")

        
        if components.day == 0
        {
            dDay = "D-DAY"
        }
        else if components.day! > 0
        {
            dDay = "D-" + String(components.day!)
        }
        else
        {
            dDay = "완료"
        }

        
        
        
        
        
        
        self.infoLabel.text = subtitle
        self.noticeLabel.text = title
        self.dDayLabel.text = dDay
        self.dataLabel.text = day
    }
    


}
