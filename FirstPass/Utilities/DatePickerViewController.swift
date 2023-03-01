//
//  DatePickerViewController.swift
//  DatePicker
//
//  Created by SkeinTechnologies on 23/10/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    var delegate:DatePickerDelegate?
    @IBOutlet weak var datePicker: UIDatePicker!
    var isTimePicker = false
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        // Do any additional setup after loading the view.
        
        if isTimePicker{
            datePicker.datePickerMode = .time
        }else{
            datePicker.datePickerMode = .date
            if #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .compact
            } else {
                // Fallback on earlier versions
            }
        }
    }
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        delegate?.cancelDateSelection()
    }
    @IBAction func doneAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: datePicker.date)
        print(dateString)
        delegate?.selectedDate(date: dateString)
    }
    @IBAction func dateChanged(_ sender: Any) {
    }
}



protocol DatePickerDelegate {
    func selectedDate(date:String)
    func cancelDateSelection()
}
