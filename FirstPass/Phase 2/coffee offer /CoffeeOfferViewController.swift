//
//  CoffeeOfferViewController.swift
//  FirstPass
//
//  Created by MacOS on 28/09/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class CoffeeOfferViewController: UIViewController {

    var appointmentData:ActiveAppointmentData?
    var journeyDetails : JourneyDetails?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func okayButtonPressed(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
        let storyboard = UIStoryboard(name: "phase2", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "JourneyCompletedViewController") as! JourneyCompletedViewController
        vc.journeyDetails = self.journeyDetails
        vc.appointmentData = self.appointmentData
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}
