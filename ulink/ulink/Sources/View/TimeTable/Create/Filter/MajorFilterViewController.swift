//
//  MajorFilterViewController.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/14.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class MajorFilterViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterNameView.delegate = self
        filterNameView.dataSource = self
    }

    @IBOutlet weak var filterNameView: UITableView!
    
}


extension MajorFilterViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MajorFilterTableViewCell.identifier)    as? MajorFilterTableViewCell else {
            return UITableViewCell() }
        
        
        cell.setData(name: "바이오시스템학부", check: true)
        
        
        
        return cell
        
        
        
        
        
        
        
        
        
    }

       func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         let headerView = UIView()
        headerView.backgroundColor = .ulinkGray
         return headerView
     }


    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

}


