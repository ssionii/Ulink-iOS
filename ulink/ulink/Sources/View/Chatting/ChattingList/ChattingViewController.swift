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
    
    
    
    var chattingList : [ChattingListData] = []
    var array_class : [ClassModel] = []
    
    @IBOutlet weak var chattingUserCountLabel: UILabel!
    
    override func viewDidLoad(){
        

      

        
        super.viewDidLoad()
        
        


        chattingListTable.dataSource = self
        chattingListTable.delegate = self
        hideNaviBar()
        
        loadUserData()
        
        
        
        
        
        
        
        setChattingData()



        
        showIndicator()



    }
    
      
   
    func showIndicator()
    {

        
        let activityIndicator = ActivityIndicator(view: view, navigationController: self.navigationController, tabBarController: nil)

        activityIndicator.showActivityIndicator(text: "로딩 중")
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            
            activityIndicator.stopActivityIndicator()
            
        
        }

        
        
    }
    

      func loadUserData()
      {
          
          

            LoadChattingListService.shared.getSubjectDetailNotice() { networkResult in
                switch networkResult{
                    
                case .success(let chatList, let numberOfChatrooms):
                    
                    print("SDS")
                    print(chatList)
                    print(numberOfChatrooms)
                    
          
                    
                    guard let chatList = chatList as? [ChattingListData] else { return }
                    guard let numberOfChatrooms = numberOfChatrooms as? Int else {return}
                    


                        for i in 0...numberOfChatrooms - 1 // 채팅방 갯수만큼 리스트에 append 해야 함
                        {
                            let chatroomData = ChattingListData(
                                idx: chatList[i].subjectIdx,
                                name: chatList[i].name,
                                color: chatList[i].color,
                                total: chatList[i].total,
                                current: chatList[i].current)
                            
                            self.chattingList.append(chatroomData)
                        }
                    
                    
                    print("asd")
                    print(self.chattingList)
                    
             
                    
                    
         
                    
                default:
                    print("fail")

                    
                }
                
                
    
                
            }
          
          
      }
          

    
    
    
    
    
    
    func setChattingData(){
        
        

//        Database.database().reference().child("chatrooms").observeSingleEvent(of: DataEventType.value)
        
//        Database.database().reference().child("chatrooms").queryOrderedByKey().queryEqual(toValue: true).observeSingleEvent(of: DataEventType.value)
        
        
        Database.database().reference().child("chatrooms").observeSingleEvent(of: DataEventType.value)
          { (snapshot) in
            
//            print("snapshot : \(snapshot)") // 여기는 순서대로 들어옵니다
//
//
//
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
        
        
        return chattingList.count
//        return array_class.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let chattingCell = tableView.dequeueReusableCell(withIdentifier: ChattingTableViewCell.identifiers, for: indexPath) as? ChattingTableViewCell else {return UITableViewCell()}
        
        
        
        
        
//        Database.database().reference().child("chatrooms").child(array_class[indexPath.row].key!).child("users").observe(.value) { (datasnapshot) in
//
//
//            let dic = datasnapshot.value as! [String:Any]
//
//
//
//
//        chattingCell.chattingUserCountLabel.text = "현재 인원 :" + String(dic.count - 1)
//        }
        
        
        switch chattingList[indexPath.row].color
        {
        case 1:
            
            
            if let img = UIImage(named: "ioClassImgProfile1")
            {
                chattingCell.chattingImage.image = img
            }
            
            break
            
        case 2 :
            
            if let img = UIImage(named: "ioClassImgProfile2")
            {
                chattingCell.chattingImage.image = img
            }
            
            break
            
        case 3 :
            
            if let img = UIImage(named: "ioClassImgProfile3")
            {
                chattingCell.chattingImage.image = img
            }
            
            break
            
        case 4 :
            
            if let img = UIImage(named: "ioClassImgProfile4")
            {
                chattingCell.chattingImage.image = img
            }
            
            break
            
        case 5:
            
            if let img = UIImage(named: "ioClassImgProfile5")
            {
                chattingCell.chattingImage.image = img
            }
            
            break
            
        case 6:
            
            if let img = UIImage(named: "ioClassImgProfile6")
            {
                chattingCell.chattingImage.image = img
            }
            
            break
            
        case 7:
            
            if let img = UIImage(named: "ioClassImgProfile7")
            {
                chattingCell.chattingImage.image = img
            }
            
            break
        case 8:
            
            
            if let img = UIImage(named: "ioClassImgProfile2")
            {
                chattingCell.chattingImage.image = img
            }
            
            break
        case 9:
            
            
            if let img = UIImage(named: "ioClassImgProfile3")
            {
                chattingCell.chattingImage.image = img
            }
            
            break
        case 10:
            
            
            if let img = UIImage(named: "ioClassImgProfile4")
            {
                chattingCell.chattingImage.image = img
            }
            
            break
            
        default:
            
            break
            
            
            
            
            
        }
        
        
        
        
        chattingCell.chattingUserCountLabel.text =
            String(chattingList[indexPath.row].current) +
            "/" +
            String(chattingList[indexPath.row].total)
        
        
        
        
        chattingCell.chattingRoomTitle.text = chattingList[indexPath.row].name
        
        
        
        
        
        
        
        


        chattingCell.chattingNumberBadge.clipsToBounds = true
        chattingCell.chattingNumberBadge.text = "1"
        chattingCell.chattingNumberBadge.layer.cornerRadius = chattingCell.chattingNumberBadge.font.pointSize * 1.6 / 2
        chattingCell.chattingNumberBadge.backgroundColor = .red
        chattingCell.chattingNumberBadge.textColor = .white



        
        

        
        
  
        
        return chattingCell
        
    
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let chattingRoomViewController = self.storyboard?.instantiateViewController(identifier: "ChattingRoomViewController") as? ChattingRoomViewController else { return }
        
        
        self.array_class = self.array_class.sorted(by: {$0.className! < $1.className!})

//        print("Array : \(array_class)")
        
        chattingRoomViewController.destinationUid = "-MBcSPAQKDDOsT2u4UfX"
        chattingRoomViewController.tempTitle = self.chattingList[indexPath.row].name
        chattingRoomViewController.subjectIdx = self.chattingList[indexPath.row].subjectIdx
        
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





struct ActivityIndicator {
    
    let viewForActivityIndicator = UIView()
    let backgroundView = UIView()
    let view: UIView
    let navigationController: UINavigationController?
    let tabBarController: UITabBarController?
    let activityIndicatorView = UIActivityIndicatorView()
    let loadingTextLabel = UILabel()
    
    var navigationBarHeight: CGFloat { return navigationController?.navigationBar.frame.size.height ?? 0.0 }
    var tabBarHeight: CGFloat { return tabBarController?.tabBar.frame.height ?? 0.0 }
    
    func showActivityIndicator(text: String) {
        viewForActivityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 100, height: 100)
        viewForActivityIndicator.center = CGPoint(x: self.view.frame.size.width / 2.0, y: (self.view.frame.size.height - tabBarHeight - navigationBarHeight) / 2.0)
        viewForActivityIndicator.layer.cornerRadius = 10
        viewForActivityIndicator.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.598483033)
        backgroundView.addSubview(viewForActivityIndicator)
        
        activityIndicatorView.center = CGPoint(x: viewForActivityIndicator.frame.size.width / 2.0, y: (viewForActivityIndicator.frame.size.height - tabBarHeight - navigationBarHeight) / 2.0 + 10)
        
        loadingTextLabel.textColor = UIColor.black
        loadingTextLabel.text = text
        loadingTextLabel.font = UIFont(name: "Avenir Light", size: 14)
        loadingTextLabel.sizeToFit()
        loadingTextLabel.center = CGPoint(x: activityIndicatorView.center.x, y: activityIndicatorView.center.y + 40)
        viewForActivityIndicator.addSubview(loadingTextLabel)
        
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.color = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        viewForActivityIndicator.addSubview(activityIndicatorView)
        
        backgroundView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        backgroundView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        
       view.addSubview(backgroundView)
        
        
        
        activityIndicatorView.startAnimating()
    }
    
    func stopActivityIndicator() {
        viewForActivityIndicator.removeFromSuperview()
        activityIndicatorView.stopAnimating()
        activityIndicatorView.removeFromSuperview()
        backgroundView.removeFromSuperview()
    }
}
