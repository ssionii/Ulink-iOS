//
//  ReviewViewController.swift
//  ulink
//
//  Created by SeongEun on 2020/07/13.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet var backGroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backGroundView.backgroundColor = UIColor.purpleishBlueFour
    }
    @IBAction func makeReview(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "이후 릴리즈 단계에서 구현될 기능입니다", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "확인",style: UIAlertAction.Style.default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
}
