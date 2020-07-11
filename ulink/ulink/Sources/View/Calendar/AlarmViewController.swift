//
//  AlarmViewController.swift
//  ulink
//
//  Created by SeongEun on 2020/07/11.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var alarmTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        alarmTableView.dataSource = self
        alarmTableView.delegate = self
        
        headerView.layer.addBorder(edge: [.bottom], color: UIColor.whiteThree, thickness: 1)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmCell.identifier) as? AlarmCell else {
        return UITableViewCell() }
        
        return cell
    }
}
