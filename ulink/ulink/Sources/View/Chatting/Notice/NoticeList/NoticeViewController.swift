
import UIKit
import Alamofire

class NoticeViewController: UIViewController {

    @IBOutlet weak var noticeScrollView: UIScrollView!
    @IBOutlet weak var hwNoticeTableView: UITableView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var testNoticeTableView: UITableView!
    
    @IBOutlet weak var classNoticeTableView: UITableView!
    
     var hwNoticeInfoArray : [noticeInformation] = []
     var testNoticeInfoArray : [noticeInformation] = []
     var classNoticeInfoArray : [noticeInformation] = []
    
    var subjectIDX : Int = 0 
    var roomtitle : String = ""
    
    override func viewDidLoad() {
        loadNoticeData()
        super.viewDidLoad()
        
    
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load2"), object: nil)
        
 
        

        tableViewStyleSet()

//
        hwNoticeTableView.delegate = self
        hwNoticeTableView.dataSource = self

        
        testNoticeTableView.delegate = self
        testNoticeTableView.dataSource = self
//        testNoticeTableView.register(UITableViewCell.self, forCellReuseIdentifier: "noticeCellTwo")

        
        classNoticeTableView.delegate = self
        classNoticeTableView.dataSource = self
        
        
//        vc.roomtitle = tempTitle ?? "공지"
//        vc.subjectIDX = subjectIdx
        print("=====================================")
        print("현재 공지뷰에 있는 정보")
        print("subject IDX : \(self.subjectIDX)")
        print("과목 이름 : \(self.roomtitle)")
        print("=====================================")
        
        
//        classNoticeTableView.register(UITableViewCell.self, forCellReuseIdentifier: "noticeCellThree")
//


    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let index = hwNoticeTableView.indexPathForSelectedRow {
            hwNoticeTableView.deselectRow(at: index, animated: true)
        }
        
        if let index = testNoticeTableView.indexPathForSelectedRow {
            testNoticeTableView.deselectRow(at: index, animated: true)
        }
        
        
        
        if let index = classNoticeTableView.indexPathForSelectedRow {
            classNoticeTableView.deselectRow(at: index, animated: true)
        }
        
        
    }
    
    
    
