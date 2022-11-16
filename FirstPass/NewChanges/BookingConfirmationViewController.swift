//
//  BookingConfirmationViewController.swift
//  FirstPass
//
//  Created by Skeintech on 24/04/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class BookingConfirmationViewController: UIViewController {

    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var modeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var resheduleButton: UIButton!
    @IBOutlet weak var proceedButton: UIButton!
    @IBOutlet weak var container: UIView!
    override func viewDidLoad()
    {
        super.viewDidLoad()

        container.layer.cornerRadius = 30
        proceedButton.layer.cornerRadius = 10
        resheduleButton.layer.cornerRadius = 10
        resheduleButton.layer.borderWidth = 1
        resheduleButton.layer.borderColor = UIColor.black.cgColor
        
        
        DateLabel.text = UserDefaults.standard.string(forKey: "ConsultType")
        timeLabel.text = UserDefaults.standard.string(forKey: "Time")
        modeLabel.text = UserDefaults.standard.string(forKey: "Mode")
        sectionLabel.text = UserDefaults.standard.string(forKey: "Section")

        
       
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }

    @IBAction func reSheduleClicked(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func back_Clicked(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
}
