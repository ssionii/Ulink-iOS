//
//  SearchViewController.swift
//  ulink
//
//  Created by SeongEun on 2020/07/12.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchView.backgroundColor = UIColor.init(patternImage: UIImage.init(named: "ioMainFiltersettingSearchBg")!)
        
    }
    
    @IBAction func backToTimeTable(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
