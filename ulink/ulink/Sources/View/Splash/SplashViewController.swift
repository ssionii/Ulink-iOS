//
//  SplashViewController.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/15.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit
import GIFImageView

class SplashViewController: UIViewController {  
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    let image = UIImage.animatedImage(named: "io_ulink_splash")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        
        imageView.image = image
        
        
        let seconds = 4.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            
            self.moveToMain()
            
        }
        
        
        
        
        
        
        
        
    }
    
    
    
    
    func moveToMain()
    {
        
        
        
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainLoginView")
        
        
        self.navigationController!.pushViewController(vc, animated: true)
        
        
        
        
    }
    
    
    func checkServerIsOpen(){
        
        
        
        
        
        
        
        
        LoginService.shared.login(id: "qhqo", pwd: "Hello12345") { networkResult in
            switch networkResult {
                
                
            // MARK:- 서버 접속 성공 했을때
            case .success(_,_) :
                
                


                
                
                
                
                
                
                
                
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
                
          
            }
            
            
            
            
            
            
        }
        
    }
    
    
    
    func showAlertMessage()
    {
        
                  let alertViewController = UIAlertController(title: "네트워크 오류", message: "네트워크 상태를 확인해주세요",
                                                              preferredStyle: .alert)
                  let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                  alertViewController.addAction(action)

    }
    
    
}
