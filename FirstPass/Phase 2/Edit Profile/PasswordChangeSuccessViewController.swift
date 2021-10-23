//
//  PasswordChangeSuccessViewController.swift
//  FirstPass
//
//  Created by Skeintech on 10/06/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class PasswordChangeSuccessViewController: UIViewController {

    @IBOutlet var bgView: UIView!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var successLabel: UILabel!
    @IBOutlet var successImage: UIImageView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var done_Button: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        container.layer.cornerRadius = 28
        container.layer.borderColor = UIColor.lightGray.cgColor
        container.layer.borderWidth = 0.4
        container.layer.masksToBounds = false
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        container.layer.shadowOpacity = 0.2
        container.layer.borderColor = UIColor.lightGray.cgColor
        container.layer.borderWidth = 0.4
        done_Button.layer.cornerRadius = 10
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
        bgView.backgroundColor = .black
        container.backgroundColor = UIColor(hex: "#222629")
        done_Button.backgroundColor = UIColor(named: "vip")
        done_Button.setTitleColor(UIColor(hex: "#503E00"), for: .normal)
        successLabel.textColor = UIColor(named: "vip")
        descriptionLabel.textColor = UIColor.white
        successImage.image = UIImage(named: "vipsuccess")
        backButton.setImage(UIImage(named: "vipback"), for: .normal)
    }
    @IBAction func doneClicked(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "phase2", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
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
