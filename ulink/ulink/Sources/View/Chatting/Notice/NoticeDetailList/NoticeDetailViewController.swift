//
//  NoticeDetailViewController.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/08.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class NoticeDetailViewController: UIViewController {

    @IBOutlet weak var noticeDetailTableView: UITableView!
    override func viewDidLoad() {
        
        
        
        
        
        super.viewDidLoad()
        setTableView()
        

    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func hideNaviBar(){
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setTableView(){
        
        
        self.noticeDetailTableView.dataSource = self
        self.noticeDetailTableView.delegate = self
        
    }
    


}


extension NoticeDetailViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                    
        guard let noticeCell = tableView.dequeueReusableCell(withIdentifier: "noticeDetailCell", for: indexPath) as? NoticeDetailTableCell
        else { return UITableViewCell() }
        
        
        
        return noticeCell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        guard let noticeViewController = self.storyboard?.instantiateViewController(identifier: "NoticeEditViewController") as? NoticeEditViewController else { return }
        
        self.navigationController?.pushViewController(noticeViewController, animated: true)
        
    }
    
    
    
}
