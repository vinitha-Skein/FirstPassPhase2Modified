//
//  ExsitingInfoLoadingViewController.swift
//  FirstPass
//
//  Created by MacOS on 22/11/22.
//  Copyright © 2022 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class ExsitingInfoLoadingViewController: UIViewController {

    @IBOutlet weak var gifLoadingImageView: UIImageView!
    var emiratesID = ""
    var dob = ""
    var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        gifLoadingImageView.setGIFImage(name: "loading_Page")
        timer?.invalidate()
        let seconds = 2.0
        timer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(timerHandler(_:)), userInfo: nil, repeats: false)
    }
    override func viewDidDisappear(_ animated: Bool) {
        stopTimer()
        
    }
    
    @objc func timerHandler(_ timer: Timer) {
        stopTimer()
        let storyboard = UIStoryboard(name: "Modified", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ExistingPatientInformationViewController") as! ExistingPatientInformationViewController
        vc.modalPresentationStyle = .fullScreen
        vc.emiratesID = self.emiratesID
        vc.dob = self.dob
        present(vc, animated: true, completion: nil)
       }
    
    func stopTimer()
    {
      if timer != nil {
        timer!.invalidate()
        timer = nil
      }
    }
    

    @IBAction func continueButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Modified", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ExistingPatientInformationViewController") as! ExistingPatientInformationViewController
        vc.modalPresentationStyle = .fullScreen
        vc.emiratesID = self.emiratesID
        vc.dob = self.dob
        present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func LoginButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Modified", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        vc.modalPresentationStyle = .fullScreen
        view.window!.layer.add(rightToLeftTransition(), forKey: kCATransition)
        present(vc, animated: true)
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
