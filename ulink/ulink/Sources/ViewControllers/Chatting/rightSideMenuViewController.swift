//
//  rightSideMenuViewController.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/04.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit
import SideMenu


class rightSideMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()

        // Do any additional setup after loading the view.
    }
    
    
    func hideNavigationBar(){
        
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
     override var preferredStatusBarStyle: UIStatusBarStyle {

        return .default

        }





    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
