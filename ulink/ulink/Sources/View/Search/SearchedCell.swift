//
//  SeachedCell.swift
//  ulink
//
//  Created by SeongEun on 2020/07/13.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit
import RealmSwift

class SearchedCell: UITableViewCell {
    
    static let identifier: String = "searchedCell"

    @IBOutlet weak var lectureTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //이름
    func set(_ row: Int){
        let realm = try! Realm()
        let savedDates = realm.objects(SearchedListData.self)

        lectureTitleLabel.text = savedDates[row].searched
    }

}
