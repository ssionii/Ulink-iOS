//
//  NoticeTableViewCell.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/05.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class NoticeTableViewCell: UITableViewCell {
    
    static let hwNoticeIdentifier : String = "noticeCell"
    static let testNoticeIdentifier : String = "testNoticeCell"
    static let classNoticeIdentifier : String = "classNoticeCell"


    @IBOutlet weak var testNoticeTitle: UILabel!
    
    @IBOutlet weak var testNoticeSubTItle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    
    
    func setInformation( title:String,start:String,end:String, date : String){
        
        var subtitle : String = ""
        
        
        subtitle = start + " ~ " + end
        
        
        if start == "-1"
        {
            subtitle =  "~ " + end
        }
        
        if end == "-1"
        {
            subtitle = ""
        }
        
   
        
        testNoticeTitle.text = title
        testNoticeSubTItle.text = subtitle
        
    }

}