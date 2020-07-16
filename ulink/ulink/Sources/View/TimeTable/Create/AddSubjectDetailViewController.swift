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
    func didDeleteTimeInfo(num : Int)
}

class AddSubjectDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, SubjectTimeInfoCellDelegate, AddTimeInfoCellDelegate, CustomPickerViewDelegate{

    public var delegate: AddSubjectDetailDelegate?
    
    public var timeInfoList = [TimeInfoModel]()
    public let defatulTimeInfoTableViewHeight = 46
    private var subjectName = ""
    private var editTimeInfoIdx = 0
    public var isFromDrag = false

    
    @IBOutlet weak var subjectTimeInfoTableView: UITableView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
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
        
        directNameTextField.text = subjectName
        
        clubBtn.setImage(UIImage(named: "timetableaddTextfieldBtnCircleSelected"), for: .normal)
        
    }
    
    @IBAction func clickPartTime(_ sender: Any) {
        resetButton()
        directNameTextField.text = ""
        subjectName = "알바"
        
        directNameTextField.text = subjectName
        
         partTimeBtn.setImage(UIImage(named: "timetableaddTextfieldBtnParttimejobSelected"), for: .normal)
    }
    
    @IBAction func clickStudy(_ sender: Any) {
        resetButton()
        directNameTextField.text = ""
        subjectName = "스터디"
        
        directNameTextField.text = subjectName
        
         studyBtn.setImage(UIImage(named: "timetableaddTextfieldBtnStudySelected"), for: .normal)
    }
    
    @IBAction func clickStudentClub(_ sender: Any) {
        resetButton()
        directNameTextField.text = ""
        subjectName = "학생회"
        
        directNameTextField.text = subjectName
        
        studentClubBtn.setImage(UIImage(named: "timetableaddTextfieldBtnStudentclubSelected"), for: .normal)
    }
    
    @IBAction func clickLesson(_ sender: Any) {
        resetButton()
        directNameTextField.text = ""
        subjectName = "과외"
        
        directNameTextField.text = subjectName
        
        lessonBtn.setImage(UIImage(named: "timetableaddTextfieldBtnTutorSelected"), for: .normal)
    }
    
    @IBAction func clickAcademy(_ sender: Any) {
        resetButton()
        directNameTextField.text = ""
        subjectName = "학원"
        
        directNameTextField.text = subjectName
        
        academyBtn.setImage(UIImage(named: "timetableaddTextfieldBtnAcademySelected"), for: .normal)
    }
    
    @IBAction func clickWork(_ sender: Any) {
        resetButton()
        directNameTextField.text = ""
        subjectName = "근로"
        
        directNameTextField.text = subjectName
        
        workBtn.setImage(UIImage(named: "timetableaddTextfieldBtnWorkSelected"), for: .normal)
    }
    
    @IBAction func clickVolunteer(_ sender: Any) {
        resetButton()
        directNameTextField.text = ""
        subjectName = "봉사"
        
        directNameTextField.text = subjectName
        
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
                
                let subject = SubjectModel.init(subjectName: subjectName, content: [detailTextField.text ?? ""], subjectDay: [timeInfoList[i].weekDay], startTime: [timeInfoList[i].startTime], endTime: [timeInfoList[i].endTime], textColor: UIColor.white, backgroundColor: 1)
            
                subjectList.append(subject)
            }
            
            delegate?.didPressOkButton(timeInfoList: subjectList)
            dismiss(animated: true, completion: nil)
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        subjectTimeInfoTableView.bounces = false
        directNameTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        directNameTextField.addTarget(self, action: #selector(textFieldEditStart(textField:)), for: .touchDown)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard)))

    
        
        subjectTimeInfoTableView.delegate = self
        subjectTimeInfoTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification : Notification){
        if let keyboardSize = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
               
            self.bottomConstraint.constant = keyboardSize.height

           UIView.animate(withDuration: 0 , animations: {
               self.view.layoutIfNeeded()

           }, completion: nil)
            
        }
    }
    
    @objc func keyboardWillHide(notification: Notification){
           
        self.bottomConstraint.constant = 0
        self.view.layoutIfNeeded()
           
    }
    
    @objc func dismissKeyBoard(){
        self.view.endEditing(true)
    }
    
    
    public func setTimeInfo(list : [TimeInfoModel]){
        
        timeInfoList = list.sorted(by: {$0.weekDay < $1.weekDay})
        
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
        if isFromDrag {
            return timeInfoList.count
        } else {
            return timeInfoList.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if !isFromDrag {
            if timeInfoList.count == 0 || indexPath.row == timeInfoList.count {
                
                guard let addTimeInfoCell : AddTimeInfoCell = subjectTimeInfoTableView.dequeueReusableCell(withIdentifier: "addTimeInfoCell", for: indexPath) as? AddTimeInfoCell else {return AddTimeInfoCell()}
                
                addTimeInfoCell.delegate = self
                
                return addTimeInfoCell
                
            } else {
                guard let subjectTimeInfoCell : SubjectTimeInfoCell = subjectTimeInfoTableView.dequeueReusableCell(withIdentifier: "subjectTimeInfoCell", for: indexPath) as? SubjectTimeInfoCell else {return SubjectTimeInfoCell()}
                     
                let data = timeInfoList[indexPath.row]
                  
                subjectTimeInfoCell.setTimeInfoText(weekDay: data.weekDay, start: data.startTime, end: data.endTime)
                
                if(timeInfoList.count == 1){
                    subjectTimeInfoCell.hideTrash()
                }else {
                    subjectTimeInfoCell.showTrash()
                }
                
                if indexPath.row == timeInfoList.count - 1 {
                    subjectTimeInfoCell.removeBottomBorder()
                }
                
                subjectTimeInfoCell.selectionStyle = .none
                subjectTimeInfoCell.delegate = self
                subjectTimeInfoCell.setNum(num: indexPath.row)
                
                return subjectTimeInfoCell
            }
        }else {
            guard let subjectTimeInfoCell : SubjectTimeInfoCell = subjectTimeInfoTableView.dequeueReusableCell(withIdentifier: "subjectTimeInfoCell", for: indexPath) as? SubjectTimeInfoCell else {return SubjectTimeInfoCell()}
                 
            let data = timeInfoList[indexPath.row]
              
            subjectTimeInfoCell.setTimeInfoText(weekDay: data.weekDay, start: data.startTime, end: data.endTime)
            
            if(timeInfoList.count == 1){
                subjectTimeInfoCell.hideTrash()
            }else {
                subjectTimeInfoCell.showTrash()
            }
            
            if indexPath.row == timeInfoList.count - 1 {
                subjectTimeInfoCell.removeBottomBorder()
            }
            
            subjectTimeInfoCell.selectionStyle = .none
            subjectTimeInfoCell.delegate = self
            subjectTimeInfoCell.setNum(num: indexPath.row)
            
            return subjectTimeInfoCell
        }
        
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
    
    func didPressEditButton(_ idx: Int) {
        
        print("edit 버튼에서 idx", idx)
        self.editTimeInfoIdx = idx
        
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "customPickerViewController") as? CustomPickerViewController else { return }
        nextVC.delegate = self
        nextVC.isEdit = true

        self.present(nextVC, animated: true, completion: nil)
    }
    
    func didPressAddBtn(idx: Int) {
        
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "customPickerViewController") as? CustomPickerViewController else { return }
        nextVC.delegate = self
         nextVC.isEdit = false

        self.present(nextVC, animated: true, completion: nil)
    }
    
    
    func removeTimeInfoCell(tag: Int){
    
        let indexPath = IndexPath(row: tag, section: 0)
        print("tag: \(tag)")

//        var removeIdx = 0
//
//        for i in 0 ... timeInfoList.count - 1 {
//            if timeInfoList[i].timeIdx == tag {
//                removeIdx = i
//                 print("removeIdx : \(removeIdx)")
//            }
//        }
        
        timeInfoList.remove(at: tag)
        
        delegate?.didDeleteTimeInfo(num: tag)
        subjectTimeInfoTableView.deleteRows(at: [indexPath], with: .fade)
        subjectTimeInfoTableView.reloadData()
    }
    
    func didPressOkBtn(selectWeekDay: Int?, startHour: String, startMin: String, endHour: String, endMin: String, isEdit: Bool) {
        
        let timeInfo = TimeInfoModel(timeIdx: self.editTimeInfoIdx, weekDay: selectWeekDay!, startTime:startHour + ":" + startMin , endTime: endHour + ":" + endMin)
        
        if(isEdit) {
            timeInfoList[self.editTimeInfoIdx] = timeInfo
        }else {
            timeInfoList.append(timeInfo)
        }
        
        self.subjectTimeInfoTableView.reloadData()
    }
    
    // recognizer
    @objc func textFieldDidChange(textField: UITextField){
        if textField.text != "" {
            subjectName = textField.text!
            
            resetButton()
        }
    }
    
    @objc func textFieldEditStart(textField : UITextField){
        resetButton()
    }
    
}

