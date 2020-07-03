import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase



class ChattingRoomViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {


    
    @IBOutlet weak var sendButton: UIButton!
    
    var uid : String?
    var chatRoomUid : String?
    
    
    
    var comments : [ChatModel.Comment] = []
    
    
    @IBOutlet weak var chattingTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    public var destinationUid : String? // 나중에 내가 채팅할 대상의 uid
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        uid = Auth.auth().currentUser?.uid
        
        sendButton.addTarget(self,action:#selector(createRoom), for:.touchUpInside)
        hideBar()

        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return comments.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let view = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        view.textLabel?.text = self.comments[indexPath.row].message
        
        
        view.layer.borderColor = .none
        
        
        return view
        
    }
    
    
    @IBAction func backToChattingList(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func hideBar(){
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true


        
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
                        self.getMessageList()
                    }
                }
                
                
                
            }
        }
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
