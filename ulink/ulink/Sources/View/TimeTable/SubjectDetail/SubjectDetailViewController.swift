//
//  SubjectDetailViewController.swift
//  ulink
//
//  Created by 양시연 on 2020/07/14.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class SubjectDetailViewController: UIViewController {
    
    @IBOutlet var topView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var detailBackgroundView: UIView!
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var subjectNameLabel: UILabel!
    @IBOutlet weak var subjectTimeInfoLabel: UILabel!
    @IBOutlet weak var subjectMemoInfoLabel: UILabel!
    
    private var subjectColorCode = 0
    private var subjectName = ""
    private var subjectTimeInfo = ""
    private var subjectMemo = ""
    private var subjectProfessor = ""
    

    public func setDataForSubject(idx: Int, colorCode: Int, name: String, day: [Int], dateTime: [String], room: String, professor: String){
        
        subjectColorCode = colorCode
        subjectName = name
        subjectTimeInfo = makeToTimeInfoFormat(day: day, dateTime: dateTime)
        subjectMemo = room + ", " + professor + " 교수"
        
    }

    private func makeToTimeInfoFormat(day : [Int], dateTime : [String]) -> String {
           
        var result = ""
           
           for i in 0 ... day.count - 1 {
               switch day[i] {
               case 0:
                   result += "월 "
                   break
               case 1:
                   result += "화 "
                   break
               case 2:
                   result += "수 "
                   break
               case 3:
                   result += "목 "
                   break
               case 4:
                   result += "금 "
                   break
               case 5:
                   result += "토 "
                   break
               default:
                   result += "월 "
                   break
               }
               
               result += dateTime[i].split(separator: "-")[0]
               result += " - "
               result += dateTime[i].split(separator: "-")[1]
               
               if i != day.count - 1 {
                   result += ", "
               }
           }
           
        return result
           
    }
        
    public func setDataForPersonal(){
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailBackgroundView.layer.cornerRadius = 30
        colorView.layer.cornerRadius = 8
        setLabels()

        // Do any additional setup after loading the view.
    }
    
    private func setLabels(){
        colorView.backgroundColor = ColorFilter.init().getColor(colorCode: subjectColorCode)
        subjectNameLabel.text = subjectName
        subjectTimeInfoLabel.text = subjectTimeInfo
        subjectMemoInfoLabel.text = subjectMemo
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view != backgroundView {
           return
        }
    
         dismiss(animated: true, completion: nil)
    }
    
}
