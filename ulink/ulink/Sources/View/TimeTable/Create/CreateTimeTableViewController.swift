//
//  CreateTimeTableViewController.swift//  ulink
//
//  Created by 양시연 on 2020/07/07.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class CreateTimeTableViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource, SubjectInfoCellDelegate, GradeSelectVCDelegate, SearchVCDelegate,normalFilterDelegate {

    
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var timeTableCollectionView: UICollectionView!
    @IBOutlet weak var pageControlDots: UIPageControl!
    @IBOutlet weak var subjectInfoTableView: UITableView!
    
    @IBOutlet weak var searchView: UIView!
    
    // button
    @IBOutlet weak var filterAndSearchView: UIView!
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var filterImageView: UIImageView!
    @IBOutlet weak var filterBottomView: UIView!
    
    @IBOutlet weak var candidateView: UIView!
    @IBOutlet weak var candidateImageView: UIImageView!
    @IBOutlet weak var candidateLabel: UILabel!
    @IBOutlet weak var candidateBottomView: UIView!
    
    @IBOutlet weak var searchFilteHeight: NSLayoutConstraint!
    @IBOutlet weak var searchBackgroundHeight: NSLayoutConstraint!
    @IBOutlet weak var searchIconHeight: NSLayoutConstraint!
    @IBOutlet weak var searchLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var majorFilterHeight: NSLayoutConstraint!
    @IBOutlet weak var standardFilterHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var searchLabel: UILabel!
    
    private var isCandidateView = false
    
    private var timeTableList : [TimeTableModel] = [] {
        didSet {
            self.timeTableCollectionView.reloadData()
        }
    }
    private var subjectInfoList : [SubjectModel] = []
       
    private let daySymbol = [ "월", "화", "수", "목", "금"]
    
    // 통신할 때 필요한 data
    var grade = [Int]()
    var course = [String]()
    var credit = [Int]()
    var onday = [Int]()
    var offDay = [Int]()
    
    var semester = ""
    
    
    @IBAction func tapMajorFilter(_ sender: UIButton) {
        
         let storyboard = UIStoryboard(name:"Filter", bundle: nil)
               
               guard let nextVC = storyboard.instantiateViewController(identifier: "majorFilterViewController") as? MajorFilterViewController else { return }
               
               nextVC.modalPresentationStyle = .fullScreen
               present(nextVC, animated: true, completion: nil)
    }
    
    
    @IBAction func tapStandarFilter(_ sender: Any) {
        
        let storyboard = UIStoryboard(name:"Filter", bundle: nil)
                      
        guard let nextVC = storyboard.instantiateViewController(identifier: "NormalFilterViewController") as? NormalFilterViewController else { return }
                      
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true, completion: nil)
        
    }
    
    
    

    @IBAction func finishVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addTimeTableSheet(_ sender: UIButton) {
        addTimeTable()
    }
    
    @IBAction func addSubjectDirect(_ sender: UIButton) {
        
        let alert = UIAlertController(title: nil , message: "과목추가 방식을 선택해주세요.", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "드래그로 추가", style: .default, handler: { (_) in
                
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "addSubjectByDragViewController") as? AddSubjectByDragViewController else { return }
                   
                nextVC.modalPresentationStyle = .fullScreen
                nextVC.scheduleIdx = 12
                self.present(nextVC, animated: true, completion: nil)
            
            
            }))

        alert.addAction(UIAlertAction(title: "직접 입력", style: .default, handler: { (_) in
              

            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "addSubjectDetailViewController") as? AddSubjectDetailViewController else { return }
            
            nextVC.setTimeInfo(list: [])
            nextVC.isFromDrag = false
            
            self.present(nextVC, animated: true, completion: nil)
            
            
            }))


        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))

        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupGestureRecognizer()
        
        setBackgroundView()
        setTimeTableList()
        
        setButton()
        setSubjectInfoTableView()
        // setCollectionView()
        
        print("semester", semester)
        
        
        timeTableCollectionView.dataSource = self
        timeTableCollectionView.delegate = self
        
        subjectInfoTableView.dataSource = self
        subjectInfoTableView.delegate = self
       
    }
    
    
    //학년 선택 팝업 창 뜨는 코드 by 성은
    override func viewDidAppear(_ animated: Bool) {
        let sb = UIStoryboard(name: "Search", bundle: nil)
        
        guard let popUpVC = sb.instantiateViewController(identifier: "gradeSelect") as? GradeSelectViewController else {return}
        
        popUpVC.delegate = self
        
        popUpVC.modalPresentationStyle = .overCurrentContext
        present(popUpVC, animated: false, completion: nil)
    }
    
    //검색 뷰 클릭 코드 by 성은
    func setupGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
    }
    
    //검색 창 뜨는 코드 by 성은
    @objc func handleTap(_ tap: UIGestureRecognizer) {
        let sb = UIStoryboard(name: "Search", bundle: nil)
        
        guard let popUpVC = sb.instantiateViewController(identifier: "searchViewController") as? SearchViewController else {return}
        
        popUpVC.delegate = self
        
        popUpVC.modalPresentationStyle = .overCurrentContext
        present(popUpVC, animated: true, completion: nil)
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    

    private func setSubjectInfoTableView(){
        subjectInfoTableView.bounces = false
       
        subjectInfoTableView.estimatedRowHeight = 86
        subjectInfoTableView.rowHeight = UITableView.automaticDimension
    
       
    }
    
    private func setButton(){
        self.filterAndSearchView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapFilterAndSearch)))
        
        self.candidateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapCandidate(recognizer:))))

      
    }
    
    @IBAction func swipeLeft(_ sender: Any) {
        let x = self.timeTableCollectionView.bounds.origin.x
        if x < (self.timeTableCollectionView.frame.width - 11) * 2 {
            self.timeTableCollectionView.setContentOffset(CGPoint(x: self.timeTableCollectionView.bounds.origin.x + self.timeTableCollectionView.frame.width - 11, y: 0), animated: true)
        }
    }
    
    @IBAction func swipeRight(_ sender: Any) {
        let x = self.timeTableCollectionView.bounds.origin.x
        if x > 0 {
            self.timeTableCollectionView.setContentOffset(CGPoint(x: self.timeTableCollectionView.bounds.origin.x - self.timeTableCollectionView.frame.width + 11, y: 0), animated: true)
        }
    }
    
    private func setTimeTableList(){
        
        let timeTable_1 = TimeTableModel(idx: 0, name: "시간표1", subjectList: [])
        let timeTable_2 = TimeTableModel(idx: 0, name: "시간표2", subjectList: [])
        
        timeTableList = [timeTable_1, timeTable_2]
    }
    
    private func showSearchFilterBar(){
        searchFilteHeight.constant = 49
        searchIconHeight.constant = 18
        searchLabelHeight.constant = 18
        searchBackgroundHeight.constant = 29
        majorFilterHeight.constant = 29
        standardFilterHeight.constant = 29
    }
    
    private func hideSearchFilterBar(){
        searchFilteHeight.constant = 0
        searchIconHeight.constant = 0
        searchLabelHeight.constant = 0
        searchBackgroundHeight.constant = 0
        majorFilterHeight.constant = 0
        standardFilterHeight.constant = 0
    }
    
    private func addTimeTable(){
        let alertController = UIAlertController(title: "시간표 이름을 입력해 주세요.", message: nil, preferredStyle: .alert)
              let confirmAction = UIAlertAction(title: "확인", style: .default) { (_) in
                  if let txtField = alertController.textFields?.first, let text = txtField.text {
              
                    let newTimeTableSheet = TimeTableModel(idx: self.timeTableList.count - 1, name: text, subjectList: [])
                    self.timeTableList.append(newTimeTableSheet)
                      
//                    self.timeTableCollectionView.reloadData()
                    
                      
                print("이동할 곳", self.timeTableList.count - 1)
                self.timeTableCollectionView.scrollToItem(at: IndexPath(item: self.timeTableList.count - 1, section: 0), at: .centeredHorizontally, animated: true)
                      
                  }
              }
              let cancelAction = UIAlertAction(title: "취소", style: .destructive) { (_) in }
              alertController.addTextField { (textField) in
                  textField.placeholder = "시간표 이름"
              }
              alertController.addAction(cancelAction)
              alertController.addAction(confirmAction)
              self.present(alertController, animated: true, completion: nil)
    }
    
    private func setBackgroundView(){
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.backgroundView.bounds
        
        let colorLeft = UIColor(red: 127.0 / 255.0, green: 36.0 / 255.0, blue: 252.0 / 255.0, alpha: 1.0).cgColor
        let colorRight = UIColor(red: 95.0 / 255.0, green: 93.0 / 255.0, blue: 234.0 / 255.0, alpha: 1.0).cgColor
    
        gradientLayer.colors = [colorLeft, colorRight]
        gradientLayer.startPoint = CGPoint(x: -0.6, y: 0)
        gradientLayer.endPoint   = CGPoint(x: 1, y: 0.2)
        gradientLayer.locations = [0, 1]
        gradientLayer.shouldRasterize = true
        
        self.backgroundView.layer.addSublayer(gradientLayer)
        
    }
    
    func drawHintTimeTable(row: Int, day: [Int], startTime: [String], endTime : [String]){
    
        let indexPath = IndexPath(row: row, section: 0)
    
        let timeTableCell = timeTableCollectionView.cellForItem(at: indexPath) as! CreateTimeTableCell
        
        timeTableCell.timeTable.reloadData()
        
        timeTableCell.timeTable.makeHintTimeTable(day : day, startTime: startTime, endTime : endTime)
        
    }
    
    func removeHintTimeTable(row: Int){
        let indexPath = IndexPath(row: row, section: 0)
        
        let timeTableCell = timeTableCollectionView.cellForItem(at: indexPath) as? CreateTimeTableCell
        
        timeTableCell?.timeTable.reloadData()
//        timeTableCell?.timeTable.removeHintTable()
    }
    
    
    // MARK: - protocol 구현
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let count = timeTableList.count + 1
        pageControlDots.numberOfPages = count
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    
        if(indexPath.row < timeTableList.count){
            guard let createTimeTableCell : CreateTimeTableCell = timeTableCollectionView.dequeueReusableCell(withReuseIdentifier: "createTimeTableCell", for: indexPath) as? CreateTimeTableCell else {return CreateTimeTableCell()}
               
            let data = timeTableList[indexPath.row]
            
            createTimeTableCell.setCreateTimeTableCell(idx: data.scheduleIdx, name: data.name, subjectList:data.subjectList)
               
            return createTimeTableCell
        }else{
            guard let addSheetCell : CreateNewSheetCell = timeTableCollectionView.dequeueReusableCell(withReuseIdentifier: "createNewSheetCell", for: indexPath) as? CreateNewSheetCell else {return CreateNewSheetCell()}
                      
                    
            return addSheetCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt
           indexPath: IndexPath) -> CGSize {
           return CGSize(width: collectionView.frame.width - 22, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 0, left: 11, bottom: 0, right: 11)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 22
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == timeTableList.count {
            
            addTimeTable()

        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControlDots.currentPage = Int(
            (self.timeTableCollectionView.contentOffset.x / self.timeTableCollectionView.frame.width)
            .rounded(.toNearestOrAwayFromZero)
        )
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectInfoList.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      guard let subjectInfoCell =  subjectInfoTableView.dequeueReusableCell(withIdentifier: "subjectInfoCell", for: indexPath) as? SubjectInfoCell else { return SubjectInfoCell() }
     
        let data = subjectInfoList[indexPath.row]
     
        subjectInfoCell.setSubjectInfoData(subjectIdx : data.subjectIdx, name: data.subjectName, professorName: data.professorName, content: data.content, category: data.course, credit: data.credit, subjectNum: data.subjectNum, day: data.subjectDay, startTime: data.startTime, endTime: data.endTime, num : indexPath.row)
     
        if self.isCandidateView {
            subjectInfoCell.setCandidateCell()
        }else{
            subjectInfoCell.setMainCell()
        }
     
     
        if(subjectInfoList.count != 0){
            if indexPath.row == subjectInfoList.count - 1 {
                subjectInfoCell.hideBorder()
            }
        }
     
        subjectInfoCell.delegate = self
        return subjectInfoCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.beginUpdates()
        tableView.endUpdates()

        let num = indexPath.row

        if num < subjectInfoList.count {
            if !(tableView.cellForRow(at: indexPath) as! SubjectInfoCell).isExpended {
                removeHintTimeTable(row: pageControlDots.currentPage)
            } else {
                drawHintTimeTable(row: pageControlDots.currentPage, day:  subjectInfoList[num].subjectDay,startTime: subjectInfoList[num].startTime, endTime: subjectInfoList[num].endTime)
            }
        }
    }

    func showReview(idx: Int) {
        print("showReview")
    }
       
    func deleteSubject(idx: Int) {
        print("deleteSubject")
    }
    
    
    // 노말 필터 값 전달해보자 한번~~~
       func sendFilter(day: [Int], dayOff: [Int], firstClass: Bool, grade: [Int]) {
        print("현재 데이 : \(day)")
    }
    
       
    func addCandidate(idx: Int) {
        postCandidate(semester : "2020-2", subjectIdx: idx)
    }
       
    func enrollSubject(subjectIdx: Int, subjectItems: [SubjectModel]) {
        
        let indexPath = IndexPath(row: pageControlDots.currentPage, section: 0)
           
        let timeTableCell = timeTableCollectionView.cellForItem(at: indexPath) as! CreateTimeTableCell
           
        timeTableCell.timeTable.reloadData()
           
        var tempList = [SubjectModel]()
        var candDraw = true
        for (_, subjectItem) in subjectItems.enumerated() {
           
            var item = subjectItem
            print(timeTableCell.subjectList)
          
            for (_, temp) in timeTableCell.subjectList.enumerated() {
                let tstartHour = Int(temp.startTime[0].split(separator: ":")[0])
                let tstartMin = Int(temp.startTime[0].split(separator: ":")[1])
                print("index", index)
                
                let tempStart = (temp.subjectDay[0] * 10000) + (tstartHour! * 100 ) + tstartMin!
                let tendHour = Int(temp.endTime[0].split(separator: ":")[0])
                let tendMin = Int(temp.endTime[0].split(separator: ":")[1])
                let tempEnd = (temp.subjectDay[0] * 10000) + (tendHour! * 100) + tendMin!
                
                let startHour = Int(item.startTime[0].split(separator: ":")[0])
                let startMin = Int(item.startTime[0].split(separator: ":")[1])
                let start = (item.subjectDay[0] * 10000) + (startHour! * 100 ) + startMin!
                let endHour = Int(item.endTime[0].split(separator: ":")[0])
                let endMin = Int(item.endTime[0].split(separator: ":")[1])
                let end = (item.subjectDay[0] * 10000) + (endHour! * 100) + endMin!
                
                
                if (tempStart >= end || tempEnd <= start ) {
                    candDraw = true
                }else {
                    candDraw = false
                    break
                }
            
            }
            
            if !candDraw {
                break
            }
            
            item.backgroundColor = timeTableCell.timeTable.getColorCount()
            tempList.append(item)
        }
        
        
        if(candDraw){
            timeTableCell.subjectList.append(contentsOf: tempList)
            timeTableCell.timeTable.reDrawTimeTable()
            
            for temp in tempList {
                enrollSubject(subjectIdx: subjectIdx , color: temp.backgroundColor, scheduleIdx: 12)
                // todo : scheduleIdx 바꿔!
            }
        }else {
            let alert = UIAlertController(title: "", message: "시간이 겹쳐 추가할 수 없습니다.", preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "확인",style: UIAlertAction.Style.default, handler: nil))

            self.present(alert, animated: true, completion: nil)
        }
       
    }
    
    //학년선택 by 성은
    func selectedGrade(_ grade: Int) {
        self.grade.append(grade)
        
        // 학년 통신!
        getSubject()
        
    }
    
    //검색 by 성은
    func searchedSubjectName(_ subjectName: String) {
        searchLabel.text = subjectName
    }
    
    // gestureRecognizer
    @objc func handleTapFilterAndSearch(recognizer: UITapGestureRecognizer) {
        
        isCandidateView = false
        showSearchFilterBar()

        // 선택 처리
        self.filterLabel.textColor = UIColor.purpleishBlueThree
        self.filterImageView.image = UIImage(named: "timetableaddFilterandsearchBtnFilterandsearchOn.png")
        self.filterBottomView.backgroundColor = UIColor.purpleishBlueThree

        self.candidateLabel.textColor = UIColor.brownGreyFive
        self.candidateImageView.image = UIImage(named: "timetableaddFilterandsearchBtnCandidateOff.png")
        self.candidateBottomView.backgroundColor = UIColor.clear
        
        getSubject()
        
        self.subjectInfoTableView.reloadData()
        
    }

    @objc func handleTapCandidate(recognizer: UITapGestureRecognizer) {
        
         isCandidateView = true
        hideSearchFilterBar()

           // 선택 처리
           self.filterLabel.textColor = UIColor.brownGreyFive
           self.filterImageView.image = UIImage(named: "timetableaddFilterandsearchBtnFilterandsearchOff.png")
           self.filterBottomView.backgroundColor = UIColor.clear

           self.candidateLabel.textColor = UIColor.purpleishBlueThree
           self.candidateImageView.image = UIImage(named: "timetableaddFilterandsearchBtnCandidateOn.png")
           self.candidateBottomView.backgroundColor = UIColor.purpleishBlueThree
        
        self.getCandidate(semester: "2020-2")
        
        self.subjectInfoTableView.reloadData()
           
    }
    
    
    
    // MARK: - 통신
    func getSubject(){
           print("getSubject")
               
        SubjectService.shared.getSubject(course: self.course, grade: self.grade, credit: self.credit, onDay: self.onday, offDay: self.offDay){ networkResult in
                   switch networkResult {
                       case .success(let list, _) :
                        print("과목 불러오기 성공")
                        self.subjectInfoList = list as! [SubjectModel]
                        self.subjectInfoTableView.reloadData()
                           break
                       case .requestErr(let message):
                               print("REQUEST ERROR")
                               break
                   case .pathErr: break
                   case .serverErr: print("serverErr")
                       case .networkFail: print("networkFail")
                   }
               }
          }
    
    func enrollSubject(subjectIdx: Int, color : Int, scheduleIdx : Int){
       print("enrollSubject")
           
        SubjectService.shared.enrollSubejct(subjectIdx: subjectIdx, color: color, scheduleIdx: scheduleIdx){ networkResult in
               switch networkResult {
                   case .success(_, _) :
                    print("과목 등록 성공")
                       break
                   case .requestErr(let message):
                           print("REQUEST ERROR")
                           break
               case .pathErr: break
               case .serverErr: print("serverErr")
                   case .networkFail: print("networkFail")
               }
           }
      }
    
    func postCandidate(semester : String, subjectIdx: Int){
        CartService.shared.postCart(semester: semester, subjectIdx: subjectIdx){ networkResult in
            switch networkResult {
                case .success(_, _) :
                 print("후보 등록 성공")
             
                    break
                case .requestErr(let message):
                        print("REQUEST ERROR")
                        break
            case .pathErr: break
            case .serverErr: print("serverErr")
                case .networkFail: print("networkFail")
            }
        }
    }

    func getCandidate(semester : String){
        print("getCandidate")
        CartService.shared.getCart(semester : semester){ networkResult in
            switch networkResult {
                case .success(let list, _) :
                 print("후보 조회 성공")
                 self.subjectInfoList = list as! [SubjectModel]
                 print(list)
                 self.subjectInfoTableView.reloadData()
                 print(list)
                    break
                case .requestErr(let message):
                        print("REQUEST ERROR")
                        break
            case .pathErr: break
            case .serverErr: print("serverErr")
                case .networkFail: print("networkFail")
            }
        }
    }
    
    
    
}

extension CreateTimeTableViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return (touch.view?.isDescendant(of: searchView) ?? false)
    }
}
