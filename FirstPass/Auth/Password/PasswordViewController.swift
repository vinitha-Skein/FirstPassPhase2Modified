//
//  ChangePasswordViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 07/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit
import Toast_Swift

class PasswordViewController: UIViewController {
    
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var alreadyhaveanaccountLabel: UILabel!
    @IBOutlet var reenterpasswordTitleLabel: UILabel!
    @IBOutlet var passwordTitleLabel: UILabel!
    @IBOutlet var headingLabel: UILabel!
    
    @IBOutlet var backButton: UIButton!
    @IBOutlet var bgView: UIView!
    
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var confirmPasswordiconButton: UIButton!
    @IBOutlet weak var passwordiconButton: UIButton!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var confirmPasswordView: UIView!
    let viewModel = RegisterUserViewModel()
    var userId = Int()
    var otp = Int()
    var passwordiconclick = true
    var confirmpasswordiconclick = true

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "vip")
        {
            vipview()
        }
    }
    
    func vipview()
    {
        bgView.backgroundColor = UIColor.black
        container.backgroundColor = UIColor(hex:"#222629" )
        backButton.setImage(UIImage(named: "vipback"), for: .normal)
        passwordView.backgroundColor = UIColor(hex: "#34383B")
        confirmPasswordView.backgroundColor = UIColor(hex: "#34383B")
        passwordTitleLabel.textColor = UIColor(named: "vip")
        reenterpasswordTitleLabel.textColor = UIColor(named: "vip")
        signinButton.backgroundColor = UIColor(named: "vip")
        signinButton.setTitleColor(UIColor(hex: "#503E00"), for: .normal)
        headingLabel.textColor = UIColor(named: "vip")
        alreadyhaveanaccountLabel.textColor = UIColor(hex: "#72767C")
        loginButton.setTitleColor(UIColor(named: "vip"), for: .normal)
    }
    @IBAction func signinAction(_ sender: Any)
    {
        if password.text == confirmPassword.text{
            setPassword(password: password.text!)
        }else{
            self.showAlert("Please enter password")
        }
        
    }
    
    @IBAction func login_Clicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Modified", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        vc.modalPresentationStyle = .fullScreen
        //        view.window!.layer.add(, forKey: kCATransition)
        self.present(vc, animated: true)
    }
    @IBAction func confirmPasswordButton(_ sender: Any)
    {
        if(confirmpasswordiconclick == true)
        {
            confirmPassword.isSecureTextEntry = false
            confirmPasswordiconButton.setImage(UIImage(named: "private"), for: .normal)
        } else
        {
            confirmPassword.isSecureTextEntry = true
            confirmPasswordiconButton.setImage(UIImage(named: "view"), for: .normal)
        }
        confirmpasswordiconclick = !confirmpasswordiconclick
    }
    @IBAction func passwordButton(_ sender: Any)
    {
        if(passwordiconclick == true)
        {
            password.isSecureTextEntry = false
            passwordiconButton.setImage(UIImage(named: "private"), for: .normal)

        } else
        {
            password.isSecureTextEntry = true
            passwordiconButton.setImage(UIImage(named: "view"), for: .normal)
        }
        passwordiconclick = !passwordiconclick
        
    }
    
    @IBAction func back_clicked(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    func setupUI(){
        container.createBorderForView(cornerRadius: 25, borderWidth: 0, borderColor: .clear)
        container.clipsToBounds = true
        container.layer.borderWidth = 0.4
        container.layer.borderColor = UIColor.gray.cgColor
        container.layer.masksToBounds = false
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        container.layer.shadowOpacity = 0.2
        signinButton.createBorderForButton(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        passwordView.layer.cornerRadius = 10
        confirmPasswordView.layer.cornerRadius = 10
        
    }
    @objc func eventWith()
    {
            
    }
    func setPassword(password:String){
        
        let name =  UserDefaults.standard.string(forKey: "firstName")
        let mobile = UserDefaults.standard.string(forKey: "phone")
        let email =  UserDefaults.standard.string(forKey: "email")
        let nationalID = UserDefaults.standard.string(forKey: "emiratesID")
        let mrnID = UserDefaults.standard.string(forKey: "mrnID")
        let deviceID =  UserDefaults.standard.string(forKey: "FCM_REGITERED_TOKEN")

        let params = [  "full_name":name,
                        "mobile_no":mobile,
                        "mail_address":email,
                        "national_id":nationalID,
                        "mrn":mrnID,
                        "password":password,
                        "device_id":deviceID,
                        "device_type":"iOS"]
        
        print(params)
                self.activityIndicator(self.view, startAnimate: true)
                viewModel.registerUser(params: params)
                viewModel.registerSuccess =
                {
                        self.view.makeToast("User Created Successfully. Plaese Login!")

                        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (_) in
                        
                        let storyboard = UIStoryboard(name: "Modified", bundle: .main)
                        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                        vc.modalPresentationStyle = .fullScreen
                        //        view.window!.layer.add(, forKey: kCATransition)
                        self.present(vc, animated: true)
                    }
                    
                    
                    
                    
                }
                
        
//        self.activityIndicator(self.view, startAnimate: true)
//        viewModel.setPassword(params: params)
//        viewModel.passwordSetSuccess =
//            {
//            let storyboard = UIStoryboard(name: "Modified", bundle: .main)
//            let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//            vc.modalPresentationStyle = .fullScreen
//            //        view.window!.layer.add(, forKey: kCATransition)
//            self.present(vc, animated: true)
//            //self.showAlert("Congratulations! Account Created Successfully.")
//
//        }
        //self.showAlert("Congratulations! Account Created Successfully.")
        viewModel.loadingStatus = {
            if self.viewModel.isLoading{
                self.activityIndicator(self.view, startAnimate: true)
            }else{
                self.activityIndicator(self.view, startAnimate: false)
                UIApplication.shared.endIgnoringInteractionEvents()
            }
        }
        
        viewModel.errorMessageAlert = {
            self.showAlert(self.viewModel.errorMessage ?? "Error")
        }
    }
    
}
