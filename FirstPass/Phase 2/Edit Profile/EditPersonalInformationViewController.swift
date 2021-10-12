//
//  EditPersonalInformationViewController.swift
//  FirstPass
//
//  Created by Skeintech on 09/06/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class EditPersonalInformationViewController: UIViewController {

    @IBOutlet var nameTextFeild: UITextField!
    @IBOutlet var emailTextFeild: UITextField!
    @IBOutlet var mobileNumberTextFeild: UITextField!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var numberView: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var changesButton: UIButton!
    let viewModel = ProfileViewModel()
    var validation = Validation()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailView.layer.cornerRadius = 5
        numberView.layer.cornerRadius = 5
        nameView.layer.cornerRadius = 5
        changesButton.layer.cornerRadius = 10
        container.layer.cornerRadius = 28
        container.layer.borderWidth = 0.4
        container.layer.borderColor = UIColor.lightGray.cgColor
        container.layer.masksToBounds = false
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        container.layer.shadowOpacity = 0.2
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back_clicked(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func changes_saved(_ sender: Any)
    {
        guard let email = emailTextFeild.text,let phone = mobileNumberTextFeild.text, let name = nameTextFeild.text else {
            return
        }
        print("Save Changes")
        if (nameTextFeild.text == "")
        {
            showAlert("Kindly fill the name!")
        }
        let isValidateEmail = self.validation.validateEmailId(emailID: email)
        if (isValidateEmail == false){
            self.showAlert("Incorrect Email")
            return
        }
        
        let isValidatePhone = self.validation.validaPhoneNumber(phoneNumber: phone)
        if (isValidatePhone == false) {
            self.showAlert("Incorrect Mobile number")
            return
        }
        else
        {
            updateProfile()
        }
    
    }
    
    func updateProfile()
    {
        self.activityIndicator(self.view, startAnimate: true)
        guard let email = emailTextFeild.text,let phone = mobileNumberTextFeild.text, let name = nameTextFeild.text else {
            return
        }
        let params = [
            "full_name": name,
            "mobile_no": phone,
            "mail_address": email] as! [String:Any]
        
        viewModel.updateProfile(params: params)
        viewModel.updateSuccess =
        {
            let alert = UIAlertController(title: "Firstpass", message: "Profile Updated Successfully.", preferredStyle: UIAlertController.Style.alert)

                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                
                let storyboard = UIStoryboard(name: "Modified", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                UserDefaults.standard.set(false, forKey: "isLoggedIn")
                vc.modalPresentationStyle = .fullScreen

                self.present(vc, animated: true, completion: nil)

            }))
            self.present(alert, animated: true, completion: nil)
        }
        viewModel.loadingStatus = {
            if self.viewModel.isLoading{
                self.activityIndicator(self.view, startAnimate: true)
            }else{
                self.activityIndicator(self.view, startAnimate: false)
                UIApplication.shared.endIgnoringInteractionEvents()
            }
        }
        
        viewModel.errorMessageAlert = {
            self.activityIndicator(self.view, startAnimate: false)
            self.showAlert(self.viewModel.errorMessage ?? "Error in Loading details")
        }
        
    }

}
