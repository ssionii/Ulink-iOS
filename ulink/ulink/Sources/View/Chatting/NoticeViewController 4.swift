
import UIKit

class NoticeViewController: UIViewController {

    @IBOutlet weak var noticeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func homeButtonClicked(_ sender: Any) {
        
            
        
    }
}



extension NoticeViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "noticeCell", for: indexPath)
        
        cell.layer.borderColor = .none
        
        
        
        
        return cell
    }
    
    
    
}
