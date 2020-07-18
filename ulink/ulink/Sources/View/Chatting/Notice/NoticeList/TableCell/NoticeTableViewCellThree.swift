//
//  NoticeTableViewCellThree.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/15.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class NoticeTableViewCellThree: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
     func setInformation(Title:String,start:String,end:String, date : String){
         
         var subtitle : String = ""
         
         
         subtitle = start + " ~ " + end
         
         
         if start == "-1"
         {
             subtitle =  "~ " + end
         }
         
         if end == "-1"
         {
             subtitle = start
         }
         
    
         
        var dateString : String = ""
         let dateArray = date.components(separatedBy: "-")
         dateString =  dateArray[1] + "/" + dateArray[2]
         
         
         title.text = dateString + "  " + Title

         subTitle.text = subtitle
         
     }

}
