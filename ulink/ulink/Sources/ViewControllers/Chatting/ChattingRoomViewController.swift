import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase



class ChattingRoomViewController: UIViewController {

    
    @IBOutlet weak var sendButton: UIButton!
    
    var uid : String?
    var chatRoomUid : String?
    
    
    @IBOutlet weak var messageTextField: UITextField!
    public var destinationUid : String? // 나중에 내가 채팅할 대상의 uid
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        uid = Auth.auth().currentUser?.uid
        
        sendButton.addTarget(self,action:#selector(createRoom), for:.touchUpInside)
        hideBar()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backToChattingList(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func hideBar(){
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true


        
    }
    
    
    @objc func createRoom(){
        

        let createRoomInfo :Dictionary<String,Any> = [ "users" :[
            uid!: true,
            destinationUid! : true
            ]
        ]
        
        
        if(chatRoomUid == nil){
            // 방 생성 코드
            Database.database().reference().child("chatrooms").childByAutoId().setValue(createRoomInfo)
        }else{

            
            let value: Dictionary<String,Any> = [
                "comments":[
                    "uid": true,
                    "message": messageTextField.text!
                ]
            ]

            Database.database().reference().child("chatrooms").child(chatRoomUid!).child("comments").childByAutoId().setValue(value)
        }
    }
        

    
    func checkChatRoom() {
        Database.database().reference().child("chatrooms").queryOrdered(byChild: "users/"+uid!).queryEqual(toValue: true).observeSingleEvent(of: DataEventType.value)
        { (datasnapshot) in
            for item in datasnapshot.children.allObjects as! [DataSnapshot]{
                self.chatRoomUid = item.key
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
