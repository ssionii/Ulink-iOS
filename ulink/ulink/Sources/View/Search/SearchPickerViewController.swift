//
//  SearchPickerViewController.swift
//  ulink
//
//  Created by SeongEun on 2020/07/14.
//  Copyright © 2020 송지훈. All rights reserved.
//

import UIKit

class SearchPickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet weak var searchTypePickerView: UIPickerView!
    private let pickerValues: [String] = ["과목명","교수명"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchTypePickerView.delegate = self
        searchTypePickerView.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { return pickerValues[row] }

}
