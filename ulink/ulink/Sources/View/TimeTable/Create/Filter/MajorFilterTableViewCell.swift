//
//  MajorFilterTableViewCell.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/14.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class MajorFilterTableViewCell: UITableViewCell {

    
    static let identifier : String = "filterCell"
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var myMajorButton: UIButton!
    @IBOutlet weak var checkButtonImage: UIButton!
    
    
    var filterName : String = ""
    var isChecked : Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    
    func setData(name : String, check: Bool)
    {
        self.categoryNameLabel.text = name
        if check{ // 체크 되어있다면 (참)
            
            if let img = UIImage(named: "ioMainMajorsettingBtnRoundSelected")
            {
                
                self.checkButtonImage.setImage(img, for: .normal)
                
            }
        }
        else{   //체크가 풀려있다면 (거짓)
            
            
            if let img = UIImage(named: "ioMajorsettingBtnRoundUnselected")
            {
                
                self.checkButtonImage.setImage(img, for: .normal)
                
            }
            
            
        }
    }
    
    
    
    @IBAction func checkButtonClicked(_ sender: Any) {
    
        if self.isChecked
        {
            if let img = UIImage(named: "ioMajorsettingBtnRoundUnselected")
            {
                
                self.checkButtonImage.setImage(img, for: .normal)
                
            }
            
            self.isChecked = false
            
        }
        
        
        else
        {
            if let img = UIImage(named: "ioMainMajorsettingBtnRoundSelected")
            {
                
                self.checkButtonImage.setImage(img, for: .normal)
                
            }
            
            self.isChecked = true
            
            
        }

    
    }
    
    
    
    
    
    
    
    

}
