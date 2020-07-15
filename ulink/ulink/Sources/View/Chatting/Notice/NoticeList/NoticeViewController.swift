
import UIKit
import Alamofire

class NoticeViewController: UIViewController {

    @IBOutlet weak var noticeScrollView: UIScrollView!
    @IBOutlet weak var hwNoticeTableView: UITableView!
    
    @IBOutlet weak var testNoticeTableView: UITableView!
    
    @IBOutlet weak var classNoticeTableView: UITableView!
    
     var hwNoticeInfoArray : [noticeInformation] = []
     var testNoticeInfoArray : [noticeInformation] = []
     var classNoticeInfoArray : [noticeInformation] = []

    
    override func viewDidLoad() {
        loadNoticeData()
        super.viewDidLoad()
        

        tableViewStyleSet()

//
        hwNoticeTableView.delegate = self
        hwNoticeTableView.dataSource = self

        
        testNoticeTableView.delegate = self
        testNoticeTableView.dataSource = self
//        testNoticeTableView.register(UITableViewCell.self, forCellReuseIdentifier: "noticeCellTwo")

        
        classNoticeTableView.delegate = self
        classNoticeTableView.dataSource = self
//        classNoticeTableView.register(UITableViewCell.self, forCellReuseIdentifier: "noticeCellThree")
//


    }
    
    @IBAction func goToHwDetail(_ sender: Any) {
        
        // 더보기 탭으로 넘어가야 한다구~~~~~
        
        
        guard let chattingRoomViewController = self.storyboard?.instantiateViewController(identifier: "NoticeDetailViewController") as? NoticeDetailViewController else { return }
        

        chattingRoomViewController.subjectIdx = 1 // 과목 idx 부분인데 나중에 채팅창이랑 연동하면서 수정해야함!!!
               
        
        chattingRoomViewController.categoryIdx = 1

        self.navigationController?.pushViewController(chattingRoomViewController, animated: true)
    }
    
    
    @IBAction func goToTestDetail(_ sender: Any) {
        
        guard let chattingRoomViewController = self.storyboard?.instantiateViewController(identifier: "NoticeDetailViewController") as? NoticeDetailViewController else { return }
        
        
        
        chattingRoomViewController.subjectIdx = 1 // 과목 idx 부분인데 나중에 채팅창이랑 연동하면서 수정해야함!!!

        chattingRoomViewController.categoryIdx = 2
        
        self.navigationController?.pushViewController(chattingRoomViewController, animated: true)
    }
    
    
    @IBAction func goToClassDetail(_ sender: Any) {
        
        guard let chattingRoomViewController = self.storyboard?.instantiateViewController(identifier: "NoticeDetailViewController") as? NoticeDetailViewController else { return }
        
        chattingRoomViewController.subjectIdx = 1 // 과목 idx 부분인데 나중에 채팅창이랑 연동하면서 수정해야함!!!

        
        chattingRoomViewController.categoryIdx = 3

        
        self.navigationController?.pushViewController(chattingRoomViewController, animated: true)
    }
    
    
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

    @IBAction func homeButtonClicked(_ sender: Any) {
        
        
     let homevc = self.storyboard?.instantiateViewController(identifier: "homeTabBarController")
        
        present(homevc!, animated: true, completion: nil)
    }
    
    
    func loadNoticeData(){
        
        
        
        NoticeService.shared.getSubjectNotice(subjectIdx: 1) { networkResult in
            switch networkResult{
                
            case .success(let noticeList, let numberOfNotice):
                
      
                
                guard let noticeList = noticeList as? [[SubjectNoticeData]] else { return }
                guard let numberOfNotice = numberOfNotice as? [Int] else {return}
                
                for i in 0...numberOfNotice[0]-1 // 과제 공지 부분
                {
                    let noticeData = noticeInformation(title: noticeList[0][i].title , start: noticeList[0][i].startTime, end: noticeList[0][i].endTime, Date: noticeList[0][i].date, idx: noticeList[0][i].noticeIdx
                                                       )
                    
                    self.hwNoticeInfoArray.append(noticeData)
                    
                }
                
                for i in 0...numberOfNotice[1]-1 // 시험 공지 부분
                {
                    let noticeData = noticeInformation(title: noticeList[1][i].title , start: noticeList[1][i].startTime, end: noticeList[1][i].endTime, Date: noticeList[1][i].date, idx: noticeList[2][i].noticeIdx)
                    
                    self.testNoticeInfoArray.append(noticeData)
                }
                
                for i in 0...numberOfNotice[2]-1 // 수업 공지 부분
                {
                    let noticeData = noticeInformation(title: noticeList[2][i].title , start: noticeList[2][i].startTime, end: noticeList[2][i].endTime, Date: noticeList[2][i].date, idx: noticeList[2][i].noticeIdx)
                    
                    self.classNoticeInfoArray.append(noticeData)
                }
            
                
                
            default:
                print("fail")

                
            }
            
            
        
            self.hwNoticeTableView.reloadData()
            self.testNoticeTableView.reloadData()
            self.classNoticeTableView.reloadData()
            

            
        }
        

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
    
    

}




extension NoticeViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == hwNoticeTableView{
            return hwNoticeInfoArray.count
            
        }
            
            
        else if tableView == testNoticeTableView{

            
            return testNoticeInfoArray.count
//            return testNoticeInfoArray.count
        }
            
