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
        
        
//        checkServerIsOpen()
        

        let seconds = 3.0
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








        LoginService.shared.login(id: "qhqo", pwd: "Hello123456") { networkResult in
            switch networkResult {


            // MARK:- 서버 접속 성공 했을때
            case .success(_,_) :
                
                break

            case .requestErr(_):
                self.showAlertMessage()

            case .pathErr:
                self.showAlertMessage()
            case .serverErr:

                self.showAlertMessage()

            case .networkFail:
                self.showAlertMessage()


            }





        }

    }



    func showAlertMessage()
    {

                  let alertViewController = UIAlertController(title: "알림", message: "네트워크 연결 상태를 확인해주세요",
                                                              preferredStyle: .alert)
                  let action = UIAlertAction(title: "종료", style: .cancel, handler: nil)
                  alertViewController.addAction(action)
        
        
                present(alertViewController, animated: true)
        

                

    }

    
}
