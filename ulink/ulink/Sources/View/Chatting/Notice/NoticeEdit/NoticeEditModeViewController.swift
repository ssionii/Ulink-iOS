//
//  NoticeEditModeViewController.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/09.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit
import TextFieldEffects

class NoticeEditModeViewController: UIViewController {

    @IBOutlet weak var hwNoticeButton: UIButton!
    
    @IBOutlet weak var testNoticeButton: UIButton!
    
    
    @IBOutlet weak var startTimeTextField: UITextField!
    
    @IBOutlet weak var endTImeTextField: UITextField!
    
    @IBOutlet weak var classNoticeButton: UIButton!
    
    
    @IBOutlet weak var titleEditTextField:   HoshiTextField!
    @IBOutlet weak var textAreaBorder: UIView!
    
    
    @IBOutlet weak var contentMemoTextFIeld: UITextView!
    
    
    @IBOutlet weak var datePickerLabel: UITextField!
    
    let datePicker = UIDatePicker()
    let timePicker = UIPickerView()
    let timePicker2 = UIPickerView()
    var categoryIndex : Int = 0
    var subjectIdx : Int = 1
    var noticeIdx : Int = 1
    var hour : String = ""
    var minute : String = ""
    var checkNotTIme : Int = 0
    var error : Int = 0 // error 0은 정상 , 1이 에러!!
    var editModeOn : Int = 1 // 0이 그냥 추가, 1이 수정!!
    var dateString : String = ""
    