        else{
            return classNoticeInfoArray.count
        }
    }
    
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        
        if tableView == hwNoticeTableView{

            print("hw")



            guard let noticeCell = tableView.dequeueReusableCell(withIdentifier: "noticeCell", for: indexPath) as? NoticeTableViewCell
                else { return UITableViewCell() }



            noticeCell.setInformation(
                title: hwNoticeInfoArray[indexPath.row].title,
                start: hwNoticeInfoArray[indexPath.row].startTime,
                end: hwNoticeInfoArray[indexPath.row].endTime,
                date: hwNoticeInfoArray[indexPath.row].date)



            let bgColorView = UIView()
            bgColorView.backgroundColor = .noticeColorOneSelected
            noticeCell.selectedBackgroundView = bgColorView


            noticeCell.layer.borderColor = .none


            return noticeCell


        }
            
        if tableView == testNoticeTableView{
            
            print("test")
        
            
            guard let noticeCell = tableView.dequeueReusableCell(withIdentifier: "noticeCellTwo", for: indexPath) as? NoticeTableViewCellTwo
                
                else { return UITableViewCell() }
            
            print(testNoticeInfoArray)
            
            
            noticeCell.setInformation(
                Title: testNoticeInfoArray[indexPath.row].title,
                start: testNoticeInfoArray[indexPath.row].startTime,
                end: testNoticeInfoArray[indexPath.row].endTime,
                date: testNoticeInfoArray[indexPath.row].date)
            
            
            
            let bgColorView = UIView()
            bgColorView.backgroundColor = .noticeColorOneSelected
            noticeCell.selectedBackgroundView = bgColorView
            
            
            noticeCell.layer.borderColor = .none
            
            
            return noticeCell
            
        }
            
        else{
            
            
            print("class")

            
            
            guard let noticeCell = tableView.dequeueReusableCell(withIdentifier: "noticeCellThree", for: indexPath) as? NoticeTableViewCellThree
                else { return UITableViewCell() }
            
            
            
            noticeCell.setInformation(
                Title: classNoticeInfoArray[indexPath.row].title,
                start: classNoticeInfoArray[indexPath.row].startTime,
                end: classNoticeInfoArray[indexPath.row].endTime,
                date: classNoticeInfoArray[indexPath.row].date)
            
            
            
            let bgColorView = UIView()
            bgColorView.backgroundColor = .noticeColorOneSelected
            noticeCell.selectedBackgroundView = bgColorView
            
            
            noticeCell.layer.borderColor = .none
            
            
            return noticeCell
        }
        
        
        
    }
        
        


    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        
        guard let noticeDetailVC = self.storyboard?.instantiateViewController(identifier: "NoticeDetailViewController") as? NoticeDetailViewController else { return }
        
        
        guard let noticeViewController = self.storyboard?.instantiateViewController(identifier: "NoticeEditViewController") as? NoticeEditViewController else { return }
        
        

        if tableView == hwNoticeTableView{
            
            
            
            noticeViewController.noticeIdx = hwNoticeInfoArray[indexPath.row].noticeIdx
            
            noticeDetailVC.subjectIdx = 1 // 과목 idx 부분인데 나중에 채팅창이랑 연동하면서 수정해야함!!
            
            print("지금 뭐여")
            print(hwNoticeInfoArray[indexPath.row].noticeIdx)
            noticeViewController.cateogoryIdx = 1
            
            
            
            
        }
            
        else if tableView == testNoticeTableView{
            
            print("지금 뭐여2")
            
            noticeDetailVC.subjectIdx = 1 // 과목 idx 부분인데 나중에 채팅창이랑 연동하면서 수정해야함!!
            noticeViewController.noticeIdx = testNoticeInfoArray[indexPath.row].noticeIdx
            noticeViewController.cateogoryIdx = 2
            
        }
        
        
        else{
            
            
            
            print("지금 뭐여3")
            
            
            noticeDetailVC.subjectIdx = 1 // 과목 idx 부분인데 나중에 채팅창이랑 연동하면서 수정해야함!!
            noticeViewController.noticeIdx = classNoticeInfoArray[indexPath.row].noticeIdx
            noticeViewController.cateogoryIdx = 3
            
        }
        
        
        
        
        let storyBoard = UIStoryboard.init(name: "Chatting", bundle: nil)
        let popupVC = storyBoard.instantiateViewController(withIdentifier: "NoticeEditViewController")
        
        
        
        self.navigationController?.pushViewController(popupVC, animated: true)
        


    }
    
    
    
}
