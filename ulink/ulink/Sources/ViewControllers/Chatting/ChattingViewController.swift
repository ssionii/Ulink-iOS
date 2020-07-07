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
    var count : Int = 0
    var chattingListRef : DatabaseReference!
    var array_class : [ClassModel] = []
    
    override func viewDidLoad(){
        

      
        
        setChattingData()
        
        super.viewDidLoad()

        chattingListTable.dataSource = self
        chattingListTable.delegate = self
        setTableData()
        hideNaviBar()
        

        

    }
    
    
    
    
    
    
    
    
    func setChattingData(){
        
        
            self.ref = Database.database().reference().child("chatrooms")
            
            
            
            
            ref.observeSingleEvent(of: .value) { (snapshot) in

                let values = snapshot.value

                let dic = values as! [String: [String:Any]]

                for index in dic{
                    print(index)
                    print("결과값")



                    if (index.value["title"] as? String != nil){
                        print("제목 : \(index.value["title"] as! String)")  // 여기서 채팅방 목록을 가져온 다음에
                        print("키값 : \(index.key)")
                    
                        
                        let data = ClassModel(name: index.value["title"] as! String, key: index.key , image:.one)
                        
                        self.array_class.append(data)
                        
                        DispatchQueue.main.async{
                            self.chattingListTable.reloadData()
                            
                        }           // chattingListtable을 다시 reload 해줘서 메인에서 채팅방 목록이 뜨게 해야 한다!!!
                        print("현재 배열::::")
                        print(self.array_class)
                        print(self.array_class.count)
                        
                        
                        

                    }
                    
                }
        }
        
        

    }
    
    
    func setTableData() {
        
        
        
        
        
        

            
        self.ref = Database.database().reference()
        let itemref = ref.child("classroom")

        


        let data : [String:Any] = [
            "className": "수업 2",
            "key" : itemref.childByAutoId().key ?? ""
            ]
        
        

        
        


        
        
        itemref.childByAutoId().setValue(data)


        
        
        

        

        
    }
    
    
    func hideNaviBar(){
        
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
}
    
    
    
    
        
   


extension ChattingViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array_class.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let chattingCell = tableView.dequeueReusableCell(withIdentifier: ChattingTableViewCell.identifiers, for: indexPath) as? ChattingTableViewCell else {return UITableViewCell()}
        
        
        
        

        
        
        
        chattingCell.chattingRoomTitle.text = array_class[indexPath.row].className
        
                        

        
        


        chattingCell.chattingNumberBadge.clipsToBounds = true
        chattingCell.chattingNumberBadge.text = "1"
        chattingCell.chattingNumberBadge.layer.cornerRadius = chattingCell.chattingNumberBadge.font.pointSize * 1.6 / 2
        chattingCell.chattingNumberBadge.backgroundColor = .red
        chattingCell.chattingNumberBadge.textColor = .white



        
        

        
        
  
        
        return chattingCell
        
    
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let chattingRoomViewController = self.storyboard?.instantiateViewController(identifier: "ChattingRoomViewController") as? ChattingRoomViewController else { return }
        
//        print("Array : \(array_class)")
        
        
        
        
        
        
        
                
            self.ref = Database.database().reference().child("chatrooms")
                
                
                
                
                ref.observeSingleEvent(of: .value) { (snapshot) in
                    
                    

                    let values = snapshot.value
                    
                    let dic = values as! [String: [String:Any]]
                    
                    
                    
                    self.count = 0
                    print("현재 선택한 row : \(indexPath.row)")
                    
                    for index in dic{
                        
                        if indexPath.row == self.count{
                            print("uid 전달!!")
                            print("Current Count : \(self.count)")
                            chattingRoomViewController.destinationUid = index.key
                            self.count = self.count + 1
                            
                        }
                       else{
                            self.count = self.count + 1
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
