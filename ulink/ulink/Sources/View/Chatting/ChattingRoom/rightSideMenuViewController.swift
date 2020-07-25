////
////  rightSideMenuViewController.swift
////  ulink
////
////  Created by 송지훈 on 2020/07/04.
////  Copyright © 2020 송지훈. All rights reserved.
////
//
//import UIKit
//import SideMenu
//
//
//extension NSNotification.Name {
//    static let clickSideButton = NSNotification.Name(rawValue: "goToSideMenu")
//}
//
//class rightSideMenuViewController: UIViewController {
// 
//    @IBOutlet weak var subjectTitleLabel: UILabel!
//    
//    
//    @IBOutlet weak var noticeBlock: UIView!
//    @IBOutlet weak var photoBlock: UIView!
//    
//    @IBOutlet weak var QnABlock: UIView!
//    @IBOutlet weak var fileBlock: UIView!
//    
//    var subjectTitle : String = ""
//    
//    
//    
//    
//    private func addObserver() {
//        NotificationCenter.default.addObserver(self, selector: #selector(setTitleLabel(_:)), name: .goToSideMenu, object: nil)
//    }
//    
//    
//    
//    
//    @IBAction func setButtonClicked(_ sender: Any) {
//        
//        let alert = UIAlertController(title: "", message: "이후 릴리즈 단계에서 구현될 기능입니다", preferredStyle: UIAlertController.Style.alert)
//
//        alert.addAction(UIAlertAction(title: "확인",style: UIAlertAction.Style.default, handler: nil))
//
//        self.present(alert, animated: true, completion: nil)
//    }
//    
//    
//    @IBAction func setAlarmclicked(_ sender: Any) {
//        
//        let alert = UIAlertController(title: "", message: "이후 릴리즈 단계에서 구현될 기능입니다", preferredStyle: UIAlertController.Style.alert)
//
//        alert.addAction(UIAlertAction(title: "확인",style: UIAlertAction.Style.default, handler: nil))
//
//        self.present(alert, animated: true, completion: nil)
//    }
//    
//    
//    @IBAction func exitButtonClicked(_ sender: Any) {
//        
//        let alert = UIAlertController(title: "", message: "이후 릴리즈 단계에서 구현될 기능입니다", preferredStyle: UIAlertController.Style.alert)
//
//        alert.addAction(UIAlertAction(title: "확인",style: UIAlertAction.Style.default, handler: nil))
//
//        self.present(alert, animated: true, completion: nil)
//    }
//    
//    
//    
//    
//    
//    
//    
//    @objc func setTitleLabel(_ notification: NSNotification) {
//        
//
//        
//        self.subjectTitleLabel.text = "뭘봐여"
//    }
//    
//
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        hideNavigationBar()
//        
////
////        self.subjectTitleLabel.text = "roomTitle"
////
//        
////
////        addObserver()
//
//        addGesture()
//        
//
//
//    }
//    
//    
//    func hideNavigationBar(){
//        
//        
//        self.navigationController?.navigationBar.isHidden = true
//    }
//    
//    
//    func addGesture(){
//        
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(goToNoticePage(sender:)))
//        self.noticeBlock.addGestureRecognizer(gesture)
//        
//        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(alertMessage(sender:)))
//        
//        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(alertMessage(sender:)))
//        
//        let gesture3 = UITapGestureRecognizer(target: self, action: #selector(alertMessage(sender:)))
//        
//        self.fileBlock.addGestureRecognizer(gesture1)
//        self.photoBlock.addGestureRecognizer(gesture2)
//        self.QnABlock.addGestureRecognizer(gesture3)
//        
//        
//    }
//    
//    
//    
//    @objc func alertMessage(sender:UIGestureRecognizer)
//    {
//        let alert = UIAlertController(title: "", message: "이후 릴리즈 단계에서 구현될 기능입니다", preferredStyle: UIAlertController.Style.alert)
//
//        alert.addAction(UIAlertAction(title: "확인",style: UIAlertAction.Style.default, handler: nil))
//
//        self.present(alert, animated: true, completion: nil)
//    }
//    
//    
//    
//    
//    
//    @objc func goToNoticePage(sender:UIGestureRecognizer)
//    {
//
//        NotificationCenter.default.post(name: .clickSideButton, object: nil)
//        self.dismiss(animated: true) {
////            NotificationCenter.default.post(name: .clickSideButton, object: nil)
//        }
//    }
//    
//    
//    
//    
//     override var preferredStatusBarStyle: UIStatusBarStyle {
//
//        return .default
//
//    }
//    
//    deinit {
//        print("aa")
//    }
//
//
//}
