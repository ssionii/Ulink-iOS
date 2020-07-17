//
//  NoticeEditViewController.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/09.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

protocol NoticeEditVCDelegate{
    func dismissAndReload()
}

class NoticeEditViewController: UIViewController {
    
    public var delegate: NoticeEditVCDelegate?
    
    @IBAction func BackButtonClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)

        self.dismiss(animated: true){
            self.delegate?.dismissAndReload()
        }
    }
    @IBAction func EditButtonClicked(_ sender: Any) {
        
    
        
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "NoticeEditModeViewController") as? NoticeEditModeViewController else { return }
        
        
        nextVC.categoryIndex = cateogoryIdx
        nextVC.editModeOn = 1
        nextVC.noticeIdx = noticeIdx
        nextVC.subjectIdx = subjectIDX
        
        
        print("==================================")
        print("현재 공지사항 -> 수정 뷰로 데이터 넘기기 ")
        print("넘기는 notice IDX :\(self.noticeIdx)")
        print("넘기는 category IDX : \(self.cateogoryIdx)")
         print("넘기는 subject idx : \(self.subjectIDX)")
        print("==================================")
        
        nextVC.modalPresentationStyle = .automatic

        
        present(nextVC, animated: true, completion: nil)
        
        
        
        
    }
    
    
    
    @IBAction func deleteNoticeButtonClicked(_ sender: Any) {
        
        
        NoticeDeleteService.shared.deleteNotice(noticeIdx: noticeIdx) { networkResult in
              print("현재 notice IDX :\(self.noticeIdx)")

              switch networkResult{
                      
                  
              case .success(_, _):
                  

                  let alertViewController = UIAlertController(title: "", message: "삭제 성공",
                                                              preferredStyle: .alert)
                  let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                  alertViewController.addAction(action)
                  self.present(alertViewController, animated: true, completion: nil)
                

                  
                  
                  
                  
              default:
                  
                    let alertViewController = UIAlertController(title: "", message: "삭제 완료!",
                                                                preferredStyle: .alert)
                    let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                    alertViewController.addAction(action)
                    self.present(alertViewController, animated: true, completion: nil)
                  

                    
                  
                  
              }
            
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)

              
                
            


                
            }
        
        
        
        
        
        
        
    }
    
    
    var subjectIDX : Int = 0
     var cateogoryIdx : Int = 0 // 카테고리 판별하기 위한 변수
     var noticeIdx : Int = -1    // 공지사항 구별하기 위해 쓰는 변수
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    @IBOutlet weak var memoContentTextLabel: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "modifyLoad"), object: nil)

        
        setTitle()
        getNoticeDetailData()
        
        
        print("=====================================")
        print("공지 자세히 보기 화면의 정보")
        print("현재 공지의 subject IDX : \(subjectIDX)")
        print("현재 공지의 category : \(cateogoryIdx)")
        print("현재 공지사항의 IDX : \(noticeIdx)")
        print("=====================================")
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("noticeIndex: \(noticeIdx)")
    }
    
    
    @objc func loadList(notification: NSNotification){
        //load data here
        

        
        DispatchQueue.main.async {

            self.getNoticeDetailData()
        }

    }
    
    func setTitle()
    {
        
        if cateogoryIdx == 1
        {
            self.categoryLabel.text = "과제 공지"
        }
        else if cateogoryIdx == 2
        {
            
            self.categoryLabel.text = "시험 공지"
        }
        
        else if cateogoryIdx == 3
        {
            self.categoryLabel.text = "수업 공지"
            
        }
        else
        {
            self.categoryLabel.text = "공지"
        }
        
    }
    
    
    
    func getNoticeDetailData(){
        
        NoticeDetailService.shared.getSubjectDetailNotice(noticeIdx: noticeIdx) { networkResult in // noticeIdx 정보 설정
            
            
            print("==================================")
            print("현재 공지사항을 받아오는 통신 함수 내부")
            print("현재 notice IDX :\(self.noticeIdx)")
            print("==================================")
            
            
            switch networkResult{
                    
                
            case .success(let noticeList, _):
                
                
                
                guard let noticeList = noticeList as? SubjectNoticeData else { return }
                
                
                //MARK:- 타이틀 설정
                self.titleLabel.text = noticeList.title
                
                
                // MARK:- 날짜 정보 설정
                
                let dateArray = noticeList.date.components(separatedBy: "-")
                
                print("date Array")
                
                self.dateLabel.text = dateArray[0] + "년 " + dateArray[1] + "월 " + dateArray[2] + "일"
                
                
                // MARK:- 시간 정보 설정
                var subtitle : String = ""
                
                
                subtitle = noticeList.startTime + " ~ " + noticeList.endTime
                
                
                if noticeList.startTime == "-1"
                {
                    subtitle =  "~ " + noticeList.endTime
                }
                
                if noticeList.endTime == "-1"
                {
                    subtitle = ""
                }
                
                
                
                self.timeLabel.text = subtitle
                
                //MARK:- 메모 정보 설정
                
                self.memoContentTextLabel.text = noticeList.content
                
                
                
                
                
                
                
                
                
                
            default:
                print("fail")
                
                
            }
            
              
          


              
          }
          
        
        
    }
    
    
    


}