    @objc func loadList(notification: NSNotification){
        //load data here
        
        print("LoastList!")
        
        DispatchQueue.main.async {
            self.hwNoticeInfoArray.removeAll()
            self.testNoticeInfoArray.removeAll()
            self.classNoticeInfoArray.removeAll()
            
            self.loadNoticeData()
        }

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
    
    @IBAction func AddNoticeButtonClicked(_ sender: Any) {
        
        
        guard let noticeAddVC = self.storyboard?.instantiateViewController(identifier: "NoticeEditModeViewController") as? NoticeEditModeViewController else {return }
        
        noticeAddVC.modalPresentationStyle = .automatic
        
        noticeAddVC.subjectIdx = subjectIDX
        noticeAddVC.editModeOn = 0 // 0 이 수정이 아닌 추가를 하겠다는 의미!!!
        self.present(noticeAddVC, animated: true, completion: nil)
        
    }
    
    

    @IBAction func homeButtonClicked(_ sender: Any) {
        
        
                self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.selectedIndex = 2
    }
    
    
    func loadNoticeData(){
        
        
        
        NoticeService.shared.getSubjectNotice(subjectIdx: 3) { networkResult in
            switch networkResult{
                
            case .success(let noticeList, let numberOfNotice):
                
      
                
                guard let noticeList = noticeList as? [[SubjectNoticeData]] else { return }
                guard let numberOfNotice = numberOfNotice as? [Int] else {return}
                
                
                if numberOfNotice[0] > 0
                {
                    for i in 0...numberOfNotice[0]-1 // 과제 공지 부분
                    {
                        let noticeData = noticeInformation(title: noticeList[0][i].title , start: noticeList[0][i].startTime, end: noticeList[0][i].endTime, Date: noticeList[0][i].date, idx: noticeList[0][i].noticeIdx
                                                           )
                        
                        self.hwNoticeInfoArray.append(noticeData)
                        
                    }
                }

                
                if numberOfNotice[1] > 0
                {
                    for i in 0...numberOfNotice[1]-1 // 시험 공지 부분
                    {
                        let noticeData = noticeInformation(title: noticeList[1][i].title , start: noticeList[1][i].startTime, end: noticeList[1][i].endTime, Date: noticeList[1][i].date, idx: noticeList[1][i].noticeIdx)
                        
                        self.testNoticeInfoArray.append(noticeData)
                    }
                }

                
                
                if numberOfNotice[2] > 0
                {
                        for i in 0...numberOfNotice[2]-1 // 수업 공지 부분
                        {
                            let noticeData = noticeInformation(title: noticeList[2][i].title , start: noticeList[2][i].startTime, end: noticeList[2][i].endTime, Date: noticeList[2][i].date, idx: noticeList[2][i].noticeIdx)
                            
                            self.classNoticeInfoArray.append(noticeData)
                        }
                    
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
            

            
            guard let noticeCell = tableView.dequeueReusableCell(withIdentifier: "noticeCellTwo", for: indexPath) as? NoticeTableViewCellTwo
                
                else { return UITableViewCell() }
            
            
            
            noticeCell.setInformation(
                Title: testNoticeInfoArray[indexPath.row].title,
                start: testNoticeInfoArray[indexPath.row].startTime,
                end: testNoticeInfoArray[indexPath.row].endTime,
                date: testNoticeInfoArray[indexPath.row].date)
            
            
            
            let bgColorView = UIView()
            bgColorView.backgroundColor = .noticeColorTwoSelected
            noticeCell.selectedBackgroundView = bgColorView
            
            
            noticeCell.layer.borderColor = .none
            
            
            return noticeCell
            
        }
            
        else{
            
            

            
            
            guard let noticeCell = tableView.dequeueReusableCell(withIdentifier: "noticeCellThree", for: indexPath) as? NoticeTableViewCellThree
                else { return UITableViewCell() }
            
            
            
            noticeCell.setInformation(
                Title: classNoticeInfoArray[indexPath.row].title,
                start: classNoticeInfoArray[indexPath.row].startTime,
                end: classNoticeInfoArray[indexPath.row].endTime,
                date: classNoticeInfoArray[indexPath.row].date)
            
            
            
            let bgColorView = UIView()
            bgColorView.backgroundColor = .noticeColorThreeSelected
            noticeCell.selectedBackgroundView = bgColorView
            
            
            noticeCell.layer.borderColor = .none
            
            
            return noticeCell
        }
        
        
        
    }
        
        

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return 45
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        
        guard let noticeDetailVC = self.storyboard?.instantiateViewController(identifier: "NoticeDetailViewController") as? NoticeDetailViewController else {
            return }
        
        
        guard let noticeViewController = self.storyboard?.instantiateViewController(identifier: "NoticeEditViewController") as? NoticeEditViewController else {
            return }
        
        

        if tableView == hwNoticeTableView{
            
            
            
            noticeViewController.noticeIdx = hwNoticeInfoArray[indexPath.row].noticeIdx
            
            noticeViewController.subjectIDX = self.subjectIDX
            
            print("=====================================")
            print("셀을 눌러서 공지 상세보기로 넘기는 정보")
            print("현재 클릭한 공지의 idx : \(hwNoticeInfoArray[indexPath.row].noticeIdx)")
            print("현재 클릭한 공지의 과목 idx : \(self.subjectIDX)")
            print("=====================================")
            noticeViewController.cateogoryIdx = 1
            
            
            
            
        }
            
        else if tableView == testNoticeTableView{
            

            
            noticeDetailVC.subjectIdx = 1 // 과목 idx 부분인데 나중에 채팅창이랑 연동하면서 수정해야함!!
            noticeViewController.noticeIdx = testNoticeInfoArray[indexPath.row].noticeIdx
            noticeViewController.cateogoryIdx = 2
            
            print("=====================================")
            print("셀을 눌러서 공지 상세보기로 넘기는 정보")
            print("현재 클릭한 공지의 idx : \(testNoticeInfoArray[indexPath.row].noticeIdx)")
            print("현재 클릭한 공지의 과목 idx : \(self.subjectIDX)")
            print("=====================================")
            
        }
        
        
        else{
            
            
    
            
            noticeDetailVC.subjectIdx = 1 // 과목 idx 부분인데 나중에 채팅창이랑 연동하면서 수정해야함!!
            noticeViewController.noticeIdx = classNoticeInfoArray[indexPath.row].noticeIdx
            noticeViewController.cateogoryIdx = 3
            
            
            print("=====================================")
            print("셀을 눌러서 공지 상세보기로 넘기는 정보")
            print("현재 클릭한 공지의 idx : \(classNoticeInfoArray[indexPath.row].noticeIdx)")
            print("현재 클릭한 공지의 과목 idx : \(self.subjectIDX)")
            print("=====================================")
            
        }
        
        
        
        

        
        
        
        self.navigationController?.pushViewController(noticeViewController, animated: true)
        


    }
    
    
    
}
