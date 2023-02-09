//
//  SignupExistingRegistrationViewController.swift
//  FirstPass
//
//  Created by MacOS on 25/10/22.
//  Copyright © 2022 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class SignupExistingRegistrationViewController: UIViewController, DatePickerDelegate {
    func selectedDate(date: String) {
        dateofBirthTextield.text = date
    }
    
    func cancelDateSelection() {
        
    }
    

    @IBOutlet weak var emiratedIdTextfield: UITextField!
    
    @IBOutlet weak var dateofBirthTextield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        dateofBirthTextield.addRightView(imageName: "calendar")
        dateofBirthTextield.delegate = self
    }

    @IBAction func nextButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Modified", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ExsitingInfoLoadingViewController") as! ExsitingInfoLoadingViewController
        vc.modalPresentationStyle = .fullScreen
        vc.emiratesID = emiratedIdTextfield.text!
        vc.dob = dateofBirthTextield.text!
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }

}

extension SignupExistingRegistrationViewController:UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        if textField==dateofBirthTextield{
//            return false
//        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == dateofBirthTextield{
            self.view.endEditing(true)
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let popup = storyboard.instantiateViewController(withIdentifier: "DatePickerViewController") as! DatePickerViewController
        popup.isTimePicker = false
        popup.modalPresentationStyle = .overCurrentContext
        popup.delegate = self
        present(popup, animated: true, completion: nil)
        }
    }
}
