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
    
    @IBOutlet weak var chattingUserCountLabel: UILabel!
    
    override func viewDidLoad(){
        

      
        
        setChattingData()
        
        super.viewDidLoad()

        chattingListTable.dataSource = self
        chattingListTable.delegate = self
        hideNaviBar()
        

        

    }
    
    
    
    
    
    
    
    
    func setChattingData(){
        
        

        
//        Database.database().reference().child("chatrooms").observeSingleEvent(of: DataEventType.value)
        
//        Database.database().reference().child("chatrooms").queryOrderedByKey().queryEqual(toValue: true).observeSingleEvent(of: DataEventType.value)
        
        
        Database.database().reference().child("chatrooms").observeSingleEvent(of: DataEventType.value)
          { (snapshot) in
            
            print("snapshot : \(snapshot)") // 여기는 순서대로 들어옵니다
              
        
            
         //   snapshot 자체는 정상적으로 들어온다
            

                let values = snapshot.value
            

                let dic = values as! [String: [String:Any]] // 여기서 순서가 망가지는거임
            
                // 그러면 어떻게 해야할까
                //
                let dicOrdered = dic.keys.sorted(by: <)
            
            
                print("ordered DIC : \(dicOrdered)")
                
                print("DIC 을 자세히 보자 : \(dic)") // Dictionary로 저장될때 달라지는거임... d여기를 건드려야 한다!


                for index in dic{



                    if (index.value["title"] as? String != nil){


                        let data = ClassModel(name: index.value["title"] as! String, key: index.key , image:.one)

                        
                        print("1: \(index.value["title"] as! String)")
                        self.array_class.append(data)
                        
                                                

                        DispatchQueue.main.async{
                            self.chattingListTable.reloadData()
                            
                        }           // chattingListtable을 다시 reload 해줘서 메인에서 채팅방 목록이 뜨게 해야 한다!!!

                        
                        
                        

                    }
                    
                }
        }
        


        
        

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
        
        
        
        Database.database().reference().child("chatrooms").child(array_class[indexPath.row].key!).child("users").observe(.value) { (datasnapshot) in
            
            
            let dic = datasnapshot.value as! [String:Any]
            
        
        
        
        chattingCell.chattingUserCountLabel.text = "현재 인원 :" + String(dic.count - 1)
        }
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
        
        
        self.array_class = self.array_class.sorted(by: {$0.className! > $1.className!})

//        print("Array : \(array_class)")
        
        chattingRoomViewController.destinationUid = self.array_class[indexPath.row].key
        chattingRoomViewController.tempTitle = self.array_class[indexPath.row].className
//
//                    self.count = 0
//                    print("현재 선택한 row : \(indexPath.row)")
//
//                    for index in dic{
//
//                        if indexPath.row == self.count{
//                            print("uid 전달!!")
//                            print("Current Count : \(self.count)")
//                            print("전달된 key 값 : \(index.key)")
//
//
//                            chattingRoomViewController.chattingRoomTitle = index.value["title"] as? String ?? "title 전달이 안됩니다.."
//                            print("전달된 title 값:  \(index.value["title"] as? String ?? "title 전달이 안됩니다..")")
//                            chattingRoomViewController.destinationUid = index.key
//
//
//                            self.count = self.count + 1
//
//                        }
//                       else{
//                            self.count = self.count + 1
//                        }
//
//                    }
//
//
//
//
//
//                }

        

//        chattingRoomViewController.destinationUid = self.array[indexPath.row].uid
        
        
        
        self.navigationController?.pushViewController(chattingRoomViewController, animated: true)

        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
