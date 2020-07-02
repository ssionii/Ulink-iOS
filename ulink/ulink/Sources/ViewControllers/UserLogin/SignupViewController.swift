//
//  SignupViewController.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/01.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit
import TextFieldEffects
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignupViewController: UIViewController {


    @IBOutlet weak var signupIdTextField: HoshiTextField!
    @IBOutlet weak var signupPwTextField: HoshiTextField!
    @IBOutlet weak var signupNameTextField: HoshiTextField!
    
    
    
    let remoteConfig = RemoteConfig.remoteConfig()
    var color: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signupButtonClicked(_ sender: Any) {
        
        
        Auth.auth().createUser(withEmail: signupIdTextField.text!, password: signupPwTextField.text!) { (user,err) in
            
            
            let uid = user?.user.uid
            
            let values = ["userName":self.signupNameTextField.text!, "uid":Auth.auth().currentUser?.uid]
            
            Database.database().reference().child("users").child(uid!).setValue(values, withCompletionBlock: { (err,ref) in
                
                
                if(err==nil){
                    print("error")
                }
                
            })
            print(uid as Any)
        }
    }
            
            
   

        
    
    
    @IBAction func cancleButtonClicked(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    



}
