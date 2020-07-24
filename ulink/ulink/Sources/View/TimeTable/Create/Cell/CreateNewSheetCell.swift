//
//  CreateNewSheetCell.swift
//  ulink
//
//  Created by 양시연 on 2020/07/08.
//  Copyright © 2020 송지훈. All rights reserved.
//

/*

시간표 생성 뷰에서 collectionView의 맨 마지막 cell

*/

import UIKit

class CreateNewSheetCell: UICollectionViewCell {
    
   static let identifier: String = "createNewSheetCell"
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var contentBView: UIView!
    
    @IBOutlet weak var constatn: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentBView.layer.cornerRadius = 30
        constatn.constant = UIScreen.main.bounds.size.width - 22
        
    }
  
    func makeCell(){
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 353, height: 324))
        view.layer.cornerRadius = 30
        view.backgroundColor = UIColor.white
        
        addSubview(view)
    }
}
