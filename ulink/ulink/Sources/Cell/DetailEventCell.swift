//
//  DetailEventCell.swift
//  ulink
//
//  Created by SeongEun on 2020/07/06.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class DetailEventCell: UICollectionViewCell {
    static let identifier: String = "detailEventCell"
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet var eventListViews: [UIView]!
    @IBOutlet var eventNameLabels: [UILabel]!
    @IBOutlet var timeLabels: [UILabel]!
    @IBOutlet var categoryLabels: [UIButton]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // design 설정
        self.layer.cornerRadius = 20
        
        clearAll()
    }
    
    func setEventList(date: String, eventName: [String], category: [Int], time: [String]){
        dateLabel.text = date
        for i in 0...eventName.count-1{
            
            eventListViews[i].isHidden = false
            eventNameLabels[i].text = eventName[i]
            if (category[i] == 0) {
                categoryLabels[i].setTitle("시험", for: .normal)
                categoryLabels[i].backgroundColor = UIColor.periwinkleBlue
            } else if (category[i] == 1){
                categoryLabels[i].setTitle("수업", for: .normal)
                categoryLabels[i].backgroundColor = UIColor.robinSEgg
            } else {
                categoryLabels[i].setTitle("과제", for: .normal)
                categoryLabels[i].backgroundColor = UIColor.pink
            }
            timeLabels[i].text = time[i]
        }
    }
    
    func clearAll(){
        for i in 0...eventListViews.count-1 {
            eventListViews[i].layer.cornerRadius = 19
            eventListViews[i].isHidden = true
            categoryLabels[i].layer.cornerRadius = 11
        }
    }
}
