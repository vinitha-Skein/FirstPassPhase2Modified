//
//  JourneyCompletedViewController.swift
//  FirstPass
//
//  Created by MacOS on 23/11/22.
//  Copyright © 2022 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class JourneyCompletedViewController: UIViewController {

    var appointmentData:ActiveAppointmentData?
    var journeyDetails : JourneyDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backClicked(_ sender: Any)
    {
        self.dismiss(animated: true);
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        updateJourney(Status: "Finish Token")
        let storyboard = UIStoryboard(name: "Modified", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func  updateJourney(Status:String)
    {
        let journey = JourneyDetails(tokenNo: journeyDetails?.tokenNo, currentStatus: "1", CompletedStatus: [], currentJourneyUpdate: Status,appointmentStatus: "FLOTING")
        let key = "JOURNEY" + (appointmentData?.trans_id)!
        do {
            let data = try PropertyListEncoder().encode(journey)
            UserDefaults.standard.set(data, forKey: key)
        } catch let error {
            debugPrint(error)
        }
    }
    
}
