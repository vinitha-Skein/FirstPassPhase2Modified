//
//  EditPersonalInformationViewController.swift
//  FirstPass
//
//  Created by Skeintech on 09/06/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class EditPersonalInformationViewController: UIViewController {

    @IBOutlet var emailTextFeild: UITextField!
    @IBOutlet var mobileNumberTextFeild: UITextField!
    @IBOutlet var nameTextFeild: UILabel!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var numberView: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var changesButton: UIButton!
    let viewModel = ProfileViewModel()

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
        
        print("Save Changes")
        if (nameTextFeild.text == "" || mobileNumberTextFeild.text == "" || emailTextFeild.text == "")
        {
            showAlert("Kindly fill all the feilds!")
        }
        else
        {
           // updateProfile()
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
            self.activityIndicator(self.view, startAnimate: false)
            self.showAlert("Profile Details Updated Successfully.")
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
