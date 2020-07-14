//
//  GradeSelectViewController.swift
//  ulink
//
//  Created by SeongEun on 2020/07/14.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class GradeSelectViewController: UIViewController {

    @IBOutlet weak var stringLabel: UILabel!
    @IBOutlet var gradeBtn: [UIButton]!
    @IBOutlet weak var backView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setColor()
        
    }
    
    func setColor(){
        
        backView.layer.cornerRadius = 30
        
        let attributedString = NSMutableAttributedString(string: stringLabel.text ?? "")
        
        attributedString.addAttribute(.foregroundColor, value: UIColor.purpleishBlueThree, range: NSRange(location: 10, length: 4))
        
        for i in 0...4 {
            gradeBtn[i].layer.cornerRadius = 8
            gradeBtn[i].backgroundColor = UIColor.paleGreyThree
            gradeBtn[i].tintColor = UIColor.purpleishBlueThree
        }
    }

}
