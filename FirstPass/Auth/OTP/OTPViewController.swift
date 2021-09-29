//
//  OTPViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 07/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class OTPViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var otp1: UITextField!
    @IBOutlet weak var otp2: UITextField!
    @IBOutlet weak var otp3: UITextField!
    @IBOutlet weak var otp4: UITextField!
    @IBOutlet weak var otp5: UITextField!
//    @IBOutlet weak var border1: UIView!
//    @IBOutlet weak var border2: UIView!
//    @IBOutlet weak var border3: UIView!
//    @IBOutlet weak var border4: UIView!
//    @IBOutlet weak var border5: UIView!
//    @IBOutlet weak var border6: UIView!

    @IBOutlet weak var verifyButton: UIButton!
    let viewModel = OTPViewModel()
    var userId = Int()
    var otpfromSource = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        print(otpfromSource)
        // Do any additional setup after loading the view.
    }
    @IBAction func back_clicked(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func login_Clicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Modified", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        vc.modalPresentationStyle = .fullScreen
        //        view.window!.layer.add(, forKey: kCATransition)
        self.present(vc, animated: true)
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

        verifyButton.createBorderForButton(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        
        otp1.delegate = self
        otp2.delegate = self
        otp3.delegate = self
        otp4.delegate = self
        otp5.delegate = self
        
        
        otp1.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        otp2.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        otp3.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        otp4.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        otp5.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        
        
    }
    @objc func textFieldDidChange(textField: UITextField){
        
        let text = textField.text
        
        if (text?.utf16.count)! >= 1{
            switch textField{
            case otp1:
                otp2.becomeFirstResponder()
            case otp2:
                otp3.becomeFirstResponder()
            case otp3:
                otp4.becomeFirstResponder()
            case otp4:
                otp5.becomeFirstResponder()
            case otp5:
                otp5.becomeFirstResponder()
            default:
                break
            }
        }else{
            
        }
    }
    
    @IBAction func verifyAction(_ sender: Any) {
        //let otp = "\(otp1.text)  \(otp2.text)  \(otp3.text)  \(otp4.text)  \(otp5.text)"
        let otp = otp1.text! + otp2.text! + otp3.text! + otp4.text! + otp5.text!
        if otp.count == 5{
            //verifyOTP(otp: otp)
            let intOTP = Int(otp) ?? 0
            print(intOTP)
            tempOTPvalidation(otpfunc: intOTP)
        }else{
            print("NO OTP")
            print()
        }
        let intOTP = Int(otp) ?? 0
        print(intOTP)
        print(otp)
    }
    func tempOTPvalidation(otpfunc:Int)
    {
        print("otp: \(otpfunc)")
        print("otpfunc: \(otpfromSource)")
//        if (otpfunc == otpfromSource)
//        {
//            let storyboard = UIStoryboard(name: "Modified", bundle: .main)
//            let vc = storyboard.instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
//            vc.modalPresentationStyle = .fullScreen
//            self.view.window!.layer.add(self.rightToLeftTransition(), forKey: kCATransition)
//            vc.userId = self.userId
//            vc.otp = otpfromSource
//            self.present(vc, animated: true)
//        }
//        else
//        {
//            let alertController = UIAlertController(title: "Invalid OTP", message: "You have entered an Invalid OTP", preferredStyle: .alert)
//            let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
//            alertController.addAction(action)
//            present(alertController, animated: true, completion: nil)
//        }
        let storyboard = UIStoryboard(name: "Modified", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
        vc.modalPresentationStyle = .fullScreen
        self.view.window!.layer.add(self.rightToLeftTransition(), forKey: kCATransition)
        vc.userId = self.userId
        vc.otp = otpfromSource
        self.present(vc, animated: true)
    }
    func verifyOTP(otp:String){
        let params = [
            "otp": otp,
            "userId": userId] as [String : Any]
        self.activityIndicator(self.view, startAnimate: true)
        viewModel.verifyOTP(params: params)
        viewModel.otpVerifySuccess = {
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let vc = storyboard.instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
            vc.modalPresentationStyle = .fullScreen
            self.view.window!.layer.add(self.rightToLeftTransition(), forKey: kCATransition)
            vc.userId = self.userId
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
        
        viewModel.errorMessageAlert = {
            self.showAlert(self.viewModel.errorMessage ?? "Error")
        }
    }
    
}

extension OTPViewController{

//    func textFieldDidBeginEditing(_ textField: UITextField)
//    {
//        textField.text = ""
//        switch textField{
//        case otp1:
//            setBorder(view: border1, borderWidth: 2, color: .black)
//        case otp2:
//            setBorder(view: border2, borderWidth: 2, color: .black)
//        case otp3:
//            setBorder(view: border3, borderWidth: 2, color: .black)
//        case otp4:
//            setBorder(view: border4, borderWidth: 2, color: .black)
//        case otp5:
//            setBorder(view: border5, borderWidth: 2, color: .black)
//        default:
//            break
//        }
//    }
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        switch textField{
//        case otp1:
//            setBorder(view: border1, borderWidth: 1, color: UIColor(hexString: "0xD8D8D8"))
//        case otp2:
//            setBorder(view: border2, borderWidth: 1, color: UIColor(hexString: "0xD8D8D8"))
//        case otp3:
//            setBorder(view: border3, borderWidth: 1, color: UIColor(hexString: "0xD8D8D8"))
//        case otp4:
//            setBorder(view: border4, borderWidth: 1, color: UIColor(hexString: "0xD8D8D8"))
//        case otp5:
//            setBorder(view: border5, borderWidth: 1, color: UIColor(hexString: "0xD8D8D8"))
//        default:
//            break
//        }
//    }
    func setBorder(view:UIView, borderWidth:CGFloat,color:UIColor){
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = color.cgColor
    }
}
