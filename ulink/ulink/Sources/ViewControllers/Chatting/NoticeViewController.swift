
import UIKit

class NoticeViewController: UIViewController {

    @IBOutlet weak var noticeTableView: UITableView!
    
    var noticeInfo : [noticeInformation] = []

    
    override func viewDidLoad() {
        setNotice()
        super.viewDidLoad()
        
        
        noticeTableView.delegate = self
        noticeTableView.dataSource = self
   
        
        

    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func homeButtonClicked(_ sender: Any) {
        
            
        
    }
    
    
    private func setNotice(){
        
        let notice1 = noticeInformation(title: "6/13 시험", subtitle:"????")
        let notice2 = noticeInformation(title: "6/22 시험", subtitle:"????")

        let notice3 = noticeInformation(title: "7/18 앱잼 발표", subtitle:"????")
        
        
        noticeInfo = [notice1,notice2,notice3]

        




        
        
    }
}




extension NoticeViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticeInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        guard let noticeCell = tableView.dequeueReusableCell(withIdentifier: NoticeTableViewCell.testNoticeIdentifier, for: indexPath) as? NoticeTableViewCell
        else { return UITableViewCell() }
        
        
        noticeCell.setInformation(title: noticeInfo[indexPath.row].title, subtitle: noticeInfo[indexPath.row].subTitle)
        
        
        
        
            
        noticeCell.layer.borderColor = .none
        
        
        
        return noticeCell
    }
    
    
    
}
