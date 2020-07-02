import UIKit
import Firebase


class ChattingRoomViewController: UIViewController {

    
    @IBOutlet weak var sendButton: UIButton!
    
    
    public var destinationUid : String? // 나중에 내가 채팅할 대상의 uid
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        
        sendButton.addTarget(self,action:#selector(createRoom), for:.touchUpInside)
        hideBar()

        // Do any additional setup after loading the view.
    }
    

    
    
    func hideBar(){
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    
    @objc func createRoom(){
        
        let createRoomInfo = [
            "uid":Auth.auth().currentUser?.uid,
            "destinationUid" : destinationUid
        ]
        
        Database.database().reference().child("chatrooms").childByAutoId().setValue(createRoomInfo)
        
        
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
