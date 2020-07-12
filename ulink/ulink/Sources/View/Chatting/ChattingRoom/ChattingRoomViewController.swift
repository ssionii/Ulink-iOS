import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SideMenu





class ChattingRoomViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{


    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var chattingTitleLabel: UILabel!
    
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
    public var chattingRoomTitle : String?
    var roomTitle : String = ""
    override func viewDidLoad() {
        
        
        setBorder()
          
        
        setTitleLabel()
        super.viewDidLoad()
        uid = Auth.auth().currentUser?.uid
        
        
        
        sendButton.addTarget(self,action:#selector(createRoom), for:.touchUpInside)
        
        chattingTableView.delegate = self
        chattingTableView.dataSource = self

        
        
        hideBar()
        setlabelBadge()
        
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
    
        

    
        
    
    func setTitleLabel(){

 
    }
    
    func setBorder()
    {
        self.chattingTableView.separatorStyle = .none
        self.chattingTableView.backgroundColor = .ulinkGray
        


    }
        
    func loadMessage(){
        
        
    }
    
    
    
    
    func setlabelBadge(){
        
        let label = UILabel()
        label.clipsToBounds = true
        label.layer.cornerRadius = label.font.pointSize * 1.2 / 2
//        label.backgroundColor = UIColor.grayColor
//        label.textColor = UIColor.whiteColor()
        label.text = " Some Text ";
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

            view.labelName.text = userModel?.userName

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
    
    func settingNavigationBar(){
        
        

    }
    
    


        
        
        // 채팅방 생성 코드인데.. 방에 들어온 이상 만들 필요가 있나 싶기도 하고
        @objc func createRoom(){
            
            
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

                }
                self.messageTextField.text = ""
            })
        



        

    
    }
    
    
    

    
    func checkChatRoom() {
        
        
        Database.database().reference().child("chatrooms").queryOrdered(byChild: "users/"+uid!).queryEqual(toValue: true).observeSingleEvent(of: DataEventType.value)
        { (datasnapshot) in
            
            
                print("STAR")
            print(datasnapshot)
            
            
            for item in datasnapshot.children.allObjects as! [DataSnapshot]{

                print("item key 값 : \(item.key)")
                print("destination UID 값 : \(self.destinationUid)")
                
                
                
                
                if self.destinationUid == item.key{     // 현재 내가 들어간 방과 목적지 uid가 일치한다면
                    
                    
                    
                    let values = datasnapshot.value
                    var count : Int = 0
                    let dic = values as! [String: [String:Any]]
                    
                    for index in dic {
                        
                        
                        if self.destinationUid == index.key
                        {

                            
                            
                            
                            print("채팅방 제목")
                            print(index.value["title"] ?? "수업채팅방")
                            
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
                                    
                                    print("현재 메세지 어레이가 이렇습니다")
                                    print(self.messageArray)
                                }
                                
                                
                                
                            }
                            

                            


                            
               
                            
                                
                        }

                        
                    }
                    
                    
                    DispatchQueue.main.async {
                                self.chattingTableView.reloadData()
                            }
                                
                    
                    print("현재 방의 key 값 : \(self.destinationUid ?? "")")
                    print("어찌됐든 접속 성공")
                    
                    print("item 값")
                
                    
                    print(item)

                    
                    

//                    print(item.value(forKey: "comment") as? String ?? "채팅 불러오기 실패여")
                    
                    if let chatRoomdic = item.value as? [String:AnyObject]{
                        print("여기는 들어오시나여?")
  
            
                        if(self.destinationUid != nil){
                            self.chatRoomUid = item.key
                            self.sendButton.isEnabled = true
                            self.getMessageList()
   
                            print("이거 되는거임??")
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

            
            if(noReadCount > 0){
                label?.isHidden = false
                label?.text = String(noReadCount)
                
            }else{
                label?.isHidden = true
            }
        }
    }
    
    func getDestinationInfo(){
        
        Database.database().reference().child("users").child(self.destinationUid!).observeSingleEvent(of: DataEventType.value, with: { (datasnapshot) in
            
            self.userModel = UserModel()

            
            self.userModel?.setValuesForKeys(datasnapshot.value as! [String:Any])
            
            self.getMessageList()
        })
    }
    
    func getMessageList() {
        
        databaseRef = Database.database().reference().child("chatrooms").child(self.chatRoomUid!).child("comments")

        observe =  databaseRef?.observe(.value, with: { (datasnapshot) in

            
        
            self.comments.removeAll()
            
            var readUserDic : Dictionary<String,AnyObject> = [:]
            

//            print("databaseRef")
//            print(self.databaseRef)
//               print("observe")
//            print(self.observe)
//
            print("datasnapshot : \(datasnapshot)")

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
                    
//                    if self.comments.count > 0 {
//                        print("밑으로 스크롤 해~~~")
//                        self.chattingTableView.scrollToRow(at: IndexPath(item: self.comments.count - 1, section: 0), at: .bottom, animated: true)
//                    }
//

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


