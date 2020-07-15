//
//  SplashViewController.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/15.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit
import Lottie
import SwiftGifOrigin

class SplashViewController: UIViewController {  

    
    
    let animationView = AnimationView()
    
    let jeremyGif = UIImage.gifWithName("jeremy")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setup()
    }

    
    func setup(){
        
        animationView.frame = view.bounds
        
        animationView.animation = Animation.named("io_ulink_splash")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
    }





    

}
