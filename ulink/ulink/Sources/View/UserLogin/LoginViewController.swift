//
//  LoginViewController.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/01.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth
import Alamofire






class LoginViewController: UIViewController {

    @IBOutlet weak var mainLogoImage: UIImageView!
    @IBOutlet weak var viewTopConstraint: NSLayoutConstraint!
    
    let remoteConfig = RemoteConfig.remoteConfig()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
   
    
    
    
//MARK:- Life Cycle 부분
    
        override func viewDidLoad() {
        super.viewDidLoad()
        
        
        try! Auth.auth().signOut()
            
            
            self.navigationController?.navigationBar.isHidden = true
            

            
            
            let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
            
            view.addGestureRecognizer(tap)
        
        
        Auth.auth().addStateDidChangeListener{ (auth, user) in
            if(user != nil){
                print(" login Success ")
                
                
                let storyboard = UIStoryboard(name:"Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "homeTabBarController")
                
                
               
                
                
                self.navigationController!.pushViewController(vc, animated: true)
//                homeview?.modalPresentationStyle = .fullScreen
//                self.present(homeview!, animated: true, completion: nil)
            }
        }
        

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)

        
    }
    
    
    //MARK:- 키보드 액션 부분
    
    @objc func keyboardWillShow(notification : Notification){


        
        
        if let keyboardSize = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            
            self.mainLogoImage.alpha = 0
            self.viewTopConstraint.constant = -15

        

        UIView.animate(withDuration: 0 , animations: {

            self.view.layoutIfNeeded()

        }, completion: {

            (complete) in

            

         

        })

    }
    }
    
    
    @objc func keyboardWillHide(notification: Notification){
        
        self.mainLogoImage.alpha = 1
        self.viewTopConstraint.constant = 80
        
        self.view.layoutIfNeeded()
        
    }
    
    
    
    @objc func dismissKeyBoard(){
        self.view.endEditing(true)
    }
    
    
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        
//        Auth.auth().signIn(withEmail: nameTextField.text!, password: pwTextField.text!) {( user, err) in
//
//            if(err != nil) {
//
//                let alert = UIAlertController(title: "에러", message: err.debugDescription, preferredStyle: UIAlertController.Style.alert)
//
//                alert.addAction(UIAlertAction(title: "확인",style: UIAlertAction.Style.default, handler: nil))
//
//                self.present(alert, animated: true, completion: nil)
//
//            }
//
//        }
        
        
        
        
        
        
        
        
            
            guard let inputID = nameTextField.text else { return }
            guard let inputPWD = pwTextField.text else { return }
            
        
        
            LoginService.shared.login(id: inputID, pwd: inputPWD) { networkResult in
                switch networkResult {
                    
                    
       // MARK:- 서버 접속 성공 했을때
                case .success(let token):
                    guard let token = token as? String else { return }
                    UserDefaults.standard.set(token, forKey: "token")
                    
                    
                     let storyboard = UIStoryboard(name:"Main", bundle: nil)
                     let vc = storyboard.instantiateViewController(withIdentifier: "homeTabBarController")
                     
                     
                    
                     
                     
                     self.navigationController!.pushViewController(vc, animated: true)
                    
                    
                    
        
                case .requestErr(let message):
                    guard let message = message as? String else { return }
                    let alertViewController = UIAlertController(title: "로그인 실패", message: message,
                                                                preferredStyle: .alert)
                    let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                    alertViewController.addAction(action)
                    self.present(alertViewController, animated: true, completion: nil)
                    
                    
                    
                case .pathErr: print("path")
                case .serverErr: print("serverErr")
                case .networkFail: print("networkFail")
                }
            }
        
        
     
            
            
        
    }
    
    
    

    
    

    

//    @objc func logingEvent(){
//
//
//
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
