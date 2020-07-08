//
//  ChattingViewController.swift
//  ulink
//
//  Created by 송지훈 on 2020/06/30.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import FirebaseDatabase



class ChattingViewController:    UIViewController {
    
    
    @IBOutlet weak var chattingListTable: UITableView!
    var array : [UserModel] = []
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        chattingListTable.dataSource = self
        chattingListTable.delegate = self
        
        
    
   
    }
    
}
    
    
    
    
        
   


extension ChattingViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let chattingCell = tableView.dequeueReusableCell(withIdentifier: ChattingTableViewCell.identifiers, for: indexPath) as? ChattingTableViewCell else {return UITableViewCell()}
        
        
        
        return chattingCell
        
    
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let chattingRoomViewController = self.storyboard?.instantiateViewController(identifier: "ChattingRoomViewController") as? ChattingRoomViewController else { return }
        
        
//        chattingRoomViewController.destinationUid = self.array[indexPath.row].uid
        
        
        
        self.navigationController?.pushViewController(chattingRoomViewController, animated: true)

        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
