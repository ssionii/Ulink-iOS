
import UIKit
import Alamofire



extension UITableView {
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        // The only tricky part is here:
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}


class NoticeViewController: UIViewController {

    @IBOutlet weak var noticeScrollView: UIScrollView!
    @IBOutlet weak var hwNoticeTableView: UITableView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var testNoticeTableView: UITableView!
    
    @IBOutlet weak var classNoticeTableView: UITableView!
    
    @IBOutlet weak var hideView1: UIView!
    
    @IBOutlet weak var hideView2: UIView!
    
    @IBOutlet weak var hideView3: UIView!
    
    
    var hwNoticeInfoArray : [noticeInformation] = []
     var testNoticeInfoArray : [noticeInformation] = []
     var classNoticeInfoArray : [noticeInformation] = []
    
    var subjectIDX : Int = 0 
    var roomtitle : String = ""
    
    override func viewDidLoad() {
        loadNoticeData()
        super.viewDidLoad()
        
        
        self.titleLabel.text = roomtitle + " 공지"
        
    
        
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
         print("**********************************")
        print("공지 메인뷰에서 데이터 불러오기 함수 호출!!!!")
        print("**********************************")

        
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
        

        chattingRoomViewController.subjectIdx = self.subjectIDX // 과목 idx 부분인데 나중에 채팅창이랑 연동하면서 수정해야함!!!
               
        
        chattingRoomViewController.categoryIdx = 1
        
        
        print("=====================================")
        print("더보기를 눌러서 공지 목록 뷰로 넘기는 정보")
        print("현재 클릭한 공지의 과목 idx : \(self.subjectIDX)")
        print("=====================================")
        
        

        self.navigationController?.pushViewController(chattingRoomViewController, animated: true)
    }
    
    
    @IBAction func goToTestDetail(_ sender: Any) {
        
        guard let chattingRoomViewController = self.storyboard?.instantiateViewController(identifier: "NoticeDetailViewController") as? NoticeDetailViewController else { return }
        
        
        
        chattingRoomViewController.subjectIdx = self.subjectIDX // 과목 idx 부분인데 나중에 채팅창이랑 연동하면서 수정해야함!!!

        chattingRoomViewController.categoryIdx = 2
        
        
        print("=====================================")
        print("더보기를 눌러서 공지 목록 뷰로 넘기는 정보")
        print("현재 클릭한 공지의 과목 idx : \(self.subjectIDX)")
        print("=====================================")
           
        
        self.navigationController?.pushViewController(chattingRoomViewController, animated: true)
    }
    
    
    @IBAction func goToClassDetail(_ sender: Any) {
        
        guard let chattingRoomViewController = self.storyboard?.instantiateViewController(identifier: "NoticeDetailViewController") as? NoticeDetailViewController else { return }
        
        chattingRoomViewController.subjectIdx = self.subjectIDX // 과목 idx 부분인데 나중에 채팅창이랑 연동하면서 수정해야함!!!

        
        chattingRoomViewController.categoryIdx = 3
        
        
        print("=====================================")
        print("더보기를 눌러서 공지 목록 뷰로 넘기는 정보")
        print("현재 클릭한 공지의 과목 idx : \(self.subjectIDX)")
        print("=====================================")
           

        
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
        
        
        
        NoticeService.shared.getSubjectNotice(subjectIdx: self.subjectIDX) { networkResult in
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
                else
                {
                    self.hideView1.isHidden = false
                }

                
                if numberOfNotice[1] > 0
                {
                    for i in 0...numberOfNotice[1]-1 // 시험 공지 부분
                    {
                        let noticeData = noticeInformation(title: noticeList[1][i].title , start: noticeList[1][i].startTime, end: noticeList[1][i].endTime, Date: noticeList[1][i].date, idx: noticeList[1][i].noticeIdx)
                        
                        self.testNoticeInfoArray.append(noticeData)
                    }
                }
                else
                {
                    self.hideView2.isHidden = false
                }

                
                
                if numberOfNotice[2] > 0
                {
                        for i in 0...numberOfNotice[2]-1 // 수업 공지 부분
                        {
                            let noticeData = noticeInformation(title: noticeList[2][i].title , start: noticeList[2][i].startTime, end: noticeList[2][i].endTime, Date: noticeList[2][i].date, idx: noticeList[2][i].noticeIdx)
                            
                            self.classNoticeInfoArray.append(noticeData)
                        }
                    
                }
                else
                {
                    self.hideView3.isHidden = false
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


            if hwNoticeInfoArray.count == 0
            {
                self.hideView1.isHidden = false
            }

            else {
                self.hideView1.isHidden = true
            }

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
            
            
            if testNoticeInfoArray.count == 0
            {
                self.hideView2.isHidden = false
            }

            else {
                self.hideView2.isHidden = true
            }
            

            
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
            
            
            if classNoticeInfoArray.count == 0
            {
                self.hideView3.isHidden = false
            }

            else {
                self.hideView3.isHidden = true
            }
            
            

            
            
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
            

            
            noticeDetailVC.subjectIdx = self.subjectIDX // 과목 idx 부분인데 나중에 채팅창이랑 연동하면서 수정해야함!!
            noticeViewController.noticeIdx = testNoticeInfoArray[indexPath.row].noticeIdx
            noticeViewController.cateogoryIdx = 2
            
            print("=====================================")
            print("셀을 눌러서 공지 상세보기로 넘기는 정보")
            print("현재 클릭한 공지의 idx : \(testNoticeInfoArray[indexPath.row].noticeIdx)")
            print("현재 클릭한 공지의 과목 idx : \(self.subjectIDX)")
            print("=====================================")
            
        }
        
        
        else{
            
            
    
            
            noticeDetailVC.subjectIdx = self.subjectIDX // 과목 idx 부분인데 나중에 채팅창이랑 연동하면서 수정해야함!!
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
