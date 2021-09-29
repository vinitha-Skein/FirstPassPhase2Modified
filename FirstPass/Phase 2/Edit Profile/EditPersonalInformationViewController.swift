//
//  EditPersonalInformationViewController.swift
//  FirstPass
//
//  Created by Skeintech on 09/06/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class EditPersonalInformationViewController: UIViewController {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var numberView: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var changesButton: UIButton!
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
        dismiss(animated: true, completion: nil)
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
