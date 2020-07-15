//
//  TimeTableListViewController.swift
//  ulink
//
//  Created by 양시연 on 2020/07/05.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class TimeTableListViewController: UIViewController {

    
    @IBOutlet weak var listCollectionView: UICollectionView!
    @IBAction func backBtn(_ sender: UIButton) {
        dismissVC()
    }
    
    private var listDummy : [ListSemester] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listCollectionView.bounces = false
        
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        
        setListDummy()
        
    }
    
    private func dismissVC(){
        let transition: CATransition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: nil)
               
        dismiss(animated: false, completion: nil)
    }
    
    private func setListDummy(){
        
        let timeTable_1 = TimeTableModel(scheduleIdx: 0, name: "알바있을 때 시간표", semesterInput: "2020-1", isMain: 1)
        let timeTable_2 = TimeTableModel(scheduleIdx: 1, name: "알바없을 때 시간표", semesterInput: "2020-1", isMain: 0)
        let timeTable_3 = TimeTableModel(scheduleIdx: 2, name: "수강신청 망했을 때", semesterInput: "2020-1", isMain: 0)
        
        let timeTable_4 = TimeTableModel(scheduleIdx: 3, name: "월 공강", semesterInput: "2020-3", isMain: 0)
        let timeTable_5 = TimeTableModel(scheduleIdx: 4, name: "금 공강", semesterInput: "2020-3", isMain: 1)
        
        let timeTableList_1 = [timeTable_1, timeTable_2, timeTable_3]
        let timeTableList_2 = [timeTable_4, timeTable_5]
        
        
        let semester_1 = ListSemester(nameInput: "2020-0", timeTableList : timeTableList_1)
        let semester_2 = ListSemester(nameInput: "2020-2", timeTableList : timeTableList_2)
        let semester_3 = ListSemester(nameInput: "2019-3", timeTableList : timeTableList_1)
        let semester_4 = ListSemester(nameInput: "2019-2", timeTableList : timeTableList_2)
        let semester_5 = ListSemester(nameInput: "2018-0", timeTableList : timeTableList_2)
        
        listDummy = [semester_1, semester_2, semester_3, semester_4, semester_5]
    }
    
    private func getListTimeTable(){
        
        print("getListTimeTable")
//        SubjectDetailService.shared.getMainTimeTable(idx: subjectIdx, isSubject: isSubject) { networkResult in
//            switch networkResult {
//                case .success(let detail, _) :
//
//                    let subjectDetail = detail as! SubjectModel
//
//                    self.subjectColorCode = subjectDetail.backgroundColor
//                    self.subjectName = subjectDetail.subjectName
//                    self.subjectTimeInfo = self.makeTimeInfo(day: subjectDetail.day, startTime: subjectDetail.startTime, endTime: subjectDetail.endTime)
//                    self.subjectMemo = self.makeMemo(content: subjectDetail.content, professor: subjectDetail.professorName)
//
//                    print(subjectDetail)
//
//                    break
//                case .requestErr(let message):
//                        print("REQUEST ERROR")
//                        break
//            case .pathErr: break
//            case .serverErr: print("serverErr")
//            case .networkFail: print("networkFail")
//            }
//        }
//
    }
    

}

extension TimeTableListViewController : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let width: CGFloat = collectionView.frame.width
        let height: CGFloat = 57
        
        return CGSize(width: width, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(listDummy[indexPath.section].timeTableList[indexPath.row].scheduleIdx)
        dismissVC()
    }
    
}

extension TimeTableListViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
          return listDummy.count
      }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listDummy[section].timeTableList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let timeTableListCell : TimeTableListCell = collectionView.dequeueReusableCell(withReuseIdentifier: "timeTableListCell", for: indexPath) as? TimeTableListCell else {return UICollectionViewCell()}
            
        let data = listDummy[indexPath.section].timeTableList[indexPath.row]
        timeTableListCell.setTimeTableListCell(idx: data.scheduleIdx, name: data.name, isMain: data.isMain)
    
        return timeTableListCell
        

    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView : TimeTableListHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "timeTableListHeader", for: indexPath) as! TimeTableListHeader
            
            headerView.setSemester(semester: listDummy[indexPath.section].semester)
            return headerView
        case UICollectionView.elementKindSectionFooter:
            let footerView : TimeTableListFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "timeTableListFooter", for: indexPath) as! TimeTableListFooter
            
            return footerView
        default:
            assert(false, "안돼 돌아가")
            
        }
    }
}

extension TimeTableListViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     
        return CGSize(width: 375, height: 34)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        if section == listDummy.count - 1 {
            return CGSize(width: 375, height: 56)
        }
        return CGSize(width: 375, height: 26)
        
    }
}
