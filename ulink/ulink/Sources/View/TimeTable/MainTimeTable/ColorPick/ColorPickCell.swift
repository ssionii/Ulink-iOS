//
//  ColorPickCell.swift
//  ulink
//
//  Created by SeongEun on 2020/07/16.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class ColorPickCell: UICollectionViewCell {
    static let identifier: String = "colorPickCell"
    
    @IBOutlet weak var colorImgView: UIImageView!
    @IBOutlet weak var colorName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        colorImgView.layer.cornerRadius = 8
    }
    
    func setColors(_ colorData: ColorList){
        colorImgView.backgroundColor = colorData.color
        colorName.text = colorData.colorName
    }
    
    func checked(){
        colorImgView.image = UIImage(named: "selectedBg")
    }
}
