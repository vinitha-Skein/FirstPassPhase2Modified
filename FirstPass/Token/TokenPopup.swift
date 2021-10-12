//
//  TokenPopup.swift
//  Popup
//
//  Created by SkeinTechnologies on 31/12/20.
//

import UIKit

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
//
//        tokenLabel.text = "\(token)"
//        tokenNumber.text = "CRD001"
//        NSLog("token ============> %@",token)
        
//        let attributedString = NSMutableAttributedString(string: token, attributes: [
//            .font: UIFont.systemFont(ofSize: 90.0, weight: .bold),
//            .foregroundColor:UIColor(red: 59.0 / 255.0, green: 182.0 / 255.0, blue: 189.0 / 255.0, alpha: 1.0) ,
//            .kern: 0.0
//        ])
////        attributedString.addAttribute(.foregroundColor, value: UIColor(red: 53.0 / 255.0, green: 56.0 / 255.0, blue: 88.0 / 255.0, alpha: 1.0) , range: NSRange(location: 0, length: 6))
////                attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 40.0, weight: .semibold), range: NSRange(location: 0, length: 6))
//
//        let attributedString1 = NSMutableAttributedString(string: "CRD001", attributes: [
//                   .font: UIFont.systemFont(ofSize: 30.0, weight: .bold),
//                   .kern: 0.0
//               ])
//        tokenLabel.attributedText = attributedString
//        tokenNumber.attributedText = attributedString1
//        // Do any additional setup after loading the view.
        if (self.appointmentData != nil){
        tokenNumber.text = self.appointmentData?.token_no
        CounterLabel.text = "P1"
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
            if journeyDetails?.currentJourneyUpdate == "Pharmacy" || journeyDetails?.currentJourneyUpdate == "Lab" {
                updateJourney(Status: "Finish Token")
                self.view.makeToast("Thanks for the visit!")
//                self.dismiss(animated: true, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    let storyboard = UIStoryboard(name: "phase2", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
               
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
        let journey = JourneyDetails(tokenNo: journeyDetails?.tokenNo, currentStatus: "1", CompletedStatus: [], currentJourneyUpdate: Status)
        let key = "JOURNEY" + (appointmentData?.trans_id)!
        do {
            let data = try PropertyListEncoder().encode(journey)
            UserDefaults.standard.set(data, forKey: key)
        } catch let error {
            debugPrint(error)
        }
    }
    
    
}



//protocol TokenClosedDelegate {
//    func tokenClosed()
//}
