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
    
    
    @IBOutlet weak var datePickerLabel: UITextField!
    
    let datePicker = UIDatePicker()
    let timePicker = UIPickerView()
    let timePicker2 = UIPickerView()
    var categoryIndex : Int = 0
    var hour : String = ""
    var minute : String = ""
    var checkNotTIme : Int = 0
    @IBAction func closeButtonClicked(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setBorder()
        setButttonClear()
        setTimePicker()
        setDataPicker()

    }
    
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        
        
        // 여기에 내용 수정 된 코드가 들어가야 함
        if titleEditTextField.text == ""
        {
            let alert = UIAlertController(title: "", message: "제목을 설정해주세요", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "확인", style: .default, handler : nil )

            alert.addAction(okAction)

            present(alert, animated: true, completion: nil)
            
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
     formatter.dateFormat = "yyyy년 MM월 dd일"
     datePickerLabel.text = formatter.string(from: datePicker.date)
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







