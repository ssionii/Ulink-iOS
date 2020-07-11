
import UIKit

class NoticeViewController: UIViewController {

    @IBOutlet weak var noticeScrollView: UIScrollView!
    @IBOutlet weak var hwNoticeTableView: UITableView!
    
    @IBOutlet weak var testNoticeTableView: UITableView!
    
    @IBOutlet weak var classNoticeTableView: UITableView!
    var hwNoticeInfoArray : [noticeInformation] = []
    var testNoticeInfoArray : [noticeInformation] = []
    var classNoticeInfoArray : [noticeInformation] = []

    
    override func viewDidLoad() {
        setNoticeInfo()
        super.viewDidLoad()
        
        
        tableViewStyleSet()
        
        
        hwNoticeTableView.delegate = self
        hwNoticeTableView.dataSource = self
//        hwNoticeTableView.register(UITableViewCell.self, forCellReuseIdentifier: "noticeCell")
//
//
//        testNoticeTableView.delegate = self
//        testNoticeTableView.dataSource = self
//        testNoticeTableView.register(UITableViewCell.self, forCellReuseIdentifier: "noticeCell")
//
//
//        classNoticeTableView.delegate = self
//        classNoticeTableView.dataSource = self
//        classNoticeTableView.register(UITableViewCell.self, forCellReuseIdentifier: "noticeCell")


        

    }
    
    @IBAction func detailButtonClicked(_ sender: Any) {
        
        // 더보기 탭으로 넘어가야 한다구~~~~~
        
        
        guard let chattingRoomViewController = self.storyboard?.instantiateViewController(identifier: "NoticeDetailViewController") as? NoticeDetailViewController else { return }
        
        self.navigationController?.pushViewController(chattingRoomViewController, animated: true)
    }
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

    @IBAction func homeButtonClicked(_ sender: Any) {
        
        
     let homevc = self.storyboard?.instantiateViewController(identifier: "homeTabBarController")
        
        present(homevc!, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    func tableViewStyleSet(){
        

        
        
        
        hwNoticeTableView.separatorStyle = .none

        hwNoticeTableView.backgroundColor = .noticeColorOne
        
        testNoticeTableView.separatorStyle = .none
        
        testNoticeTableView.backgroundColor = .noticeColorTwo
        
        classNoticeTableView.separatorStyle = .none // 셀 사이 간격 줄 없애기
        
        
        classNoticeTableView.backgroundColor = .noticeColorThree
        
        
        
        
        
        


    }
    
    func stopScroll(){
        
        self.noticeScrollView.isScrollEnabled = false
    }
    
    
    private func setNoticeInfo(){
        
        let hwNotice1 = noticeInformation(title: "6/13 3차 과제", subtitle:"이거 해와야됨")
        let hwNotice2 = noticeInformation(title: "6/18 중간 대체 과제 마감", subtitle:"우야~~~")

        let hwNotice3 = noticeInformation(title: "6/20 레포트 제출 마감", subtitle:"살려줘~~")
        
        let hwNotice4 = noticeInformation(title: "7/1 레포트 제출 2차 마감", subtitle:"늴리리리야~~~")
        
        
        hwNoticeInfoArray = [hwNotice1,hwNotice2,hwNotice3,hwNotice4]
        
        let testNotice1 = noticeInformation(title:"안녕~~",subtitle: "hellO")
        
        testNoticeInfoArray = [testNotice1]
        
        let classNotice1 = noticeInformation(title:"????", subtitle: "asdqwcz")
        
        classNoticeInfoArray = [classNotice1]
        

        
        
        
        




        
        
    }
}




extension NoticeViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == hwNoticeTableView{
            return hwNoticeInfoArray.count

        }
        
        
        else if tableView == testNoticeTableView{
            return testNoticeInfoArray.count
        }
        
        else{
            return classNoticeInfoArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        
        
        
//
//        if tableView == hwNoticeTableView{

            
            guard let noticeCell = tableView.dequeueReusableCell(withIdentifier: "noticeCell", for: indexPath) as? NoticeTableViewCell
            else { return UITableViewCell() }
            
            noticeCell.setInformation(title: hwNoticeInfoArray[indexPath.row].title, subtitle: hwNoticeInfoArray[indexPath.row].subTitle)
            
            
            
        let bgColorView = UIView()
            bgColorView.backgroundColor = .noticeColorOneSelected
            noticeCell.selectedBackgroundView = bgColorView


            noticeCell.layer.borderColor = .none
            
            
            return noticeCell
            
            
        }
//
//        else if tableView == testNoticeTableView{
//
//
//            guard let noticeCell = tableView.dequeueReusableCell(withIdentifier: "noticeCell", for: indexPath) as? NoticeTableViewCell
//            else { return UITableViewCell() }
//
//            noticeCell.setInformation(title: testNoticeInfoArray[indexPath.row].title, subtitle: testNoticeInfoArray[indexPath.row].subTitle)
//
//
//            noticeCell.layer.borderColor = .none
//
//
//            return noticeCell
//
//        }
//
//        else{
//
//
//            guard let noticeCell = tableView.dequeueReusableCell(withIdentifier:"noticeCell", for: indexPath) as? NoticeTableViewCell
//            else { return UITableViewCell() }
//
//
//            noticeCell.setInformation(title: classNoticeInfoArray[indexPath.row].title, subtitle: classNoticeInfoArray[indexPath.row].subTitle)
//
//            noticeCell.layer.borderColor = .none
//
//
//             return noticeCell
//        }
//
//
//
        
        
        


    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        

        
        let storyBoard = UIStoryboard.init(name: "Chatting", bundle: nil)
        let popupVC = storyBoard.instantiateViewController(withIdentifier: "NoticeEditViewController")
        
        
        
        self.navigationController?.pushViewController(popupVC, animated: true)
        


    }
    
    
    
}
