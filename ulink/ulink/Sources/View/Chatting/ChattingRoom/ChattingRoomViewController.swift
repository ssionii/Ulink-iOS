import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SideMenu





class ChattingRoomViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{


    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var chattingTitleLabel: UILabel! // 채팅방 제목 라벨
    
    @IBOutlet weak var chattingUserNumberLabel: UILabel! // 현재 채팅방에 몇명 있는지 나타내는 라벨
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageTextField: UITextField!
    var uid : String?
    var chatRoomUid : String?

    
    
    
    var comments : [ChatModel.Comment] = []
    var userModel: UserModel?
    
    var messageArray : [MessageModel] = []
    
    var databaseRef : DatabaseReference?
    var observe : UInt?
    
    
    @IBOutlet weak var chattingTableView: UITableView!

    public var destinationUid : String? // 나중에 내가 채팅할 대상의 uid
    public var tempTitle : String?
    public var chattingRoomTitle : String?

    var roomTitle : String = ""
    
    
    
    
    
    
    //MARK:- Life Cycle 부분
    override func viewDidLoad() {
        
        
        setBorder()
          
        
        super.viewDidLoad()
        uid = Auth.auth().currentUser?.uid
        
        
        
        sendButton.addTarget(self,action:#selector(createRoom), for:.touchUpInside)
        
        chattingTableView.delegate = self
        chattingTableView.dataSource = self

        
        
        hideBar()
//        setChattingRoomInfo()

        checkChatRoom()
        
   
        print("현재 uid : \(self.uid ?? "uid 실패")")
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        
        view.addGestureRecognizer(tap)

        
        
        
        

        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
        databaseRef?.removeObserver(withHandle: observe!)
        
    }
    
    
    //MARK:- 키보드 액션 부분
    
    @objc func keyboardWillShow(notification : Notification){


        
        
        if let keyboardSize = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            
            self.bottomConstraint.constant = keyboardSize.height * -1

        

        UIView.animate(withDuration: 0 , animations: {

            self.view.layoutIfNeeded()

        }, completion: {

            (complete) in

            

            if self.comments.count > 0 {

                self.chattingTableView.scrollToRow(at: IndexPath(item: self.comments.count - 1 , section: 0), at: UITableView.ScrollPosition.bottom, animated: true)

            }

        })

    }
    }
    
    
    @objc func keyboardWillHide(notification: Notification){
        
        self.bottomConstraint.constant = 0
        
        self.view.layoutIfNeeded()
        
    }
    
    
    
    @objc func dismissKeyBoard(){
        self.view.endEditing(true)
    }
    
        


    
    func setBorder()
    {
        self.chattingTableView.separatorStyle = .none
        self.chattingTableView.backgroundColor = .ulinkGray
        


    }
        

    
    

    
    
    // MARK:- table Delegate / Datasource
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        

        
        

        if(messageArray[indexPath.row].uid == uid) // 이게 내 메세지면은
        {
//            let view = tableView.dequeueReusableCell(withIdentifier: "myMessageCell", for: indexPath) as! MyMessageCell
//            view.label_message.text = self.comments[indexPath.row].message
//            view.label_message.numberOfLines = 0
//
//            view.layer.borderColor = .none
//
//            return view
            
            
            let view =  tableView.dequeueReusableCell(withIdentifier: "myMessageCell", for: indexPath) as! MyMessageCell
            view.labelMessage.text = self.messageArray[indexPath.row].message
            
            view.labelMessage.numberOfLines = 0
            
            if let time =
                self.messageArray[indexPath.row].time{
                view.timeLabel.text = time.toDayTime
            }
            
            view.backgroundColor = .ulinkGray
            
            setReadCount(label: view.readCountLabel, position: indexPath.row)
            
            
            


            
            
            
            
            return view
            
        }
        else
        {
            
            let view = tableView.dequeueReusableCell(withIdentifier: "destinationMessageCell", for: indexPath) as! destinationMessageCell

            view.labelName.text = "뜨거운 감자" // 일단 유저 이름 구분은 나중에 해보자

            view.labelMessage.text = self.messageArray[indexPath.row].message
            


            view.labelMessage.numberOfLines = 0;
            
            if let time =
                self.messageArray[indexPath.row].time{
                view.timeLabel.text = time.toDayTime
            }
            view.layer.borderColor = .none
            
              setReadCount(label: view.readCountLabel, position: indexPath.row)
            
            return view

            
        }
        
        
        
        

        
  
        
        
