//
//  AddSubjectDetailViewController.swift
//  ulink
//
//  Created by 양시연 on 2020/07/10.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

protocol AddSubjectDetailDelegate {
    func didPressOkButton(timeInfoList : [SubjectModel])
}

class AddSubjectDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, SubjectTimeInfoCellDelegate {
    
    public var delegate: AddSubjectDetailDelegate?
    
    public var timeInfoList : [TimeInfoModel] = []
    public let defatulTimeInfoTableViewHeight = 46
    private var subjectName = ""
    
    @IBOutlet weak var subjectTimeInfoTableView: UITableView!
    @IBOutlet weak var subjectTimeInfoTableViewHeight: NSLayoutConstraint!
    
    // 간편 제목 설정 버튼
    @IBOutlet weak var clubBtn: UIButton!
    @IBOutlet weak var partTimeBtn: UIButton!
    @IBOutlet weak var studyBtn: UIButton!
    @IBOutlet weak var studentClubBtn: UIButton!
    @IBOutlet weak var lessonBtn: UIButton!
    @IBOutlet weak var academyBtn: UIButton!
    @IBOutlet weak var workBtn: UIButton!
    @IBOutlet weak var volunteerBtn: UIButton!
    
    @IBOutlet weak var directNameTextField: UITextField!
    @IBOutlet weak var detailTextField: UITextField!
    
    
    @IBAction func clickClub(_ sender: Any) {
        resetButton()
        directNameTextField.text = ""
        subjectName = "동아리"
        
        clubBtn.setImage(UIImage(named: "timetableaddTextfieldBtnCircleSelected"), for: .normal)
        
    }
    
    @IBAction func clickPartTime(_ sender: Any) {
        resetButton()
         directNameTextField.text = ""
        subjectName = "알바"
        
         partTimeBtn.setImage(UIImage(named: "timetableaddTextfieldBtnParttimejobSelected"), for: .normal)
    }
    
    @IBAction func clickStudy(_ sender: Any) {
        resetButton()
        directNameTextField.text = ""
          subjectName = "스터디"
        
         studyBtn.setImage(UIImage(named: "timetableaddTextfieldBtnStudySelected"), for: .normal)
    }
    
    @IBAction func clickStudentClub(_ sender: Any) {
        resetButton()
        directNameTextField.text = ""
          subjectName = "학생회"
        
        studentClubBtn.setImage(UIImage(named: "timetableaddTextfieldBtnStudentclubSelected"), for: .normal)
    }
    
    @IBAction func clickLesson(_ sender: Any) {
        resetButton()
        directNameTextField.text = ""
          subjectName = "과외"
        
        lessonBtn.setImage(UIImage(named: "timetableaddTextfieldBtnTutorSelected"), for: .normal)
    }
    
    @IBAction func clickAcademy(_ sender: Any) {
        resetButton()
        directNameTextField.text = ""
          subjectName = "학원"
        
        academyBtn.setImage(UIImage(named: "timetableaddTextfieldBtnAcademySelected"), for: .normal)
    }
    
    @IBAction func clickWork(_ sender: Any) {
        resetButton()
        directNameTextField.text = ""
          subjectName = "근로"
        
        workBtn.setImage(UIImage(named: "timetableaddTextfieldBtnWorkSelected"), for: .normal)
    }
    