    var dateClicked : Int = 0 // 수정을 할때 date 부분을 클릭했는지 아닌지를 판별하기 위한 변수
    
    
    var dateStr : String = ""
    
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setBorder()
        setButttonClear()
        getNoticeDetailData()
        setTimePicker()
        setDataPicker()
        
        
        
        
        print("==================================")
        print("현재 공지사항 수정 뷰의 정보 ")
        print("현재 notice IDX :\(self.noticeIdx)")
        print("현재 subject IDX : \(self.subjectIdx)")
        print("현재 category IDX : \(self.categoryIndex)")
        print("==================================")

    }
    
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        
        
        error = 0
        
        // 여기에 내용 수정 된 코드가 들어가야 함
        if titleEditTextField.text == ""
        {
            let alert = UIAlertController(title: "", message: "제목을 설정해주세요", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "확인", style: .default, handler : nil )

            alert.addAction(okAction)

            present(alert, animated: true, completion: nil)
            
            error = 1
            
            
        }
        
        if categoryIndex == 0
        {
            
            let alert = UIAlertController(title: "", message: "카테고리를 설정해주세요", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "확인", style: .default, handler : nil )

            alert.addAction(okAction)

            present(alert, animated: true, completion: nil)
            
            error = 1
        }
        
        if datePickerLabel.text == ""
        {
            let alert = UIAlertController(title: "", message: "날짜를 선택해주세요", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "확인", style: .default, handler : nil )

            alert.addAction(okAction)

            present(alert, animated: true, completion: nil)
            
            error = 1
        }
        
        
        

        
        
        
        
        
        if error == 0 // 문제없으면 업로드를 해봅시다.
        {
            var categoryData : String = ""
            
            
            if categoryIndex == 1
            {
                categoryData = "과제"
            }
            else if categoryIndex == 2
            {
                categoryData = "시험"
                
            }
            else if categoryIndex == 3
            {
                categoryData = "수업"
            }
            
            else
            {
                categoryData = "공지"
                
            }
            
            

            
            
            

            var startTime : String = startTimeTextField.text ?? "-1"
            
            if startTime == "시간정보없음"
            {
                startTime = "-1"
            }
            var endTime : String = endTImeTextField.text ?? "-1"
            
            if endTime == "시간정보없음"
            {
                endTime = "-1"
            }
            let title : String = titleEditTextField.text ?? ""
            let content : String = contentMemoTextFIeld.text
            
            
            if dateClicked == 0
            {
                let tempString = datePickerLabel.text?.components(separatedBy: "년 ")
                let temp : String!
                let temp1 : String!
                
                temp = tempString![0]
                
                let tempStringOne = tempString![1].components(separatedBy: "월 ")
                
                temp1 = tempStringOne[0]
                
                let tempStringTwo = tempStringOne[1].components(separatedBy: "일")
                
                
                dateStr = temp + "-" + temp1 + "-" + tempStringTwo[0]
                
                print("수정된 DATASTR : \(dateStr)")
                
                
                
            }
          

        
            

            
            
            if editModeOn == 0
            {

                
 
                
                            
                            NoticeEditService.shared.uploadNotice(category: categoryData, date: dateStr, startTime: startTime, endTime: endTime, title: title, content: content, subjectIdx: subjectIdx){ networkResult in // noticeIdx 정보 설정


                                switch networkResult{
                                    
                                    
                                    
                                    
                                // MARK:- 서버 접속 성공 했을때
                                case .success(_,_) :
                                    
                                    
                                    let alertViewController = UIAlertController(title: "", message: "공지사항이 등록되었습니다",
                                                                                preferredStyle: .alert)
                                    let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                                    alertViewController.addAction(action)
                                    self.present(alertViewController, animated: true)
                                  
                                    
                                    
                                    
                                    
                                    
                                    

                                    
                                    
                                    
                                    
                                case .requestErr(let message):
                                    print("REQUEST ERROR")
                                    guard let message = message as? String else { return }
                                    let alertViewController = UIAlertController(title: "업로드 실패", message: message,
                                                                                preferredStyle: .alert)
                                    let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                                    alertViewController.addAction(action)
                                    self.present(alertViewController, animated: true, completion: nil)
                                    
                                    
                                    
                                case .pathErr:
                                    let alertViewController = UIAlertController(title: "공지 입력 실패", message: "공지사항 정보를 다시 확인해주세요",
                                                                                preferredStyle: .alert)
                                    let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                                    alertViewController.addAction(action)
                                    self.present(alertViewController, animated: true, completion: nil)
                                case .serverErr: print("serverErr")
                                case .networkFail: print("networkFail")
                                }
                                         
                                
                                
                                
                                
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load2"), object: nil)

                                
                                         
                                         
                                     }
                                     
                                       
                    
                       
                                       
                print("==================================")
                print("공지 생성 할 때 서버에  넘겨주는 정보 ")
                print("categoryData : \(categoryData)")
                print("날짜 String : \(dateStr)")
                print("시작 시간 : \(startTime)")
                print("종료 시간 : \(endTime)")
                print("공지 제목 : \(title)")
                print("메모 내용 : \(content)")
                print("현재 notice IDX :\(self.noticeIdx)")
                print("==================================")
                




                
            }
                
                
                
            
            else
            {
                
        
                NoticeModifyService.shared.uploadNotice(category: categoryData, date: dateStr, startTime: startTime, endTime: endTime, title: title, content: content, noticeIdx: noticeIdx){ networkResult in // noticeIdx 정보 설정
     
                    switch networkResult{
                        
                        
                        
                        
                    // MARK:- 서버 접속 성공 했을때
                    case .success(_,_) :
                        
                        
                        let alertViewController = UIAlertController(title: "", message: "공지사항이 수정되었습니다",
                                                                    preferredStyle: .alert)
                        let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                        alertViewController.addAction(action)
                        self.present(alertViewController, animated: true)  
                        
                        
                        
                        
                        
                        

                        
                        
                        
                        
                    case .requestErr(let message):
                        print("REQUEST ERROR")
                        guard let message = message as? String else { return }
                        let alertViewController = UIAlertController(title: "업로드 실패", message: message,
                                                                    preferredStyle: .alert)
                        let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                        alertViewController.addAction(action)
                        self.present(alertViewController, animated: true, completion: nil)
                        
                        
                        
                    case .pathErr:
                        let alertViewController = UIAlertController(title: "공지 수정 실패", message: "공지사항 정보를 다시 확인해주세요",
                                                                    preferredStyle: .alert)
                        let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                        alertViewController.addAction(action)
                        self.present(alertViewController, animated: true, completion: nil)
                    case .serverErr:
                        
                        
                        let alertViewController = UIAlertController(title: "서버 에러", message: "서버 상태를 확인해주세요",
                                                                    preferredStyle: .alert)
                        let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                        alertViewController.addAction(action)
                        self.present(alertViewController, animated: true, completion: nil)
                    case .networkFail:
                        
                        
                        let alertViewController = UIAlertController(title: "", message: "업로드 완료",
                                                                    preferredStyle: .alert)
                        let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                        alertViewController.addAction(action)
                        self.present(alertViewController, animated: true, completion: nil)
                    }
                    
                    

                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "modifyLoad"), object: nil)


                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load2"), object: nil)

                    
                             
                             
                         }
                         
                           
                       

                
                
                                       
                print("==================================")
                print("공지 수정 할 때 서버에  넘겨주는 정보 ")
                print("categoryData : \(categoryData)")
                print("날짜 String : \(dateStr)")
                print("시작 시간 : \(startTime)")
                print("종료 시간 : \(endTime)")
                print("공지 제목 : \(title)")
                print("메모 내용 : \(content)")
                print("현재 공지의 idx : \(noticeIdx)")
                print("==================================")
            }


                       
                   }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    func setTimePicker()
    {
        timePicker.delegate = self
        timePicker.dataSource = self
        
        timePicker2.delegate = self
        timePicker2.dataSource = self
        
        
        startTimeTextField.tintColor = .clear
        endTImeTextField.tintColor = .clear
        
        startTimeTextField.inputView = timePicker
        endTImeTextField.inputView = timePicker2
        
        
        
        
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(doneTimePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancleTimePicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: true)
        
        toolbar.tintColor = .mainColor
        
        
        startTimeTextField.inputAccessoryView = toolbar
        endTImeTextField.inputAccessoryView = toolbar
  
    }
    
    
    

    
    
    @objc func doneTimePicker(){
    //For date formate
        
        

     self.view.endEditing(true)
      }
    
    @objc func cancleTimePicker(){
        //cancel button dismiss datepicker dialog
        self.view.endEditing(true)
    }
    
    
    func getNoticeDetailData(){
        
        NoticeDetailService.shared.getSubjectDetailNotice(noticeIdx: self.noticeIdx) { networkResult in // noticeIdx 정보 설정
            print("현재 notice IDX :\(self.noticeIdx)")

            switch networkResult{
                
                
            case .success(let noticeList, _):
                
                
                
                guard let noticeList = noticeList as? SubjectNoticeData else { return }
                
                //MARK:- 카테고리 설정
                
                self.setButttonClear()
                
                if self.editModeOn == 1
                {
                    if self.categoryIndex == 1
                        
                    {
                        if let hwSelected = UIImage(named: "chattingnoticePlusSelectedBtnAssignment")
                        {
                            self.hwNoticeButton.setImage(hwSelected, for: .normal)
                        }
                    }
                        
                    else if self.categoryIndex == 2
                    {
                        if let testUnselected = UIImage(named: "chattingnoticePlusUnselectedBtnExam"){
                            
                            self.testNoticeButton.setImage(testUnselected, for: .normal)
                            
                        }
                    }
                        
                    else
                    {
                        
                        if let classUnselected = UIImage(named: "chattingnoticePlusUnselectedBtnClass"){
                            
                            self.classNoticeButton.setImage(classUnselected, for: .normal)
                            
                            
                            
                            
                        }
                        
                    }
                    
                    
                    
                    //MARK:- 타이틀 설정
                    self.titleEditTextField.text = noticeList.title
                    
                    
                    // MARK:- 날짜 정보 설정
                    
                    print("날짜 정보 받아오기 : \(noticeList.date)")
                    let dateArray = noticeList.date.components(separatedBy: "-")
                    print("dataArray : \(dateArray)")
                    
                    
                    self.datePickerLabel.text = dateArray[0] + "년 " + dateArray[1] + "월 " + dateArray[2] + "일"
                    self.dateString = dateArray[0] + "-" + dateArray[1] + "-" +  dateArray[2]
                    
                    // MARK:- 시간 정보 설정
                    
                    
                    
                    
                    self.startTimeTextField.text = noticeList.startTime
                    self.endTImeTextField.text = noticeList.endTime
                    
                    if noticeList.startTime == "-1"
                    {
                        self.startTimeTextField.text = "시간정보없음"
                        
                    }
                    
                    if noticeList.endTime == "-1"
                    {
                        self.endTImeTextField.text = "시간정보없음"
                    }
                    
                    
                    
                    
                    //MARK:- 메모 정보 설정
                    
                    self.contentMemoTextFIeld.text = noticeList.content
                    
                    
                    
                }
                
                else
                {
                    
                    
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    self.dateString = formatter.string(from: self.datePicker.date)
                    
                }

                
                
                
                
                
            default:
                print("fail")
                
                
            }
            
              
          


              
          }
          
        
        
    }
    
    

    
    func setDataPicker()
    {
        datePicker.datePickerMode = .date
        datePickerLabel.tintColor = .clear
        
        
        
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        toolbar.tintColor = .mainColor
        
        datePickerLabel.inputAccessoryView = toolbar
        datePickerLabel.inputView = datePicker
    }
    
    
 
    
    
    @objc func donedatePicker(){
    //For date formate
     let formatter = DateFormatter()
    let formatter1 = DateFormatter()
     formatter.dateFormat = "yyyy년 MM월 dd일"
        formatter1.dateFormat = "yyyy-MM-dd"
    self.dateStr = formatter1.string(from: datePicker.date)
     datePickerLabel.text = formatter.string(from: datePicker.date)
        dateClicked = 1
     self.view.endEditing(true)
      }
    
    @objc func cancelDatePicker(){
        //cancel button dismiss datepicker dialog
        self.view.endEditing(true)
    }
    
    
    
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){

          self.view.endEditing(true)

    }



    @IBAction func hwNoticeButtonClicked(_ sender: Any) {
        
        categoryIndex = 1
        setButttonClear()
        if let hwSelected = UIImage(named: "chattingnoticePlusSelectedBtnAssignment")
        {
            self.hwNoticeButton.setImage(hwSelected, for: .normal)
        }
        
    }
    
    @IBAction func testButtonClicked(_ sender: Any) {
        
        categoryIndex = 2

        setButttonClear()
        if let testSelected = UIImage(named: "chattingnoticePlusSelectedBtnExam")
        {
            self.testNoticeButton.setImage(testSelected, for: .normal)
        }
    }
    
    @IBAction func classButtonClicked(_ sender: Any) {
        
        categoryIndex = 3

        setButttonClear()
        if let classSelected = UIImage(named: "chattingnoticePlusSelectedBtnClass")
        {
             self.classNoticeButton.setImage(classSelected, for: .normal)
        }
    }
    
    func setButttonClear() {
        
        
        if let hwUnselected = UIImage(named: "chattingnoticePlusUnselectedBtnAssignment"){
            
            self.hwNoticeButton.setImage(hwUnselected, for: .normal)

        }
        
        if let testUnselected = UIImage(named: "chattingnoticePlusUnselectedBtnExam"){
            
            self.testNoticeButton.setImage(testUnselected, for: .normal)
            
        }
        
        if let classUnselected = UIImage(named: "chattingnoticePlusUnselectedBtnClass"){
            
            self.classNoticeButton.setImage(classUnselected, for: .normal)
            
            
            
            
        }
        
        
        

    }
    
    
    
    
    
    
    
    
    
    func setBorder(){
        
  


        
        
        textAreaBorder.layer.borderWidth = 1.0
        textAreaBorder.layer.borderColor = UIColor.init(red: 230.0, green: 230.0, blue: 230.0, alpha: 1).cgColor
        
 
        
    }

}

extension NoticeEditModeViewController : UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0           //시작 시간 설정
        {
            return hourTimeArray.count
            
        }

        
        else                        //종료 시간 설정
        {
            return minuteTImeArray.count
        }
        

    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if component == 0
        {
            
            return hourTimeArray[row]
        }
        
        else
        {
            
            return minuteTImeArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        var result : String = ""

        
        if(component == 0)
        {
            
            
            
            hour = hourTimeArray[row]
            
            if row == 0
            {
                checkNotTIme = 1
            }
            
            minute = "00"
         
        }
        else
        {
            minute = minuteTImeArray[row]
    
        }

        
            result =  hour + ":" + minute
        
        if checkNotTIme == 1
        {
            result = "시간정보 없음"
            checkNotTIme = 0
        }

        
        
        if pickerView == timePicker{
            

            self.startTimeTextField.text = result
            
        }
        
        else {
            
            self.endTImeTextField.text = result
        }


    }
        

    
}







