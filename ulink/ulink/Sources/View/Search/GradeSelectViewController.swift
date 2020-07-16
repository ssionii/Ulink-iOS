//
//  GradeSelectViewController.swift
//  ulink
//
//  Created by SeongEun on 2020/07/14.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

protocol GradeSelectVCDelegate {
    func selectedGrade(_ grade: Int)
}

class GradeSelectViewController: UIViewController {

    @IBOutlet weak var stringLabel: UILabel!
    @IBOutlet var gradeBtn: [UIButton]!
    @IBOutlet weak var backView: UIView!
    
    var grade: Int = 0
    
    public var delegate: GradeSelectVCDelegate?
    
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
            gradeBtn[i].setTitleColor(UIColor.purpleishBlueThree, for: .normal)
        }
    }
    
    @IBAction func selectGrade1(_ sender: Any) {
        self.delegate?.selectedGrade(1)
        print("호출")
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func selectGrade2(_ sender: Any) {
        self.delegate?.selectedGrade(2)
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func selectGrade3(_ sender: Any) {
        self.delegate?.selectedGrade(3)
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func selectGrade4(_ sender: Any) {
        self.delegate?.selectedGrade(4)
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func selectGrade5(_ sender: Any) {
        self.delegate?.selectedGrade(5)
        self.dismiss(animated: false, completion: nil)
    }
}
