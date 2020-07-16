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
       

}