    @IBAction func clickVolunteer(_ sender: Any) {
        resetButton()
        directNameTextField.text = ""
          subjectName = "봉사"
        
        volunteerBtn.setImage(UIImage(named: "timetableaddTextfieldBtnVolunteerSelected"), for: .normal)
    }
    
    
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmBtn(_ sender: UIButton) {
        
        
        if subjectName == "" {
            let alert = UIAlertController(title: nil, message: "제목을 설정해주세요.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }else{
            // Todo: 통신
            
            var subjectList = [SubjectModel]()
            
            for i in 0 ... timeInfoList.count - 1 {
                
                let subject = SubjectModel(subjectName: subjectName, roomName:detailTextField.text ?? "" , subjectDay: timeInfoList[i].weekDay, startTime: timeInfoList[i].startTime, endTime: timeInfoList[i].endTime, textColor: UIColor.white, backgroundColor:1)
                
                subjectList.append(subject)
            }
            
            delegate?.didPressOkButton(timeInfoList: subjectList)
            dismiss(animated: true, completion: nil)
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        subjectTimeInfoTableView.bounces = false
        subjectTimeInfoTableViewHeight.constant = CGFloat(defatulTimeInfoTableViewHeight * timeInfoList.count) + 357
        
        directNameTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)

        
        subjectTimeInfoTableView.delegate = self
        subjectTimeInfoTableView.dataSource = self
    }
    
    public func setTimeInfo(list : [TimeInfoModel]){
        timeInfoList = list
    }

    
    public func resetButton(){
        clubBtn.setImage(UIImage(named: "timetableaddTextfieldBtnCircleUnselected"), for: .normal)
        partTimeBtn.setImage(UIImage(named: "timetableaddTextfieldBtnParttimejobUnselected"), for: .normal)
        studyBtn.setImage(UIImage(named: "timetableaddTextfieldBtnStudyUnselected"), for: .normal)
        studentClubBtn.setImage(UIImage(named: "timetableaddTextfieldBtnStudentclubUnselected"), for: .normal)
        lessonBtn.setImage(UIImage(named: "timetableaddTextfieldBtnTutorUnselected"), for: .normal)
        academyBtn.setImage(UIImage(named: "timetableaddTextfieldBtnAcademyUnselected"), for: .normal)
        workBtn.setImage(UIImage(named: "timetableaddTextfieldBtnWorkUnselected"), for: .normal)
        volunteerBtn.setImage(UIImage(named: "timetableaddTextfieldBtnVoluteerUnselected"), for: .normal)
        
    }
    

    
    // protocol
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeInfoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let subjectTimeInfoCell : SubjectTimeInfoCell = subjectTimeInfoTableView.dequeueReusableCell(withIdentifier: "subjectTimeInfoCell", for: indexPath) as? SubjectTimeInfoCell else {return SubjectTimeInfoCell()}
             
        let data = timeInfoList[indexPath.row]
          
        subjectTimeInfoCell.setTimeInfoText(weekDay: data.weekDay, start: data.startTime, end: data.endTime)
        
        if indexPath.row == 0 && timeInfoList.count == 1 {
            subjectTimeInfoCell.hideTrash()
        }
        
        if indexPath.row == timeInfoList.count - 1 {
            print("last")
            subjectTimeInfoCell.removeBottomBorder()
        }
        
        subjectTimeInfoCell.selectionStyle = .none
        subjectTimeInfoCell.delegate = self
        subjectTimeInfoCell.setNum(num: indexPath.row)
        
        return subjectTimeInfoCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(defatulTimeInfoTableViewHeight)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func didPressDeleteButton(_ tag: Int, message:String?) {
        
        let messageInput =  (message ?? "") + "\n시간을 삭제하시겠습니까?"
        
        let alert = UIAlertController(title: nil, message:messageInput, preferredStyle: UIAlertController.Style.alert)

        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive,
                   handler: { (_) in
                    self.removeTimeInfoCell(tag: tag)
                       
        })

        alert.addAction(cancelAction)
        alert.addAction(deleteAction)

        self.present(alert, animated: true, completion: nil)
       
    }
    
    func removeTimeInfoCell(tag: Int){
    
        let indexPath = IndexPath(row: tag, section: 0)
               print("tag: \(tag)")

               timeInfoList.remove(at: tag)
               subjectTimeInfoTableView.deleteRows(at: [indexPath], with: .fade)
               
              subjectTimeInfoTableView.reloadData()
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        if textField.text != "" {
            subjectName = textField.text!
            
            resetButton()
        }
    }
    
}

