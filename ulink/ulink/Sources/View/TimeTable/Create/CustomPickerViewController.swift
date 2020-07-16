//
//  CustomPickerViewController.swift
//  ulink
//
//  Created by 양시연 on 2020/07/14.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

protocol CustomPickerViewDelegate {
    func didPressOkBtn(selectWeekDay : Int?, startHour: String, startMin: String, endHour: String, endMin: String, isEdit : Bool)
}

class CustomPickerViewController: UIViewController, UIPickerViewDelegate ,UIPickerViewDataSource {
   
    @IBOutlet weak var customPickerView: UIPickerView!
    @IBOutlet weak var botConstraint: NSLayoutConstraint!
    
    public var delegate : CustomPickerViewDelegate?
    
    public var isEdit = false
    
    private let viewHeight: CGFloat = 350
    private let hideBotViewHeight : CGFloat = 294
    
    private var selectedWeekDay = 1
    private var startHour = "09"
    private var startMin = "00"
    private var endHour = "10"
    private var endMin = "00"
    
    let weekDay : [String] = ["월", "화", "수", "목", "금"]
    let hour : [String] = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"]
    let min : [String] = ["00", "15", "30", "45"]

    private let isDismiss = false
    
    @IBAction func cancelBtn(_ sender: UIButton){
       disAppearAnim()
    }
    
    @IBAction func okBtn(_ sender: UIButton) {
        self.delegate?.didPressOkBtn(selectWeekDay: selectedWeekDay, startHour: startHour, startMin: startMin, endHour: endHour, endMin: endMin, isEdit: isEdit)
        
        disAppearAnim()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customPickerView.dataSource = self
        customPickerView.delegate = self
        
         setCustomPickerView()
       
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool){
        isDismiss ? disAppearAnim() : appearAnim()
    }
    
    func appearAnim(){
          self.botConstraint.constant = hideBotViewHeight - viewHeight
          UIView.animate(withDuration: 0.3){
              self.view.layoutIfNeeded()
          }
      }

    func disAppearAnim(){
        self.botConstraint.constant = -self.viewHeight
        UIView.animate(withDuration: 0.3){
            self.view.layoutIfNeeded()
        }
          
        dismiss(animated: true)
    }
    
    private func setCustomPickerView(){
        customPickerView.selectRow(0, inComponent: 0, animated: true)
        customPickerView.selectRow(8, inComponent: 2, animated: true)
        customPickerView.selectRow(0, inComponent: 3, animated: true)
        customPickerView.selectRow(9, inComponent: 5, animated: true)
        customPickerView.selectRow(0, inComponent: 6, animated: true)
    }
    
    
    // protocol
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 7
       }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
            case 0:
                return weekDay.count
            case 1, 4:
                return 0
            case 2, 5:
                return 23
            case 3, 6:
                return 4
            default:
                return 0
        }
    }
        

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        if component == 0 {
            return weekDay[row]
        }else if (component == 2 || component == 5){
            return hour[row]
        }else if (component == 3 || component == 6){
            return min[row]
        }else {
            return ""
        }
        
    }


    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch component {
            case 0:
                selectedWeekDay = row + 1
                break
            case 2:
                startHour = hour[row]
                break
            case 5:
                endHour = hour[row]
                break
            case 3:
                startMin = min[row]
                break
            case 6:
                endMin = min[row]
                break
            default:
                break
        }
    }

}
