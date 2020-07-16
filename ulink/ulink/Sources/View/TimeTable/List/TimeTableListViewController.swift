//
//  TimeTableListViewController.swift
//  ulink
//
//  Created by 양시연 on 2020/07/05.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

protocol TimeTableListViewControllerDelegate {
    func getTimeTable(idx: Int)
}

class TimeTableListViewController: UIViewController {

    @IBOutlet weak var listCollectionView: UICollectionView!
    @IBAction func backBtn(_ sender: UIButton) {
        dismissVC()
    }
    
    private var listSemesterList : [ListSemester] = []
    
    public var delegate : TimeTableListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listCollectionView.bounces = false
        
        getListTimeTable()
        
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        
       
        
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
    
    private func getListTimeTable(){
        
        print("getListTimeTable")
        ListTimeTableService.shared.getListTimeTable{ networkResult in
            switch networkResult {
                case .success(let list, _) :

                    let listSemesterList = list as! [ListSemester]
                    var resultList = [ListSemester]()
                    for(_, listSemester) in listSemesterList.enumerated() {
                        
                        let semester = ListSemester.init(nameInput: listSemester.semester, semester: listSemester.semester,  timeTableList: listSemester.timeTableList)
                        
                        resultList.append(semester)
                    }
                    
                    // 뿌려주기
                    self.listSemesterList = resultList
                    self.listCollectionView.reloadData()
                    

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

extension TimeTableListViewController : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let width: CGFloat = collectionView.frame.width
        let height: CGFloat = 57
        
        return CGSize(width: width, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.getTimeTable(idx: listSemesterList[indexPath.section].timeTableList[indexPath.row].scheduleIdx)
        print(listSemesterList[indexPath.section].timeTableList[indexPath.row].scheduleIdx)
        dismissVC()
    }
    
}

extension TimeTableListViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
          return listSemesterList.count
      }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listSemesterList[section].timeTableList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let timeTableListCell : TimeTableListCell = collectionView.dequeueReusableCell(withReuseIdentifier: "timeTableListCell", for: indexPath) as? TimeTableListCell else {return UICollectionViewCell()}
            
        let data = listSemesterList[indexPath.section].timeTableList[indexPath.row]
        
        timeTableListCell.setTimeTableListCell(idx: data.scheduleIdx, name: data.name, isMain: data.isMain)
    
        return timeTableListCell
        

    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView : TimeTableListHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "timeTableListHeader", for: indexPath) as! TimeTableListHeader
            
            headerView.setSemester(semester: listSemesterList[indexPath.section].semester)
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
        
        if section == listSemesterList.count - 1 {
            return CGSize(width: 375, height: 56)
        }
        return CGSize(width: 375, height: 26)
        
    }
}
