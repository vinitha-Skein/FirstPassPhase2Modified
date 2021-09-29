//
//  OTPPopUpViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 02/12/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class OTPPopUpViewController: UIViewController
{
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var otp1: UITextField!
    @IBOutlet weak var otp3: UITextField!
    @IBOutlet weak var otp4: UITextField!
    @IBOutlet weak var otp5: UITextField!
    @IBOutlet weak var otp6: UITextField!
    @IBOutlet weak var otpView1: UIView!
    @IBOutlet weak var otpView4: UIView!
    @IBOutlet weak var otpView5: UIView!
    
    @IBOutlet weak var otpView3: UIView!
    @IBOutlet weak var otpView2: UIView!
    @IBOutlet weak var verifyButton: UIButton!
    var delegate:OTPPopUpDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    @IBAction func submitAction(_ sender: Any) {
        let first3 = otp1.text! + otp3.text!
        let last3 = otp4.text! + otp5.text! + otp6.text!
        delegate?.getOTPtext(otp: first3 + last3)
        
        let storyboard = UIStoryboard(name: "Modified", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SetPasswordViewController") as! SetPasswordViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    @IBAction func back_Clicked(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
}


extension OTPPopUpViewController:UITextFieldDelegate{
    func setupUI(){
        container.layer.cornerRadius = 30
        container.clipsToBounds = true
        container.layer.borderColor = UIColor.lightGray.cgColor
        container.layer.borderWidth = 0.4
        
        otpView1.layer.cornerRadius = 10
        otpView2.layer.cornerRadius = 10
        otpView3.layer.cornerRadius = 10
        otpView4.layer.cornerRadius = 10
        otpView5.layer.cornerRadius = 10

        
        verifyButton.createBorderForButton(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        
        otp1.delegate = self
        otp3.delegate = self
        otp4.delegate = self
        otp5.delegate = self
        otp6.delegate = self
        
        
        otp1.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        otp3.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        otp4.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        otp5.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        otp6.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        
        
    }
    @objc func textFieldDidChange(textField: UITextField){
        
        let text = textField.text
        
        if (text?.utf16.count)! >= 1{
            switch textField{
            case otp1:
                otp3.becomeFirstResponder()
            case otp3:
                otp4.becomeFirstResponder()
            case otp4:
                otp5.becomeFirstResponder()
            case otp5:
                otp6.becomeFirstResponder()
            case otp6:
                otp6.resignFirstResponder()
            default:
                break
            }
        }else{
            
        }
    }
//    func textFieldDidBeginEditing(_ textField: UITextField) {
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
//        case otp6:
//            setBorder(view: border6, borderWidth: 2, color: .black)
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
//        case otp6:
//            setBorder(view: border6, borderWidth: 1, color: UIColor(hexString: "0xD8D8D8"))
//        default:
//            break
//        }
//    }
//    func setBorder(view:UIView, borderWidth:CGFloat,color:UIColor){
//        view.layer.borderWidth = borderWidth
//        view.layer.borderColor = color.cgColor
//    }
}


protocol OTPPopUpDelegate {
    func getOTPtext(otp:String)
}
