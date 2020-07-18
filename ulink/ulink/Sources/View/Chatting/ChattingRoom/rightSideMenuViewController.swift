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
    static let clickSideButton = NSNotification.Name(rawValue: "goToSideMenu")
}

class rightSideMenuViewController: UIViewController {
 
    @IBOutlet weak var subjectTitleLabel: UILabel!
    
    
    @IBOutlet weak var noticeBlock: UIView!
    @IBOutlet weak var photoBlock: UIView!
    
    @IBOutlet weak var QnABlock: UIView!
    @IBOutlet weak var fileBlock: UIView!
    
    var subjectTitle : String = ""
    
    
    
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(setTitleLabel(_:)), name: .goToSideMenu, object: nil)
    }
    
    
    
    
    @objc func setTitleLabel(_ notification: NSNotification) {
        

        
        self.subjectTitleLabel.text = "뭘봐여"
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        
//
//        self.subjectTitleLabel.text = "roomTitle"
//
        
//
//        addObserver()

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


        self.dismiss(animated: true) {
            NotificationCenter.default.post(name: .clickSideButton, object: nil)
        }
    }
    
    
    
    
     override var preferredStatusBarStyle: UIStatusBarStyle {

        return .default

    }
    
    deinit {
        print("aa")
    }


}
