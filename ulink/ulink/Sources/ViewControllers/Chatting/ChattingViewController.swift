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



    
class ChattingViewController: UIViewController {
        
    
    @IBOutlet weak var chattingListTable: UITableView!


    
    static let identifiers : String = "ChattingCell"


    var ref : DatabaseReference!
    var array_class : [ClassModel] = []
    
    override func viewDidLoad(){
      
        super.viewDidLoad()
        
        chattingListTable.dataSource = self
        chattingListTable.delegate = self
        setTableData()
        hideNaviBar()
        
//          Database.database().reference().child("users").observe(DataEventType.value, with: { (snapshot) in
//
//
//
//
//
//                self.array.removeAll()
//
//
//
//                for child in snapshot.children {
//
//                    let fchild = child as! DataSnapshot
//
//                    let userModel = UserModel()
//
//
//
//                    userModel.setValuesForKeys(fchild.value as! [String : Any])
//                    print(userModel)
//                    self.array.append(userModel)
//
//
//
//                }
//
//
//
//                DispatchQueue.main.async {
//
//                    self.chattingListTable.reloadData();
//
//                }
//
//
//
//        })
//
//          print(array)
        
        
    }
    
    func setTableData() {
        
        
        
        
        
        

        
        self.ref = Database.database().reference()
        let itemref = ref.child("classroom")

        


        let data : [String:Any] = [
            "className": "수업 1",
            "key" : itemref.childByAutoId().key
            ]
        
        
        let data1 = ClassModel(name: "수업1", key: itemref.childByAutoId().key!,image:.two)
        
        array_class.append(data1)
        
        


        
        
        itemref.setValue(data)


        
        
        

        

        
    }
    
    
    func hideNaviBar(){
        
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
}
    
    
    
    
        
   


extension ChattingViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let chattingCell = tableView.dequeueReusableCell(withIdentifier: ChattingTableViewCell.identifiers, for: indexPath) as? ChattingTableViewCell else {return UITableViewCell()}
        
        
        
        
        self.ref = Database.database().reference()
        
        
        
        
        ref.observeSingleEvent(of: .value) { (snapshot) in
            
            print("접근 1")
            let values = snapshot.value
            
            let dic = values as! [String: [String:Any]]
            for index in dic{
                print(index)
                print("결과값")
                print(index.value["key"])
//                if (index.value["className"] as! String == "수업 1"){
//                    print("접근 성공")
//                    print(index.key)

//                }
                
            }




        }

        
    
        
        
        return chattingCell
        
    
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let chattingRoomViewController = self.storyboard?.instantiateViewController(identifier: "ChattingRoomViewController") as? ChattingRoomViewController else { return }
        
//        print("Array : \(array_class)")
        
        
                
                self.ref = Database.database().reference()
                
                
                
                
                ref.observeSingleEvent(of: .value) { (snapshot) in
                    

                    let values = snapshot.value
                    
                    let dic = values as! [String: [String:Any]]
                    for index in dic{
                        if index.value["key"] != nil {
                            print("uid 전달 성공")
                            chattingRoomViewController.destinationUid = (index.value["key"] as! String)
                        }
                        else{
                            print("key 값이 없어여...")
                        }

                    }




                }

        

//        chattingRoomViewController.destinationUid = self.array[indexPath.row].uid
        
        
        
        self.navigationController?.pushViewController(chattingRoomViewController, animated: true)

        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
