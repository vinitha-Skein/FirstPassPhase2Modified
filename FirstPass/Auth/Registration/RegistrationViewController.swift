//
//  RegistrationViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 07/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit
import FlagPhoneNumber


class RegistrationViewController: UIViewController {
    
    @IBOutlet var mobile: FPNTextField!
    @IBOutlet weak var mrnIDTextFeild: UITextField!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var emiratesID: UITextField!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var checkBox: UIButton!
    var checkBoxState = Bool()
    var validation = Validation()
    var viewModel = RegisterUserViewModel()
    var mobileNumber = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        mobile.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func agreeTerms(_ sender: Any)
    {
        checkBoxState = !checkBoxState
        checkBox.setImage(checkBoxState == true ? UIImage(named: "checkBoxSelected"):UIImage(named: "checkBox"), for: .normal)
    }
    @IBAction func generateOTP(_ sender: Any) {
        if checkBoxState{
            registerUser()
        }else{
            self.showAlert("Please Agree the terms and conditions")
        }
    }
    
    func registerUser()
    {
        guard let firstName = firstName.text, let email = email.text,let phone = mobile.text,
              let emiratesID = emiratesID.text,
              let mrnID = mrnIDTextFeild.text else
        {
            return
        }
        
        if (firstName == ""){
            self.showAlert("First name shoulud be atleast 3 chars")
            return
        }
        
        
        let isValidateEmail = self.validation.validateEmailId(emailID: email)
        if (isValidateEmail == false){
            self.showAlert("Incorrect Email")
            return
        }
        
        if (phone == "") {
            print(mobileNumber)
            self.showAlert("Incorrect Mobile number")
            return
        }
        
        
        if (emiratesID == "")
        {
            self.showAlert("Enter Emirites ID")
            return
        }
        if (mrnID == "")
        {
            self.showAlert("Enter MRN ID")
            return
        }
        
        
//        let params = [
//                "full_name":"John madson",
//                "mobile_no":"919788561889",
//                "mail_address":"sam1@gmail12.com",
//                "national_id":"87826677667766",
//                "mrn":"12395868",
//                "password":"123456",
//                "device_id":"6adafafdsa6ffffffffffffffffffffffafdsfsa",
//                "device_type":"android"]
        //self.activityIndicator(self.view, startAnimate: true)
//        viewModel.registerUser(params: params)
//        viewModel.registerSuccess =
//        {
//
//        }
        UserDefaults.standard.setValue(firstName, forKey: "firstName")
        UserDefaults.standard.setValue(mobileNumber, forKey: "phone")
        UserDefaults.standard.setValue(email, forKey: "email")
        UserDefaults.standard.setValue(emiratesID, forKey: "emiratesID")
        UserDefaults.standard.setValue(mrnID, forKey: "mrnID")

        let storyboard = UIStoryboard(name: "Modified", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
        vc.modalPresentationStyle = .fullScreen
        
        self.view.window!.layer.add(self.rightToLeftTransition(), forKey: kCATransition)
        self.present(vc, animated: true)
//        viewModel.loadingStatus =
//        {
//
//            if self.viewModel.isLoading{
//                self.activityIndicator(self.view, startAnimate: true)
//            }else{
//                self.activityIndicator(self.view, startAnimate: false)
//                UIApplication.shared.endIgnoringInteractionEvents()
//            }
//        }
        
//        viewModel.errorMessageAlert = {
//            self.showAlert(self.viewModel.errorMessage ?? "Error")
//        }
    }
    
    @IBAction func LoginAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Modified", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
    }
    
    func setupUI(){
        container.createBorderForView(cornerRadius: 30, borderWidth: 0, borderColor: .clear)
        container.clipsToBounds = true
        container.layer.borderColor = UIColor.gray.cgColor
        container.layer.borderWidth = 0.4
        container.layer.masksToBounds = false
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        container.layer.shadowOpacity = 0.2
        scrollView.layer.cornerRadius = 30
//        container.layer.masksToBounds = false
//        container.layer.shadowColor = UIColor.black.cgColor
//        container.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        container.layer.shadowOpacity = 1
        firstName.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        email.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
       // mobile.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        emiratesID.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        mrnIDTextFeild.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        generateButton.createBorderForButton(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        let attributedString = NSMutableAttributedString(string: "I Agree to the Terms & Conditions", attributes: [
            .font: UIFont.systemFont(ofSize: 14.0, weight: .bold),
            .foregroundColor: UIColor(red: 121.0 / 255.0, green: 127.0 / 255.0, blue: 221.0 / 255.0, alpha: 1.0),
            .kern: 0.0
        ])
        attributedString.addAttribute(.foregroundColor, value: UIColor(red: 53.0 / 255.0, green: 54.0 / 255.0, blue: 91.0 / 255.0, alpha: 1.0), range: NSRange(location: 0, length: 14))
//        firstName.setPlaceholder(placeholderText: "First Name*")
//        mobileNumber.setPlaceholder(placeholderText: "Mobile Number*")
//        email.setPlaceholder(placeholderText: "Email address*")
//        emiratesID.setPlaceholder(placeholderText: "Emirates ID (Optional)")
        
        firstName.layer.cornerRadius = 5
        email.layer.cornerRadius = 5
        mobile.layer.cornerRadius = 5
        emiratesID.layer.cornerRadius = 5
        mrnIDTextFeild.layer.cornerRadius = 5


    }
    
}




extension UITextField{
    func setPlaceholder(placeholderText:String){
        self.attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 53/255, green: 55/255, blue: 88/255, alpha: 0.7)])
    }
}
    
extension RegistrationViewController: FPNTextFieldDelegate
{
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if isValid
        {
            self.mobileNumber = mobile.getFormattedPhoneNumber(format: .E164) ?? ""
        }
        else
        {
            print("Invalid phone number")
        }
    }
    
    func fpnDisplayCountryList() {
        
    }
    
    
}