        return UITableViewCell()
        
    }
    
    
    // MARK:-
    
    
    @IBAction func backToChattingList(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.popViewController(animated: true)
    }
    
    

    @IBAction func sideMenuClicked(_ sender : Any) {
        
        let vc = storyboard!.instantiateViewController(withIdentifier: "chattingSideViewController") as! rightSideMenuViewController                    // UIViewController 지정해주고
        let menu = SideMenuNavigationController(rootViewController: vc)     // rootViewController에 넣어준다
        
        menu.presentationStyle = .menuSlideIn  // 보여주는 스타일 지정
        menu.statusBarEndAlpha = .zero          // 상태창 보여주고 싶을 때 설정
        
        
        menu.menuWidth = self.view.frame.width * 0.8 // 80퍼센트 만큼 보여주기
        
        menu.presentDuration = 0.8 //  나타내는거 보여주는데 걸리는 시간
        menu.dismissDuration = 0.8 //  사라지는ep 보여주는데 걸리는 시간
        menu.completionCurve = .easeInOut
        
  


    
        

        
        
        self.present(menu, animated: true, completion: nil)
        

    }
    
    
    

    
    func hideBar(){
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
 


        
        
        // 채팅방 생성 코드인데.. 방에 들어온 이상 만들 필요가 있나 싶기도 하고
        @objc func createRoom(){
            
            
            
            
            
            if (self.messageTextField.text == "" ) // 메세지 비면 전송못하게 해야 혀...
            {
                return
            }
            //MARK:- 버튼 눌렀을 떄 ~~~
            
    

        let createRoomInfo : Dictionary<String,Any> = [ "users" : [

            uid!: true,

            destinationUid! :true

            ]

        ]
        
        
        
        print("uid : \(uid!)")
        print("Roomuid : \(chatRoomUid)")
        print("message : \(messageTextField.text!)")
        

            // 방이 존재한다면..?

            let value :Dictionary<String,Any> = [
                
            
                "uid" : uid!,

                "message" : messageTextField.text!,
                
                "timestamp" : ServerValue.timestamp()

            ]
            
            
            
            

            
            Database.database().reference().child("chatrooms").child(chatRoomUid!).child("comments").childByAutoId().setValue(value, withCompletionBlock: { (err,ref) in
                
                
                
                

                DispatchQueue.main.async {
 
                    self.checkChatRoom()
                    self.chattingTableView.reloadData()
                    
//                    
//                          let indexPath = IndexPath(row: self.chattingTableView.numberOfRows(inSection: 0), section: 0)
//
//                          self.chattingTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)


                }
                

                self.messageTextField.text = ""
            })
        



        

    
    }
    
    
    // 추가적으로 받아와야할 정보?
    // title은 그대로 가져가야 하고
    // 채팅창 메세지는 계속 리프레시 되어야하고,
    
    
    func setChattingRoomInfo() { // 전송 버튼을 누르거나 채팅방에 들어왔을떄 해당함수를 실행시켜서 메세지를 다시 받아와보자
        
           Database.database().reference().child("chatrooms").child(chatRoomUid!).child("users").observe(.value) { (datasnapshot) in
            
            
            
            let dic = datasnapshot.value as! [String:Any]
            
            let numberInChattingRoom = dic.count - 1 // 몇 명 있는지 나타내는 변수
            self.chattingUserNumberLabel.text  = String(numberInChattingRoom)
            
    
        
            self.chattingUserNumberLabel.text = String(numberInChattingRoom)
            
            
            
            
            
            
            
            

            
            
        }
            
            
        
        
        
    }
    
    

    
    func checkChatRoom() {
        
        

        
        Database.database().reference().child("chatrooms").observeSingleEvent(of: DataEventType.value)
        { (datasnapshot) in
            
            
            
            for item in datasnapshot.children.allObjects as! [DataSnapshot]{
                
                
                
                if self.destinationUid == item.key{     // 해당 방의 정보만 불러와야 한다!
                    
                
                    
                    
                    
                    
                    let values = datasnapshot.value
                    
                    var count : Int = 0
                    
                    
                    
                    print("datasnapshot : \(datasnapshot.value)")
                    print("item : \(item)")
                    
                    
                    
                    let dic = values as! [String: [String:Any]] // 애 또 순서 파괴된다...
                    print("dic : \(dic)")
                    
                    
                    for index in dic { // 이걸 두번 도니까 순서 나가는거제..
                        
                    //여기서 무슨 느낌이냐면 바로 먹고 나가야됨
                        
                        
                        if index.value["title"] as? String == self.tempTitle // 같은 제목에 있는 거만 불러와야됨
                        {
                            
                            
                            self.roomTitle = index.value["title"] as? String ?? "수업채팅방"
                            
                            
                            self.chattingTitleLabel.text = self.roomTitle
                            
                            
                            
                            if index.value["comments"] != nil{
                                let message = index.value["comments"] as! [String: [String:Any]]
                                
                                
                                self.messageArray.removeAll()
                                for idx in message
                                {
                                    count = 0
                                    print("idx : \(idx)")
                                    
                                    
                                    let msg = MessageModel()
                                    msg.message = idx.value["message"] as? String ?? ""
                                    msg.time = idx.value["timestamp"] as? Int ?? -1
                                    msg.uid = idx.value["uid"] as? String ?? ""
                                    
                                    let countPeople = idx.value["readUser"] as! Dictionary<String,Any>
                                    
                                    for _ in countPeople
                                    {
                                        count = count + 1
                                    }
                                    
                                    print("현재 읽은 사람 수 : \(count)")
                                    msg.readCount = count
                                    
                                    
                                    self.messageArray.append(msg)
                                    //                                    self.messageArray.append(idx.value["message"] as? String ?? "")
                                    

                                }
                                
                                
                                
                            }
                            

                                


                                
                   
                                
                                    
                            

                            self.chattingTableView.reloadData()
                        }
                        
                        
                        self.messageArray = self.messageArray.sorted(by: {$0.time! < $1.time!}) // 시간순으로 정렬
                        
                        


   
                                    
 
                        

                        
                        

                        
                        if let chatRoomdic = item.value as? [String:AnyObject]{
       
      
                
                            if(self.destinationUid != nil){
                                self.chatRoomUid = item.key
                                self.sendButton.isEnabled = true
                                self.getMessageList()
       

                            }
                        }

                    
                        
     
                    
                    
                    }
                }
            
                
                
                
                
                
                
            }
            
            
        }
        
        
        
    }
    
    
    func setReadCount(label : UILabel?, position : Int?)
    {
        
        let readCount = self.messageArray[position!].readCount
        
        Database.database().reference().child("chatrooms").child(chatRoomUid!).child("users").observe(.value) { (datasnapshot) in
            
            
            let dic = datasnapshot.value as! [String:Any]
            
            let noReadCount = dic.count - readCount! - 1
            
            self.chattingUserNumberLabel.text  = String(dic.count - 1)

            
            if(noReadCount > 0){
                label?.isHidden = false
                label?.text = String(noReadCount)
                
            }else{
                label?.isHidden = true
            }
        }
    }
    
//    func getDestinationInfo(){
//
//        Database.database().reference().child("users").child(self.destinationUid!).observeSingleEvent(of: DataEventType.value, with: { (datasnapshot) in
//
//            self.userModel = UserModel()
//
//
//            self.userModel?.setValuesForKeys(datasnapshot.value as! [String:Any])
//
//            self.getMessageList()
//        })
//    }
    
    func getMessageList() {
        
        databaseRef = Database.database().reference().child("chatrooms").child(self.chatRoomUid!).child("comments")

        observe =  databaseRef?.observe(.value, with: { (datasnapshot) in

            
        
            self.comments.removeAll()
            
            var readUserDic : Dictionary<String,AnyObject> = [:]
            



            for item in datasnapshot.children.allObjects as! [DataSnapshot]{
                
                let key = item.key as String
                

                let comment = ChatModel.Comment(JSON: item.value as! [String:AnyObject])
                
          
                
                comment?.readUsers[self.uid!] = true
                readUserDic[key] = comment?.toJSON() as! NSDictionary

                self.comments.append(comment!)

            }
            
            let nsDic = readUserDic as NSDictionary
            
            datasnapshot.ref.updateChildValues(nsDic as! [AnyHashable : Any]) { (err, ref) in
                    self.chattingTableView.reloadData()
                    
//                    if self.messageArray.count > 0 {
//                        print("밑으로 스크롤 해~~~")
//                        self.chattingTableView.scrollToRow(at: IndexPath(item: self.comments.count - 1, section: 0), at: .bottom, animated: true)
//                    }


            }

      

            
            }
        )}
        
}
    



extension Int{
    
    
    var toDayTime : String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "HH:mm"
        let date = Date(timeIntervalSince1970: Double(self)/1000)
        
        return dateFormatter.string(from: date)
    }
}



class MyMessageCell : UITableViewCell {
    
    @IBOutlet weak var labelMessage:UILabel!
    
    
    @IBOutlet weak var readCountLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    
}


class destinationMessageCell : UITableViewCell {
    @IBOutlet weak var labelMessage:UILabel!
    @IBOutlet weak var labelName:UILabel!
    

    @IBOutlet weak var readCountLabel: UILabel!
    
    
    @IBOutlet weak var timeLabel: UILabel!
}


