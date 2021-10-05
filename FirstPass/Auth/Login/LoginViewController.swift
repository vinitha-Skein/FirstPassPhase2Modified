//
//  LoginViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 07/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var fieldContainer: UIView!
    @IBOutlet weak var mobileTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var containerScrollview: UIScrollView!
    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordiconButton: UIButton!
    var passwordiconclick = true
    var validation = Validation()
    let viewModel = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        mobileTextfield.text = "natasha@gmail.com"
        passwordTextfield.text = "123456"
    }
    @IBAction func passwordButton(_ sender: Any)
    {
        if(passwordiconclick == true)
        {
            passwordTextfield.isSecureTextEntry = false
            passwordiconButton.setImage(UIImage(named: "private"), for: .normal)

        } else
        {
            passwordTextfield.isSecureTextEntry = true
            passwordiconButton.setImage(UIImage(named: "view"), for: .normal)
        }
        passwordiconclick = !passwordiconclick
        
    }
    @IBAction func signinAction(_ sender: Any) {
        loginUser()
    }
    
    @IBAction func signupAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Modified", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        vc.modalPresentationStyle = .fullScreen
        view.window!.layer.add(rightToLeftTransition(), forKey: kCATransition)
        present(vc, animated: true)
    }
    @IBAction func forgotPasswordAction(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Main", bundle: .main)
//        let vc = storyboard.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
//        vc.modalPresentationStyle = .fullScreen
//        view.window!.layer.add(rightToLeftTransition(), forKey: kCATransition)
//        present(vc, animated: true)
    }
    
    func loginUser(){
        guard let email = mobileTextfield.text,let password = passwordTextfield.text else {
            return
        }
        
        let isValidatePhone = self.validation.validateEmailId(emailID: email)
        if (isValidatePhone == false) {
            self.showAlert("Incorrect Mobile number")
            return
        }

       // let isValidatePassword = self.validation.validatePassword(password: password)
        if (password == "") {
            self.showAlert("Password have Minimum 8 characters at least 1 Alphabet and 1 Number")
            return
        }
        

        
        self.activityIndicator(self.view, startAnimate: true)
        let params = [
          "username": email,
          "password": password]
        viewModel.loginUser(params: params)
        viewModel.loginSuccess = {
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            let storyboard = UIStoryboard(name: "phase2", bundle: .main)
            let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            vc.modalPresentationStyle = .fullScreen
            self.view.window!.layer.add(self.rightToLeftTransition(), forKey: kCATransition)
            self.present(vc, animated: true)
        }

        viewModel.loadingStatus = {
            if self.viewModel.isLoading{
                self.activityIndicator(self.view, startAnimate: true)
            }else{
                self.activityIndicator(self.view, startAnimate: false)
                UIApplication.shared.endIgnoringInteractionEvents()
            }
        }

        viewModel.errorMessageAlert =
            {
            self.showAlert(self.viewModel.errorMessage ?? "Error")
        }
        
        
        //For demo
//        if phone.contains("natasha@gmail.com")
//        {
//            if password == "123456"{
//                UserDefaults.standard.set(true, forKey: "isLoggedIn")
//                let storyboard = UIStoryboard(name: "phase2", bundle: .main)
//                let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//                vc.modalPresentationStyle = .fullScreen
//                self.view.window!.layer.add(self.rightToLeftTransition(), forKey: kCATransition)
//                self.present(vc, animated: true)
//            }else{
//                self.showAlert("Incorrect password")
//            }
//        }
//        else if phone.contains("vipdemo@gmail.com")
//        {
//            if password == "123456"{
//                UserDefaults.standard.set(true, forKey: "isLoggedIn")
//                UserDefaults.standard.set(true, forKey: "vip")
//                let storyboard = UIStoryboard(name: "phase2", bundle: .main)
//                let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//                vc.modalPresentationStyle = .fullScreen
//                self.view.window!.layer.add(self.rightToLeftTransition(), forKey: kCATransition)
//                self.present(vc, animated: true)
//            }else{
//                self.showAlert("Incorrect password")
//            }
//        }
//        else
//        {
//            self.showAlert("Incorrect username")
//        }
        

    }

}


extension LoginViewController{
    func setupUI(){
           mobileTextfield.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
           passwordTextfield.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
           signinButton.createBorderForButton(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
            containerScrollview.layer.cornerRadius = 20
        fieldContainer.layer.cornerRadius = 20
        fieldContainer.layer.borderColor = UIColor.gray.cgColor
        fieldContainer.layer.borderWidth = 0.4
        fieldContainer.layer.masksToBounds = false
        fieldContainer.layer.shadowColor = UIColor.black.cgColor
        fieldContainer.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        fieldContainer.layer.shadowOpacity = 0.2

        passwordView.layer.cornerRadius = 10
        usernameView.layer.cornerRadius = 10
//           let attributedString = NSMutableAttributedString(string: "Don’t have an account? Sign up", attributes: [
//               .font: UIFont.systemFont(ofSize: 14.0, weight: .bold),
//               .foregroundColor: UIColor(red: 53.0 / 255.0, green: 54.0 / 255.0, blue: 91.0 / 255.0, alpha: 1.0),
//               .kern: 0.0
//           ])
//           attributedString.addAttribute(.foregroundColor, value: UIColor(red: 121.0 / 255.0, green: 127.0 / 255.0, blue: 221.0 / 255.0, alpha: 1.0), range: NSRange(location: 23, length: 7))
//           signupButton.setAttributedTitle(attributedString, for: .normal)
//           
//           mobileTextfield.attributedPlaceholder = NSAttributedString(string: "Mobile number or Email address",
//                                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 53/255, green: 55/255, blue: 88/255, alpha: 0.7)])
//           passwordTextfield.attributedPlaceholder = NSAttributedString(string: "Password",
//           attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 53/255, green: 55/255, blue: 88/255, alpha: 0.7)])
       }
       
}
