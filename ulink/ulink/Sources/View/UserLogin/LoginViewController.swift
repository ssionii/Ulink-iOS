//
//  LoginViewController.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/01.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import GIFImageView








class LoginViewController: UIViewController {
    

    @IBOutlet weak var loginImage: UIImageView!
    
    @IBOutlet weak var mainLogoImage: UIImageView!
    @IBOutlet weak var viewTopConstraint: NSLayoutConstraint!
    
    
    let image = UIImage.animatedImage(named: "io_login_img")
     
     
    

    
    @IBOutlet weak var textFieldImage1: UIImageView!
    @IBOutlet weak var textFieldImage2: UIImageView!
    

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
   
    @IBOutlet weak var rememberIDButton: UIButton!
    
    
    @IBOutlet weak var gifHeight: NSLayoutConstraint!
    @IBOutlet weak var gitToLogo: NSLayoutConstraint!
    
    
    
//MARK:- Life Cycle 부분
    
        override func viewDidLoad() {
            
            setHeightForDevice()
            
            checkCount()
        super.viewDidLoad()
        
        
//        try! Auth.auth().signOut()
            
            
            self.navigationController?.navigationBar.isHidden = true
            
            
            self.loginImage.image = image

            
            
            let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
            
            view.addGestureRecognizer(tap)
            
        
        
//        Auth.auth().addStateDidChangeListener{ (auth, user) in
//            if(user != nil){
//                print(" login Success ")
//
//
//                let storyboard = UIStoryboard(name:"Main", bundle: nil)
//                let vc = storyboard.instantiateViewController(withIdentifier: "homeTabBarController")
//
//
//
//
//
//                self.navigationController!.pushViewController(vc, animated: true)
////                homeview?.modalPresentationStyle = .fullScreen
////                self.present(homeview!, animated: true, completion: nil)
//            }
//        }
        

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
            self.viewTopConstraint.constant = 0 //-15

        

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
    
    
    func checkCount() {
        
        if UserDefaults.standard.integer(forKey: "isRememberID") == 1 // 아이디 저장하기로 했다면
        {
            if let idRemember = UIImage(named: "loginBtnCheckboxSelected")
            {
                self.rememberIDButton.setImage(idRemember, for: .normal)
            }
            
            self.nameTextField.text = UserDefaults.standard.string(forKey: "userID")
  
        }
        
        
        else  // 아이디 저장하기 풀려 있을 때
        {
            if let idRemember = UIImage(named: "loginBtnCheckboxUnselected")
            {
                self.rememberIDButton.setImage(idRemember, for: .normal)
            }
        }

    }
    
    
    @IBAction func rememberIdButtonClicked(_ sender: Any) {
        
        
        if UserDefaults.standard.integer(forKey: "isRememberID") == 0   // 저장하지 않기 로 되어있다면,
        {
            if let idRemember = UIImage(named: "loginBtnCheckboxSelected")
            {
                UserDefaults.standard.set(1,forKey: "isRememberID")
                self.rememberIDButton.setImage(idRemember, for: .normal)
            }
        }
        
        else
        {
            if let idRemember = UIImage(named: "loginBtnCheckboxUnselected")
            {
                UserDefaults.standard.set(0,forKey: "isRememberID")
                self.rememberIDButton.setImage(idRemember, for: .normal)
            }
            
        }
        

    }
    func setHeightForDevice()
    {
        
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        
        switch height{
            
        case 450.0 ... 667.0 : // 6 6s 7 8
            
            self.gifHeight.constant = 187
            print(gifHeight.constant)
            break
            
        case 730.0 ... 810.0: // 6s+, 7+ 8+
            self.gifHeight.constant = 187
            print(gifHeight.constant)
            break
            
        case 812.0 ... 890.0: //X, XS
            
            
            self.gifHeight.constant = 220
            print(gifHeight.constant)
            
            break
        
        case 896.0 ... 1000.0:         // XS MAX
            
            self.gifHeight.constant = 240
            print(11)
            print(gifHeight.constant)
            break
            
            
            
            
        
            
            
            
        default:
            break
            
        }
        
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
                case .success(let token,let uid) :

    
                    guard let token = token as? String else { return }
                    UserDefaults.standard.set(token, forKey: "token")
                    
//
                    guard let uid = uid as? String else {return}

//
//                    print("현재 uid : \(uid)")
                    // 유저 uid
                    
                    UserDefaults.standard.set(uid, forKey: "uid")
                    
                    
                    
                    
                    if UserDefaults.standard.integer(forKey: "isRememberID") == 1{ // 저장하기가 눌려있다면,
                        
                        UserDefaults.standard.set(self.nameTextField.text,forKey: "userID")

                    }
                    
                    
                     let storyboard = UIStoryboard(name:"Main", bundle: nil)
                     let vc = storyboard.instantiateViewController(withIdentifier: "homeTabBarController")
                    
                    
                    
                    
                    
                     
                     
                    
                     
                     
                     self.navigationController!.pushViewController(vc, animated: true)
                    
                    
                    
        
                case .requestErr(let message):
                    print("REQUEST ERROR")
                    guard let message = message as? String else { return }
                    let alertViewController = UIAlertController(title: "로그인 실패", message: message,
                                                                preferredStyle: .alert)
                    let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                    alertViewController.addAction(action)
                    self.present(alertViewController, animated: true, completion: nil)
                    
                    
                    
                case .pathErr:
                    let alertViewController = UIAlertController(title: "로그인 실패", message: "로그인 정보를 다시 확인해주세요",
                                                                preferredStyle: .alert)
                    let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                    alertViewController.addAction(action)
                    self.present(alertViewController, animated: true, completion: nil)
                case .serverErr:
                    
                    let alertViewController = UIAlertController(title: "서버 오류", message: "서버 상태를 확인해주세요",
                                                                preferredStyle: .alert)
                    let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                    alertViewController.addAction(action)
                    self.present(alertViewController, animated: true, completion: nil)
                    
                    
                    
                case .networkFail:
                    
                    
                    let alertViewController = UIAlertController(title: "네트워크 오류", message: "네트워크 상태를 확인해주세요",
                                                                preferredStyle: .alert)
                    let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                    alertViewController.addAction(action)
                    self.present(alertViewController, animated: true, completion: nil)
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
    
    
}


