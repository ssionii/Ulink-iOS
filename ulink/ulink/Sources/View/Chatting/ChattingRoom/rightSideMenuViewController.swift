//
//  rightSideMenuViewController.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/04.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit
import SideMenu


extension NSNotification.Name {
    static let clickSideButton = NSNotification.Name(rawValue: "clickSideButton")
}

class rightSideMenuViewController: UIViewController {

    @IBOutlet weak var noticeBlock: UIView!
    @IBOutlet weak var photoBlock: UIView!
    
    @IBOutlet weak var QnABlock: UIView!
    @IBOutlet weak var fileBlock: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        
        
        addGesture()
        


    }
    
    
    func hideNavigationBar(){
        
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    func addGesture(){
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(goToNoticePage(sender:)))
        self.noticeBlock.addGestureRecognizer(gesture)
        
        
    }
    
    
    @objc func goToNoticePage(sender:UIGestureRecognizer)
    {
        NotificationCenter.default.post(name: .clickSideButton, object: nil)

        self.dismiss(animated: true) {
//            NotificationCenter.default.post(name: .clickSideButton, object: nil)
        }
    }
    
    
    
    
     override var preferredStatusBarStyle: UIStatusBarStyle {

        return .default

    }
    
    deinit {
        print("aa")
    }


}
