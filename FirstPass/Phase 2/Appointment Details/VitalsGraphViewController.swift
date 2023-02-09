//
//  VitalsGraphViewController.swift
//  FirstPass
//
//  Created by MacOS on 23/11/22.
//  Copyright © 2022 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class VitalsGraphViewController: UIViewController {

    @IBOutlet weak var NameLabel: UILabel!
    var name = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        NameLabel.text = name
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackPressed(_ sender: Any) {
        self.dismiss(animated: true)
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
