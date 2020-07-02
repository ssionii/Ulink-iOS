//
//  TimeTableViewController.swift
//  ulink
//
//  Created by 양시연 on 2020/07/02.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class TimeTableViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var timeTableView: TimeTable!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setBackgroundView()
        setTimeTableView()
    }
    
    private func setBackgroundView(){
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.mainBackgroundTop.cgColor, UIColor.mainBackgroundBottom.cgColor]
        
        backgroundView.layer.insertSublayer(gradient, at: 0)
    }
    
    private func setTimeTableView(){
        timeTableView.layer.cornerRadius = 10
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
