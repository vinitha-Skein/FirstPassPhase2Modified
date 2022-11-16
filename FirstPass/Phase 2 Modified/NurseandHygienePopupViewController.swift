//
//  NurseandHygieneViewController.swift
//  FirstPass
//
//  Created by Skeintech on 24/09/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class NurseandHygienePopupViewController: UIViewController {

    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var WholeContainer: UIView!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var container: UIView!
    var Nurse = false
    var Hygiene = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.isOpaque = false
        if(Nurse)
        {
            label1.text = "A nurse from our team has been notified."
            label2.text = "You will be attended to shortly."
        }
        else if(Hygiene)
        {

            label1.text = "Request Sent!"
            label2.text = "Your request has been sent to respective team. Thank You!"
        }
        container.layer.cornerRadius = 20
        WholeContainer.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Ok_Clicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func back_Clicked(_ sender: Any)
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
