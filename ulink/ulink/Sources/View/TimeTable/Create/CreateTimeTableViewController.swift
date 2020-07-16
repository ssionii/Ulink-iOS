//
//  CreateTimeTableViewController.swift
//  ulink
//
//  Created by 양시연 on 2020/07/07.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class CreateTimeTableViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource, SubjectInfoCellDelegate, GradeSelectVCDelegate, SearchVCDelegate {
    
    
    
    //var gradeSelect: GradeSelectViewController?

    
   
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
    
    @IBOutlet weak var searchLabel: UILabel!
    
    private var isCandidateView = false
    
    private var timeTableList : [TimeTableModel] = [] {
        didSet {
            self.timeTableCollectionView.reloadData()
        }
    }
    private var subjectInfoList : [SubjectModel] = []
       
    private let daySymbol = [ "월", "화", "수", "목", "금"]

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
        setSubjectInfoList()
        
        
        setButton()
        setSubjectInfoTableView()
        // setCollectionView()
        
        
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
    
    
    private func setSubjectInfoList(){
        
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
    
    
    // MARK: protocol 구현
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
     
        subjectInfoCell.setSubjectInfoData(name: data.subjectName, professorName: data.professorName, content: data.content, category: data.course, credit: data.credit, subjectNum: data.subjectNum, day: data.day, startTime: data.startTime, endTime: data.endTime, num : indexPath.row)
     
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
                drawHintTimeTable(row: pageControlDots.currentPage, day:  subjectInfoList[num].day,startTime: subjectInfoList[num].startTime, endTime: subjectInfoList[num].endTime)
            }
        }
    }

    func showReview(idx: Int) {
        print("showReview")
    }
       
    func deleteSubject(idx: Int) {
        print("deleteSubject")
    }
       
    func addCandidate(idx: Int) {
        print("addCandidate")
    }
       
    func enrollSubject(subjectIdx: Int, subjectItems: [SubjectModel]) {
        
        let indexPath = IndexPath(row: pageControlDots.currentPage, section: 0)
           
        let timeTableCell = timeTableCollectionView.cellForItem(at: indexPath) as! CreateTimeTableCell
           
        timeTableCell.timeTable.reloadData()
           
        var tempList = [SubjectModel]()
        var candDraw = true
        for (_, subjectItem) in subjectItems.enumerated() {
           
            var item = subjectItem
            print(item)
            
            for (index, temp) in timeTableCell.subjectList.enumerated() {
                let tstartHour = Int(temp.startTime[index].split(separator: ":")[0])
                let tstartMin = Int(temp.startTime[index].split(separator: ":")[1])
                print("index", index)
                
                let tempStart = (temp.day[index] * 10000) + (tstartHour! * 100 ) + tstartMin!
                let tendHour = Int(temp.endTime[index].split(separator: ":")[0])
                let tendMin = Int(temp.endTime[index].split(separator: ":")[1])
                let tempEnd = (temp.day[index] * 10000) + (tendHour! * 100) + tendMin!
                
                let startHour = Int(item.startTime[index].split(separator: ":")[0])
                let startMin = Int(item.startTime[index].split(separator: ":")[1])
                let start = (item.day[index] * 10000) + (startHour! * 100 ) + startMin!
                let endHour = Int(item.endTime[index].split(separator: ":")[0])
                let endMin = Int(item.endTime[index].split(separator: ":")[1])
                let end = (item.day[index] * 10000) + (endHour! * 100) + endMin!
                
                
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
        }else {
            let alert = UIAlertController(title: "", message: "시간이 겹쳐 추가할 수 없습니다.", preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "확인",style: UIAlertAction.Style.default, handler: nil))

            self.present(alert, animated: true, completion: nil)
        }
       
    }
    
    //학년선택 by 성은
    func selectedGrade(_ grade: Int) {
        print(grade)
    }
    
    //검색 by 성은
    func searchedSubjectName(_ subjectName: String) {
        searchLabel.text = subjectName
    }
    
    // gestureRecognizer
    @objc func handleTapFilterAndSearch(recognizer: UITapGestureRecognizer) {
        
        isCandidateView = false

        // 선택 처리
        self.filterLabel.textColor = UIColor.purpleishBlueThree
        self.filterImageView.image = UIImage(named: "timetableaddFilterandsearchBtnFilterandsearchOn.png")
        self.filterBottomView.backgroundColor = UIColor.purpleishBlueThree

        self.candidateLabel.textColor = UIColor.brownGreyFive
        self.candidateImageView.image = UIImage(named: "timetableaddFilterandsearchBtnCandidateOff.png")
        self.candidateBottomView.backgroundColor = UIColor.clear
        
        let tempDay = [0, 1]
        let tempDateTime = ["09:00-13:30","09:00-13:30"]
        
        
        self.subjectInfoTableView.reloadData()
        
    }

    @objc func handleTapCandidate(recognizer: UITapGestureRecognizer) {
        
         isCandidateView = true

           // 선택 처리
           self.filterLabel.textColor = UIColor.brownGreyFive
           self.filterImageView.image = UIImage(named: "timetableaddFilterandsearchBtnFilterandsearchOff.png")
           self.filterBottomView.backgroundColor = UIColor.clear

           self.candidateLabel.textColor = UIColor.purpleishBlueThree
           self.candidateImageView.image = UIImage(named: "timetableaddFilterandsearchBtnCandidateOn.png")
           self.candidateBottomView.backgroundColor = UIColor.purpleishBlueThree
        
        let tempDay = [0, 1]
        let tempDateTime = ["09:00-13:30","09:00-13:30"]

//        let subjectInfo_1 = SubjectModel(subjectName: "후보군", professorName: "최성일",  roomName: "명신관614", course: "전공선택", credit: 3, subjectNum: "2016123-132", day: tempDay, dateTime: tempDateTime)
//
//        let subjectInfo_2 = SubjectModel(subjectName: "후보군", professorName: "최성일", roomName: "명신관614", course: "전공선택", credit: 3, subjectNum: "2016123-132", day: tempDay, dateTime: tempDateTime)
//
//        let subjectInfo_3 = SubjectModel(subjectName: "후보군이라굿!", professorName: "최성일",  roomName: "명신관614", course: "전공선택", credit: 2, subjectNum: "2016123-132", day: tempDay, dateTime: tempDateTime)
        
//        subjectInfoList = [subjectInfo_1]
    
        
        
        self.subjectInfoTableView.reloadData()
           
    }

}

extension CreateTimeTableViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return (touch.view?.isDescendant(of: searchView) ?? false)
    }
}
