//
//  MyPageViewController.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/13.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController {


    @IBOutlet weak var myInfoContainerImage: UIImageView!
    @IBOutlet weak var myInfoContainerView: UIView!
    

    @IBOutlet weak var statusMessageLabel: UILabel!
    
    
 
    @IBAction func schoolButtonClicked(_ sender: Any) {
        

        releasePart()
    }
    
    
    @IBAction func infoButtonClicked(_ sender: Any) {
        

        
        releasePart()
    }
    

    @IBAction func messageButtonClicked(_ sender: Any) {
        

        
        releasePart()
    }
    
    
    
    @IBAction func questionButtonClicked(_ sender: Any) {
        

        releasePart()
    }
    
    
    
    
    
    
    @IBAction func cameraButtonClicked(_ sender: Any) {
        
        
        releasePart()
    }
    
    @IBAction func chargeButtonClicked(_ sender: Any) {
        
        
        
        releasePart()
    }

    @IBAction func statusChangeButtonClicked(_ sender: Any) {
        

        
        let alert = UIAlertController(title: "상태 메세지 설정", message: "textField", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default) { (ok) in
            
            self.statusMessageLabel.text = alert.textFields?[0].text
            
        }
        
        let cancel = UIAlertAction(title: "cancel", style: .cancel) { (cancel) in
            
            //code
            
        }
        
        alert.addAction(cancel)
        
        alert.addAction(ok)
        
        alert.addTextField { (myTextField) in   
            myTextField.placeholder = "상태 메시지를 입력해주세요"
        }
        
        self.present(alert, animated: true, completion: nil)
        
        

        
    }
    
    
    
    override func viewDidLoad() {
        setShadow()

        
        
        super.viewDidLoad()
        



        // Do any additional setup after loading the view.
    }
    
    

    func setShadow() {
        
        
        self.myInfoContainerImage.layer.shadowColor = UIColor.black.cgColor
        
        self.myInfoContainerImage.layer.masksToBounds = false
        self.myInfoContainerImage.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.myInfoContainerImage.layer.shadowRadius = 3
        self.myInfoContainerImage.layer.shadowOpacity = 0.3 // alpha값입
        
        
        
        
        self.myInfoContainerView.layer.shadowColor = UIColor.black.cgColor
        
        self.myInfoContainerView.layer.masksToBounds = false
        self.myInfoContainerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.myInfoContainerView.layer.shadowRadius = 8
        self.myInfoContainerView.layer.shadowOpacity = 0.3 // alpha값입
        
        
        


    }
    
    
    @objc func releasePart() {
        
        print("???")
        
        let alert = UIAlertController(title: "", message: "이후 릴리즈 단계에서 구현될 기능입니다", preferredStyle: UIAlertController.Style.alert)

           alert.addAction(UIAlertAction(title: "확인",style: UIAlertAction.Style.default, handler: nil))

           self.present(alert, animated: true, completion: nil)
    }

    
}
