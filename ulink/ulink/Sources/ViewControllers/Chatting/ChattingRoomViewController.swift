import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SideMenu


class ChattingRoomViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{


    
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var messageTextField: UITextField!
    var uid : String?
    var chatRoomUid : String?
    
    
    
    var comments : [ChatModel.Comment] = []
    var userModel: UserModel?
    
    
    @IBOutlet weak var chattingTableView: UITableView!

    public var destinationUid : String? // 나중에 내가 채팅할 대상의 uid
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        uid = Auth.auth().currentUser?.uid
        
        sendButton.addTarget(self,action:#selector(createRoom), for:.touchUpInside)

        
        
        hideBar()
        setlabelBadge()

        // Do any additional setup after loading the view.
    }
    
    
    
    
    func setlabelBadge(){
        
        let label = UILabel()
        label.clipsToBounds = true
        label.layer.cornerRadius = label.font.pointSize * 1.2 / 2
//        label.backgroundColor = UIColor.grayColor
//        label.textColor = UIColor.whiteColor()
        label.text = " Some Text ";
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension

    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return comments.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if(self.comments[indexPath.row].uid == uid)
        {
            let view = tableView.dequeueReusableCell(withIdentifier: "myMessageCell", for: indexPath) as! MyMessageCell
            view.label_message.text = self.comments[indexPath.row].message
            view.label_message.numberOfLines = 0
            
            view.layer.borderColor = .none
            
            return view
            
        }
        else
        {
            
            let view = tableView.dequeueReusableCell(withIdentifier: "DestinationMessageCell", for: indexPath) as! destinationMessageCell

            view.label_name.text = userModel?.userName

            view.label_message.text = self.comments[indexPath.row].message

            view.label_message.numberOfLines = 0;
            
            view.layer.borderColor = .none
            
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
    
    @objc func createRoom(){
        
        

        let createRoomInfo : Dictionary<String,Any> = [ "users" : [

            uid!: true,

            destinationUid! :true

            ]

        ]

        if(chatRoomUid == nil){

            self.sendButton.isEnabled = false

            // 방 생성 코드

            Database.database().reference().child("chatrooms").childByAutoId().setValue(createRoomInfo, withCompletionBlock: { (err, ref) in

                if(err == nil){

                    self.checkChatRoom()

                }

            })

        }else{

            let value :Dictionary<String,Any> = [

                "uid" : uid!,

                "message" : messageTextField.text!

            ]

            
    
        
            Database.database().reference().child("chatrooms").child(chatRoomUid!).child("comments").childByAutoId().setValue(value)
            
            messageTextField.text = ""
            
            
            


        }

    
    }

    
    func checkChatRoom() {
        Database.database().reference().child("chatrooms").queryOrdered(byChild: "users/"+uid!).queryEqual(toValue: true).observeSingleEvent(of: DataEventType.value)
        { (datasnapshot) in
            for item in datasnapshot.children.allObjects as! [DataSnapshot]{
                
                if let chatRoomdic = item.value as? [String:AnyObject]{
                    
                    let chatModel = ChatModel(JSON: chatRoomdic)
                    if(chatModel?.users[self.destinationUid!] == true){
                        self.chatRoomUid = item.key
                        self.sendButton.isEnabled = true
                        self.getDestinationInfo()
                    }
                }
                
                
                
            }
        }
    }
    
    
    func getDestinationInfo(){
        
        Database.database().reference().child("users").child(self.destinationUid!).observeSingleEvent(of: DataEventType.value, with: { (datasnapshot) in
            
            
            
            self.userModel?.setValuesForKeys(datasnapshot.value as! [String:Any])
            
            self.getMessageList()
        })
    }
    
    func getMessageList() {
        
        Database.database().reference().child("chatrooms").child(self.chatRoomUid!).child("comments").observe(DataEventType.value, with: { (datasnapshot) in

            self.comments.removeAll()

            

            for item in datasnapshot.children.allObjects as! [DataSnapshot]{

                let comment = ChatModel.Comment(JSON: item.value as! [String:AnyObject])

                self.comments.append(comment!)

            }

            self.chattingTableView.reloadData()
            }
        )}
    
}



class MyMessageCell : UITableViewCell {
    
    @IBOutlet weak var label_message:UILabel!
    
    
    
}


class destinationMessageCell : UITableViewCell {
    @IBOutlet weak var label_message:UILabel!
    @IBOutlet weak var label_name:UILabel!
    
    
    
}


