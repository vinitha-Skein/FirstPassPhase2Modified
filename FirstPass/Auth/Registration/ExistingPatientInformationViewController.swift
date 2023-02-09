//
//  ExistingPatientInformationViewController.swift
//  FirstPass
//
//  Created by MacOS on 25/10/22.
//  Copyright © 2022 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class ExistingPatientInformationViewController: UIViewController {

    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var EmiratesidLabel: UILabel!
    var emiratesID = ""
    var dob = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Modified", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SignupExisitingSuccessViewController") as! SignupExisitingSuccessViewController
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
