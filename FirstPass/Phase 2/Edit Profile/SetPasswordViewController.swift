//
//  SetPasswordViewController.swift
//  FirstPass
//
//  Created by Skeintech on 10/06/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class SetPasswordViewController: UIViewController {

    @IBOutlet weak var passwordTextfeild: UITextField!
    @IBOutlet weak var confirmPasswordTextfeild: UITextField!
    @IBOutlet weak var confirmPasswordButton: UIButton!
    @IBOutlet weak var passwordButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var confirmpasswordView: UIView!
    
    @IBOutlet weak var passwordView: UIView!
    
    var passwordiconclick = true
    var confirmpasswordiconclick = true
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.layer.cornerRadius = 10
        container.layer.cornerRadius = 28
        container.layer.borderWidth = 0.4
        container.layer.borderColor = UIColor.gray.cgColor
        container.layer.masksToBounds = false
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        container.layer.shadowOpacity = 0.2
        passwordView.layer.cornerRadius = 5
        confirmpasswordView.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    
    @IBAction func password_ButtonClicked(_ sender: Any)
    {
        if(passwordiconclick == true)
        {
            passwordTextfeild.isSecureTextEntry = false
            passwordButton.setImage(UIImage(named: "view"), for: .normal)
        } else
        {
            passwordTextfeild.isSecureTextEntry = true
            passwordButton.setImage(UIImage(named: "private"), for: .normal)
        }
        passwordiconclick = !passwordiconclick

    }
    @IBAction func confirmPassword_ButtonClicked(_ sender: Any)
    {
        if(confirmpasswordiconclick == true)
        {
            confirmPasswordTextfeild.isSecureTextEntry = false
            confirmPasswordButton.setImage(UIImage(named: "view"), for: .normal)

        } else
        {
            confirmPasswordTextfeild.isSecureTextEntry = true
            confirmPasswordButton.setImage(UIImage(named: "private"), for: .normal)
        }
        confirmpasswordiconclick = !confirmpasswordiconclick

    }
    @IBAction func back_Clicked(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submit_Clicked(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Modified", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PasswordChangeSuccessViewController") as! PasswordChangeSuccessViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
