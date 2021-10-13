//
//  TokenPopup.swift
//  Popup
//
//  Created by SkeinTechnologies on 31/12/20.
//

import UIKit
import AudioToolbox

class TokenPopup: UIViewController {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var tokenLabel: UILabel!
    @IBOutlet weak var tokenNumber: UILabel!
    
    @IBOutlet weak var CounterLabel: UILabel!
    var token = ""
    var counter = ""
    var appointmentData:ActiveAppointmentData?
    var journeyDetails : JourneyDetails?

    //var delegate:TokenClosedDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor.clear
//        view.isOpaque = false
        container.layer.cornerRadius = 25
        okButton.layer.cornerRadius = 8
        
        if (self.appointmentData != nil){
        tokenNumber.text = self.appointmentData?.token_no
        CounterLabel.text = counter
        } else {
            tokenNumber.text = token
            CounterLabel.text = counter
        }
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        if self.appointmentData != nil {
        let key =  "JOURNEY" + (self.appointmentData?.trans_id)!
        do {
            if let data = UserDefaults.standard.data(forKey: key) {
                let journey  = try PropertyListDecoder().decode(JourneyDetails.self, from: data)
                self.journeyDetails = journey
            }
        } catch {
            debugPrint(error)
        }
        }
    }
    @IBAction func okAction(_ sender: Any) {
       // delegate?.tokenClosed()
        if self.journeyDetails != nil {
//             if self.journeyDetails?.currentJourneyUpdate == "Registration" && appointmentData?.department == "Lab" {
//                updateJourney(Status: "Lab")
//                self.dismiss(animated: true, completion: nil)
//             }
//            else if self.journeyDetails?.currentJourneyUpdate == "Registration" && appointmentData?.department != "Lab" {
//                updateJourney(Status: "Vitals")
//                self.dismiss(animated: true, completion: nil)
//            } else if self.journeyDetails?.currentJourneyUpdate == "Vitals"{
//                updateJourney(Status: "Consultation")
//                let storyboard = UIStoryboard(name: "Modified", bundle: nil)
//                let vc = storyboard.instantiateViewController(withIdentifier: "ProcessFeedbackViewController") as! ProcessFeedbackViewController
//                vc.index = 0
//                vc.appointmentData = self.appointmentData
//                vc.modalPresentationStyle = .fullScreen
//                present(vc, animated: true, completion: nil)
//            } else if self.journeyDetails?.currentJourneyUpdate == "Consultation" && appointmentData?.department == "Cardiology" {
//                updateJourney(Status: "ECG")
//                let storyboard = UIStoryboard(name: "Modified", bundle: nil)
//                let vc = storyboard.instantiateViewController(withIdentifier: "ProcessFeedbackViewController") as! ProcessFeedbackViewController
//                vc.index = 1
//                vc.modalPresentationStyle = .fullScreen
//                vc.appointmentData = self.appointmentData
//                present(vc, animated: true, completion: nil)
////                self.dismiss(animated: true, completion: nil)
//            } else if self.journeyDetails?.currentJourneyUpdate == "Consultation" && appointmentData?.department != "Cardiology" {
//                updateJourney(Status: "Pharmacy")
//                let storyboard = UIStoryboard(name: "Modified", bundle: nil)
//                let vc = storyboard.instantiateViewController(withIdentifier: "ProcessFeedbackViewController") as! ProcessFeedbackViewController
//                vc.index = 1
//                vc.modalPresentationStyle = .fullScreen
//                vc.appointmentData = self.appointmentData
//                present(vc, animated: true, completion: nil)
//            } else
            if journeyDetails?.currentJourneyUpdate == "ECG" {
                updateJourney(Status: "X-ray")
                self.dismiss(animated: true, completion: nil)
            } else if journeyDetails?.currentJourneyUpdate == "X-ray"{
                updateJourney(Status: "Pharmacy")
                self.dismiss(animated: true, completion: nil)
            } else
            if journeyDetails?.currentJourneyUpdate == "Pharmacy" || journeyDetails?.currentJourneyUpdate == "Laboratory" {
                updateJourney(Status: "Finish Token")
                let alert = UIAlertController(title: "Firstpass", message: "Thank you for visiting our Facility today. It has been our pleasure to serve you. We wish you a speedy recovery.\nWarm regards,\nHealth care team", preferredStyle: UIAlertController.Style.alert)

                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { action in

                        let storyboard = UIStoryboard(name: "phase2", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion: nil)

                }))
                self.present(alert, animated: true, completion: nil)
//                self.view.makeToast("Thanks for the visit!")
//                self.dismiss(animated: true, completion: nil)
//                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//
//                }
               
            } else {
                dismiss(animated: true, completion: nil)
            }
        } else {
        dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func closeAction(_ sender: Any) {
        //delegate?.tokenClosed()
        dismiss(animated: true, completion: nil)
    }
    func  updateJourney(Status:String){
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

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
