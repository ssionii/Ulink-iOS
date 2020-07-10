//
//  NoticeEditViewController.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/09.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class NoticeEditViewController: UIViewController {

    
    @IBAction func BackButtonClicked(_ sender: Any) {
        
        
        
        
        self.navigationController?.popViewController(animated: true)
        
        
        
    }
    @IBAction func EditButtonClicked(_ sender: Any) {
        
    
        
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "NoticeEditModeViewController") as? NoticeEditModeViewController else { return }
        
        nextVC.modalPresentationStyle = .automatic

        
        present(nextVC, animated: true, completion: nil)
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
