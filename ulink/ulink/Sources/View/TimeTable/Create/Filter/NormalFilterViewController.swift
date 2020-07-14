//
//  NormalFilterViewController.swift
//  ulink
//
//  Created by 송지훈 on 2020/07/14.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class NormalFilterViewController: UIViewController {

    // MARK:- 요일 지정 부분 월~금 버튼 아울렛

    var dayIsSelected : [Int] = [0,0,0,0,0]
    
    
    
    @IBOutlet var setDayButtonCollection: [UIButton]!
    

    //MARK:- 공강지정 부분 월~금 버튼 아울렛

    @IBOutlet weak var setMondayOffButton: UIButton!
    @IBOutlet weak var setTuesdayOffButton: UIButton!
    @IBOutlet weak var setWednesdayOffButton: UIButton!
    @IBOutlet weak var setThursdayOffButton: UIButton!
    @IBOutlet weak var setFridayOffButton: UIButton!
    
    @IBOutlet var setDayOffButtonCollection: [UIButton]!
    
    var dayOffIsSelected : [Int] = [0,0,0,0,0]
    
    
    
    //MARK:- 1교시 제외

    @IBOutlet weak var firstClassDayOffSwitch: UISwitch!
    
    var firstClassOff : Bool = false
    
    
    //MARK:- 수강학점 부분 1~4점 버튼 아울렛
    @IBOutlet weak var gradeOneButton: UIButton!
    @IBOutlet weak var gradeTwoButton: UIButton!
    @IBOutlet weak var gradeThreeButton: UIButton!
    @IBOutlet weak var gradeFourButton: UIButton!
    
    var gradeButtonSelected : [Int] = [0,0,0,0]
   
    
    @IBOutlet var setGradeButtonCollection: [UIButton]!
    
    
    //MARK:- Life Cycle 부분
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK:- 헤더 버튼들
    
    @IBAction func closeButtonClicked(_ sender: Any) { // X 버튼 눌렀을 때,
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetButtonClicked(_ sender: Any) { // '초기화' 버튼 눌렀을 때
        
        resetGrade()
        resetDayPart()
        resetDayOffPart()
        self.firstClassDayOffSwitch.isOn = false
    }
    
    
    @IBAction func confirmButtonClicked(_ sender: Any) { // '확인' 버튼 눌렀을 때
        
        
    }
    
    
    //MARK:- 필터 내 초기화 버튼들
    
    @IBAction func dayResetButtonClicked(_ sender: Any) { // 요일 지정 - 전체 취소 버튼 눌렀을 때
        
        resetDayPart()
    }
    
    @IBAction func scoreResetButtonClicked(_ sender: Any) { // 수강 학점 - 전체 취소 버튼 눌렀을 때
        
        
        resetGrade()
    }
    
    
    
    
    
    
    
//
//    if let classSelected = UIImage(named: "chattingnoticePlusSelectedBtnClass")
//    {
//         self.classNoticeButton.setImage(classSelected, for: .normal)
//    }
//
    
    
    //MARK:- 요일 지정 부분 함수들
    
    
    func resetDayPart() // 요일 지정 버튼 전부 초기화
    {
        
        //ioMainFiltersettingMonUnselected
        //ioMainFiltersettingTueUnselected
        
        var imageName : String = "ioMainFiltersetting"
        let dayArray : [String] = ["Mon","Tue","Wed","Thu","Fri"]
        var count : Int = 0
        
        
        
        for item in self.setDayButtonCollection
        {
            
//            ioMainFiltersettingbtnWedSelected
            imageName = "ioMainFiltersettingBtn"
            imageName = imageName + dayArray[count] + "Unselected"

               
            if let img = UIImage(named: imageName)
            {
                
               
                
                self.dayIsSelected[count] = 0
                
                item.setImage(img, for: .normal)
                
           
                
            }

                 count = count + 1
            
            

        }
        
        
 
    }

    func resetDayOffPart(){ // 공강 지정 버튼 올 초기화

        
        
        var imageName : String = "ioMainFiltersettingBtn"

        let dayArray : [String] = ["Mon","Tue","Wed","Thu","Fri"]
        var count : Int = 0
        
        
        
        
        
        for item in self.setDayOffButtonCollection
        {
            imageName = "ioMainFiltersettingBtn"
            
            imageName = imageName + dayArray[count] + "emptyUnselected"
            
            self.dayOffIsSelected[count] = 0
            
            if let img = UIImage(named: imageName)
            {
                
                item.setImage(img, for: .normal)
                
             
            }
            count = count + 1
        
        }


    }
    
    
    //ioMainFiltersettingGrade1Unselected
    func resetGrade() { // 수강확정 버튼 올 초기화
        
        
        
        var imageName : String = "ioMainFiltersettingGrade"

        let dayArray : [String] = ["1","2","3","4"]
        var count : Int = 0
        
        
        
        
        
        for item in self.setGradeButtonCollection
        {
            imageName = "ioMainFiltersettingGrade"
            
            
            imageName = imageName + dayArray[count] + "Unselected"
            
            if let img = UIImage(named: imageName)
            {
                
                item.setImage(img, for: .normal)
                
                count = count + 1
            }
        
        }

        
        }
    
    
    
    
    //MARK:- 각 버튼 액션 부분
    
    
    //MARK:- 요일 지정 버튼 액션 부분


    @IBAction func setMondayButtonClicked(_ sender: Any) {
        
        if let button = sender as? UIButton {

             setDayButtonClicked(button: button,index: 0)
         }
    }
    
    
    @IBAction func setTuesdayButtonClicked(_ sender: Any) {
        
        if let button = sender as? UIButton {

            setDayButtonClicked(button: button,index: 1)
        }
        
        
        
    }
    
    
    @IBAction func setWednesdayButtonClicked(_ sender: Any) {
        
        if let button = sender as? UIButton {

                setDayButtonClicked(button: button,index: 2)
            }
    }
    
    
    @IBAction func setThursdayButtonClicked(_ sender: Any) {
        
        if let button = sender as? UIButton {

                setDayButtonClicked(button: button,index: 3)
            }
    }
    
    
    
    @IBAction func setFridayButtonClicked(_ sender: Any) {
        
        if let button = sender as? UIButton {

                setDayButtonClicked(button: button,index: 4)
            }
    }
    
    
    
    
    
    
    func setDayButtonClicked(button : UIButton, index : Int)
    {
        
        
        var day : String = ""
        
        var imageTitle = "ioMainFiltersettingBtn"
        
        
        switch index {
            
        case 0 :
            day = "Mon"
            break
            
        case 1:
            day = "Tue"
            break
            
        case 2:
            day = "Wed"
            break
            
        case 3:
            day = "Thu"
            break
            
        case 4:
            day = "Fri"
            break
            
        default :
            
            break
            
        }
        
        imageTitle = imageTitle + day
        
        

        if dayIsSelected[index] == 0
        {
             dayIsSelected[index] = 1
            imageTitle = imageTitle + "Selected"
            if let image = UIImage(named: imageTitle){
                button.setImage(image, for: .normal)
                
               
                
            }

        }

        else if dayIsSelected[index] == 1{
            
            dayIsSelected[index] = 0
            
        
            
            imageTitle = imageTitle + "Unselected"
            if let image = UIImage(named: imageTitle){
                button.setImage(image, for: .normal)
                
                
                
            }
            

            
        }
        
        
    }
    
    
    
    
    //MARK:- 공강지정 함수 부분
    
    
    
    @IBAction func setMondayOffButtonClicked(_ sender: Any) {
        
        
        
        if let button = sender as? UIButton {

                setDayOffButtonClicked(button: button,index: 0)
            }

    }
    
    @IBAction func setTuesdayOffButtonClicked(_ sender: Any) {
        
        if let button = sender as? UIButton {

                setDayOffButtonClicked(button: button,index: 1)
            }
    }
    
    
    @IBAction func setWednesdayOffButtonClicked(_ sender: Any) {
        
        if let button = sender as? UIButton {

                setDayOffButtonClicked(button: button,index: 2)
            }
    }
    
    @IBAction func setThursdayOffButtonClicked(_ sender: Any) {
        
        if let button = sender as? UIButton {

                setDayOffButtonClicked(button: button,index: 3)
            }
    }
    
    @IBAction func setFridayOffButtonClicked(_ sender: Any) {
        
        if let button = sender as? UIButton {

                setDayOffButtonClicked(button: button,index: 4)
            }
    }
    

    func setDayOffButtonClicked(button : UIButton, index : Int)
    {
        resetDayOffPart()
        
        
        
        var day : String = ""
        
        var imageTitle = "ioMainFiltersettingBtn"
        
        
        switch index {
            
        case 0 :
            day = "Mon"
            break
            
        case 1:
            day = "Tue"
            break
            
        case 2:
            day = "Wed"
            break
            
        case 3:
            day = "Thu"
            break
            
        case 4:
            day = "Fri"
            break
            
        default :
            
            break
            
        }
        
        imageTitle = imageTitle + day
        
        

        if dayOffIsSelected[index] == 0
        {
             dayOffIsSelected[index] = 1
            imageTitle = imageTitle + "emptySelected"
            if let image = UIImage(named: imageTitle){
                button.setImage(image, for: .normal)
                
               
                
            }

        }

        else if dayOffIsSelected[index] == 1{
            
            
            dayOffIsSelected[index] = 0
            
        
            
            imageTitle = imageTitle + "emptyUnselected"
            if let image = UIImage(named: imageTitle){
                button.setImage(image, for: .normal)
                
                
                
            }
            

            
        }
        
        
        
        
    }
    
    
    
    //MARK:- 수강 학점 부분
    
    @IBAction func setGradeOneButtonClicked(_ sender: Any) {
        
        if let button = sender as? UIButton {

                setGradeButtonClicked(button: button,index: 0)
            }
    }
    
    
    @IBAction func setGradeTwoButtonClicked(_ sender: Any) {
        if let button = sender as? UIButton {

                setGradeButtonClicked(button: button,index: 1)
            }
    }
    
    
    @IBAction func setGradeThreeButtonClicked(_ sender: Any) {
        
        if let button = sender as? UIButton {

                setGradeButtonClicked(button: button,index: 2)
            }
    }
    
    
    @IBAction func setGradeFourButtonClicked(_ sender: Any) {
        
        if let button = sender as? UIButton {

                setGradeButtonClicked(button: button,index: 3)
            }
    }
    
    
    
    func setGradeButtonClicked(button : UIButton, index : Int)
      {

          
          

          
          var number : String = ""
          
          var imageTitle = "ioMainFiltersetting"
          
          
          switch index {
              
          case 0 :
              number = "Grade1"
              break
              
          case 1:
              number = "Grade2"
              break
              
          case 2:
              number = "Grade3"
              break
              
          case 3:
              number = "Grade4"
              break
              

          default :
              
              break
              
          }
          
          imageTitle = imageTitle + number
          
          

          if gradeButtonSelected[index] == 0
          {
               gradeButtonSelected[index] = 1
              imageTitle = imageTitle + "Selected"
              if let image = UIImage(named: imageTitle){
                  button.setImage(image, for: .normal)
                  
                 
                  
              }

          }

          else if gradeButtonSelected[index] == 1{
              
              
              gradeButtonSelected[index] = 0
              
          
              
              imageTitle = imageTitle + "Unselected"
              if let image = UIImage(named: imageTitle){
                  button.setImage(image, for: .normal)
                  
                  
                  
              }
              

              
          }
    
    
    }
    
}
    
