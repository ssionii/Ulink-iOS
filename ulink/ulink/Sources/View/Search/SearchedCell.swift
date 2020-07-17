//
//  SeachedCell.swift
//  ulink
//
//  Created by SeongEun on 2020/07/13.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit
import RealmSwift

protocol SearchedCellDelegate {
    func didPressDeleteButton(_ tag: Int)
}

class SearchedCell: UITableViewCell {
    
    static let identifier: String = "searchedCell"

    @IBOutlet weak var lectureTitleLabel: UILabel!
    
    var indexPathNum: Int = 0
    
    public var delegate: SearchedCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override var isSelected: Bool {
    didSet {
        let indexPathRow = self.tag
        print(indexPathRow)
     }
    }
    
    //이름
    func set(_ row: Int){
        let realm = try! Realm()
        let savedDates = realm.objects(SearchedListData.self)

        lectureTitleLabel.text = savedDates[row].searched
    }

    @IBAction func deleteCell(_ sender: Any) {
        print(self.indexPathNum)
        self.delegate?.didPressDeleteButton(self.indexPathNum)
    }
}
