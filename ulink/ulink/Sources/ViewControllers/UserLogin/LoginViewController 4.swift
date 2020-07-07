//
//  LoginViewController.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/01.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit
import TextFieldEffects
import FirebaseDatabase
import Firebase
import FirebaseAuth



class LoginViewController: UIViewController {

    
    let remoteConfig = RemoteConfig.remoteConfig()
    
    @IBOutlet weak var nameTextField: HoshiTextField!
    @IBOutlet weak var pwTextField: HoshiTextField!
    @IBOutlet weak var loginButton: UIButton!
    
        override func viewDidLoad() {
        super.viewDidLoad()
        
        
        try! Auth.auth().signOut()

        
        
        Auth.auth().addStateDidChangeListener{ (auth, user) in
            if(user != nil){
                print(" login Success ")
                let homeview = self.storyboard?.instantiateViewController(withIdentifier: "homeTabBarController")
                homeview?.modalPresentationStyle = .fullScreen
                self.present(homeview!, animated: true, completion: nil)
            }
        }
        

    }
    
    
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: nameTextField.text!, password: pwTextField.text!) {( user, err) in

            if(err != nil) {

                let alert = UIAlertController(title: "에러", message: err.debugDescription, preferredStyle: UIAlertController.Style.alert)

                alert.addAction(UIAlertAction(title: "확인",style: UIAlertAction.Style.default, handler: nil))

                self.present(alert, animated: true, completion: nil)

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
