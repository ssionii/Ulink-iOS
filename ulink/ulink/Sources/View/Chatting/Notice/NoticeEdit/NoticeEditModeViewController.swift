//
//  NoticeEditModeViewController.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/09.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class NoticeEditModeViewController: UIViewController {

    @IBOutlet weak var textAreaBorder: UIView!
    @IBAction func closeButtonClicked(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setBorder()

    }
    

    
    
    func setBorder(){
    }

}
