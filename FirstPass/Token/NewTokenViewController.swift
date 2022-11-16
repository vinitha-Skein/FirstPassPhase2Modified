//
//  NewTokenViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 01/01/21.
//  Copyright © 2021 SkeinTechnologies. All rights reserved.
//

import UIKit
import AVFoundation
class NewTokenViewController: UIViewController/*, swapCathLabDelegate,PharmacyDelegate */{
   
    
    @IBOutlet var headLabel: UILabel!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var scrollviewContainer: UIView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var barcodeImage: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
    var headtext = String()
    @IBOutlet weak var drLabel: NSLayoutConstraint!
    
    
    let reg = AppointmentStatus(step: "Registration", est: "5 mins", counter: "R1", status: "running", tokenCall: false,startImageStatus:"false")
       let reg1 = AppointmentStatus(step: "Registration ", est: "5 mins", counter: "R1", status: "running", tokenCall: false,startImageStatus:"false")
          let vitals = AppointmentStatus(step: "Vitals", est: "8 mins", counter: "V1", status: "not started", tokenCall: false,startImageStatus:"false")
          let cardio = AppointmentStatus(step: "Cardiology", est: "15 mins", counter: "C1", status: "not started", tokenCall: false,startImageStatus:"false")
    let blood = AppointmentStatus(step: "Blood Test", est: "15 mins", counter: "L1", status: "not started", tokenCall: false,startImageStatus: "false")
    let lab_blood = AppointmentStatus(step: "Lab (Blood Test)", est: "10 mins", counter: "BL1", status: "not started", tokenCall: false,startImageStatus:"false")
    let cathLab = AppointmentStatus(step: "Cath Lab", est: "15 mins", counter: "L1", status: "not started", tokenCall: false,startImageStatus:"false")
    let radio = AppointmentStatus(step: "Radiology (Xray)", est: "20 mins", counter: "XR1", status: "not started", tokenCall: false,startImageStatus:"false")
     let pharm = AppointmentStatus(step: "Pharmacy", est: "15 mins", counter: "P1", status: "not started", tokenCall: false,startImageStatus:"false")
    
    var serviceName:String!
    
    var appointmentProcess = [AppointmentStatus]()
    
    var appointment : ActiveAppointmentData?
    
    var Departmentsections = ["Registration","Vitals","Consultation","Pharmacy"]
    
    @IBOutlet weak var tokenLabel: UILabel!
    
    @IBOutlet weak var departmentLabel: UILabel!
    
    @IBOutlet weak var TimeLabel: UILabel!
    
    @IBOutlet weak var DateLabel: UILabel!
    
    @IBOutlet weak var DoctorNameLabel: UILabel!
    
    @IBOutlet weak var PatientNAmeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } 
        tableview.register(UINib(nibName: "TokenTableViewCell", bundle: .main), forCellReuseIdentifier: "TokenTableViewCell")
        scrollviewContainer.createBorderForView(cornerRadius: 30, borderWidth: 0, borderColor: .clear)
        scrollview.createBorderForView(cornerRadius: 30, borderWidth: 0, borderColor: .clear)
        scrollviewContainer.layer.masksToBounds = false
        scrollviewContainer.layer.shadowColor = UIColor.black.cgColor
        scrollviewContainer.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        scrollviewContainer.layer.shadowOpacity = 0.2
        barcodeImage.image = generateBarcode(from: "123456789")
        
      
        headLabel.text = headtext
        if(serviceName != "Laboratory"){
        appointmentProcess = [reg,vitals,cardio]
        }else{
        appointmentProcess = [reg1,blood]
//,blood,lab_blood,cathLab,radio,pharm
        }
        if appointment != nil {
            headLabel.text =  self.appointment?.department
            departmentLabel.text = self.appointment?.department
            let dateString =  self.appointment?.appointment_time!
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM  d yyyy h:mm:ss:SSSa"
            if let date = formatter.date(from: dateString!) {
                formatter.dateFormat = "dd-MM-yyyy"
                let string = formatter.string(from: date)
                print(string)
                DateLabel.text = string
                formatter.dateFormat = "h:mm a"
                let stringTime = formatter.string(from: date)
                TimeLabel.text = stringTime
            }
            DoctorNameLabel.text = self.appointment?.doctor_name
            PatientNAmeLabel.text = (self.appointment?.patient_name!)! + "|self|25yrs"
            tokenLabel.text = appointment?.token_no
//            if appointment?.token_no == ""{
//                tokenLabel.text = appointment?.trans_id
//            }
            if appointment?.department == "Cardiology" {
                Departmentsections = ["Registration","Vitals","Consultation","ECG","X-ray","Pharmacy"]
            }
//            tableviewHeight.constant = 400
        }
        
        tableviewHeight.constant = CGFloat(Departmentsections.count*100)
    }
    @IBAction func cancel_Appointment(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Modified", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DeleteFamilyMemberViewController") as! DeleteFamilyMemberViewController
        vc.headText = "Delete appointment"
        vc.contentText = "Are you sure you want to delete this appointment?"
        vc.deleteFamilyMember = false
        vc.modalPresentationStyle = .overCurrentContext

        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func generateBarcode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
    
    
}
extension NewTokenViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Departmentsections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "TokenTableViewCell") as! TokenTableViewCell
        cell.status.text = Departmentsections[indexPath.row]
        cell.indoorMapButtonPressed =
        {
//            let storyboard = UIStoryboard(name: "Modified", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "IndoorMapViewController") as! IndoorMapViewController
//            vc.modalPresentationStyle = .fullScreen
//
//            self.present(vc, animated: true, completion: nil)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

//extension NewTokenViewController:UITableViewDelegate,UITableViewDataSource,TokenClosedDelegate,CompleteStepDelegate,FeedbackClosedDelegate,SwapTestDelegate
//{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return appointmentProcess.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TokenTableViewCell", for: indexPath) as! TokenTableViewCell
//        let data = appointmentProcess[indexPath.row]
//        cell.step.text = data.step
//        let attributedString = NSMutableAttributedString(string: "Counter - \(data.counter)", attributes: [
//            .font: UIFont.systemFont(ofSize: 16.0, weight: .bold)
//        ])
//        attributedString.addAttribute(.font, value:UIFont.systemFont(ofSize: 14.0, weight: .regular), range: NSRange(location: 0, length: 10))
//        cell.counter.attributedText = attributedString
//
//        if !data.tokenCallFinished{
//            cell.counter.isHidden = true
//        }else{
//            cell.counter.isHidden = false
//        }
//        cell.status.isHidden = true
//
//        if data.startImageStatus == "true"{
//            cell.starImage.isHidden = false
//        }else{
//            cell.starImage.isHidden = true
//        }
//
//
//        switch data.status{
//        case "running":
//            cell.statusImage.setImage(UIImage(named: "pending"), for: .normal)
//            cell.statusImage.backgroundColor = UIColor(hexString: "#F5C10A")
//        case "not started":
//            cell.statusImage.setImage(UIImage(named: "upcoming"), for: .normal)
//            cell.statusImage.backgroundColor = UIColor(hexString: "#9A9BAC")
//        case "finished":
//            cell.statusImage.setImage(UIImage(named: "finished"), for: .normal)
//            cell.statusImage.backgroundColor = UIColor(hexString: "#53C666")
//            cell.status.isHidden = false
//            cell.statusImageCenterY.constant = -7
//        default :
//            break
//        }
//
//
//        let attributedString1 = NSMutableAttributedString(string: "Est. Wait Time : \(data.estimationTime)", attributes: [
//            .font: UIFont.systemFont(ofSize: 12.0, weight: .semibold),
//            .foregroundColor: UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 1.0),
//            .kern: 0.0
//        ])
//        attributedString1.addAttribute(.font, value:UIFont.systemFont(ofSize: 12.0, weight: .semibold), range: NSRange(location: 0, length: 17))
//        attributedString1.addAttribute(.foregroundColor, value: UIColor(red: 121.0 / 255.0, green: 127.0 / 255.0, blue: 221.0 / 255.0, alpha: 1.0), range: NSRange(location: 0, length: 17))
//        cell.estimation.attributedText = attributedString1
//        cell.delegate = self
//        cell.completeButton.tag = indexPath.row
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 115
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let data = appointmentProcess[indexPath.row]
//        if data.status == "running"{
//            tokenCall(token: "\(data.counter)")
//            appointmentProcess[indexPath.row].tokenCallFinished = true
//        }else{
//            return
//        }
//        //        switch data.step {
//        //        case "Registration":
//        //            tokenCall(token: "CRD001 -> \(data.counter)")
//        //            appointmentProcess[indexPath.row].tokenCallFinished = true
//        //        case "Vitals":
//        //            break
//        //        case "Cardiology":
//        //            break
//        //        case "X-Ray":
//        //            break
//        //        case "Blood Test":
//        //            break
//        //        default:
//        //            break
//        //        }
//    }
//
//    func tokenCall(token:String){
//        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
//        let storyboard = UIStoryboard(name: "Main", bundle: .main)
//        let vc = storyboard.instantiateViewController(withIdentifier: "TokenPopup") as! TokenPopup
//        vc.modalPresentationStyle = .overCurrentContext
//        vc.token = token
//        vc.delegate = self
//        present(vc, animated: true)
//    }
//
//    func tokenClosed() {
//        dismiss(animated: true, completion: nil)
//        DispatchQueue.main.async {
//            self.tableview.reloadData()
//        }
//
//    }
//
//
//    func priorityUpgradeCall(token:String){
//          AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
//          let storyboard = UIStoryboard(name: "Main", bundle: .main)
//          let vc = storyboard.instantiateViewController(withIdentifier: "PharmacyCollectionPopup") as! PharmacyCollectionPopup
//          vc.modalPresentationStyle = .overCurrentContext
//
//          present(vc, animated: true)
//      }
//
//    func swapTestDelegate() {
//        dismiss(animated: true, completion: nil)
//        appointmentProcess.swapAt(3, 4)
//        appointmentProcess[3].status = "running"
//        appointmentProcess[4].status = "not started"
//
//        NSLog("appointmentProcess  %@,%@",  appointmentProcess[3].status,appointmentProcess[4].status)
//        DispatchQueue.main.async {
//
//            UIView.transition(with: self.tableview,
//            duration: 2,
//            options: .transitionCrossDissolve,
//            animations: { self.tableview.moveRow(at: [0,4], to: [0,3]) })
//
//        }
//    }
//
//    func swapCathLabDelegate() {
//          dismiss(animated: true, completion: nil)
//          appointmentProcess.swapAt(3, 4)
//        NSLog("appointmentProcess  %@,%@",  appointmentProcess[3].status,appointmentProcess[4].status)
//
//          appointmentProcess[3].status = "running"
//          appointmentProcess[4].status = "not started"
//        NSLog("appointmentProcess  %@,%@",  appointmentProcess[3].status,appointmentProcess[4].status)
//
//          DispatchQueue.main.async {
//
//              UIView.transition(with: self.tableview,
//              duration: 2,
//              options: .transitionCrossDissolve,
//              animations: { self.tableview.moveRow(at: [0,4], to: [0,3]) })
//
//          }
//      }
//
//    func swapXrayDelegate() {
//        dismiss(animated: true, completion: nil)
//        appointmentProcess.swapAt(3, 5)
//        appointmentProcess[3].status = "running"
//        appointmentProcess[4].status = "not started"
//        NSLog("appointmentProcess  %@,%@",  appointmentProcess[3].status,appointmentProcess[5].status)
//
//        DispatchQueue.main.async {
//
//            UIView.transition(with: self.tableview,
//            duration: 2,
//            options: .transitionCrossDissolve,
//            animations: { self.tableview.moveRow(at: [0,5], to: [0,3]) })
//
//        }
//    }
//
//
//    func pharmacyNowDelegate() {
//           NSLog("pharamcy Now")
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//        let storyboard = UIStoryboard(name: "Main", bundle: .main)
//        let popup1 = storyboard.instantiateViewController(withIdentifier: "PharmacyCollectionPopup") as! PharmacyCollectionPopup
//        popup1.modalPresentationStyle = .overCurrentContext
//        popup1.dayCollection = "now"
//        self.present(popup1, animated: true, completion: nil)
//        }
//    }
//
//       func pharmacyNextDayDelegate() {
//         NSLog("pharamcy Next Day")
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                         AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
//                         let storyboard = UIStoryboard(name: "Main", bundle: .main)
//                         let popup = storyboard.instantiateViewController(withIdentifier: "PharmacyCollectionPopup") as! PharmacyCollectionPopup
//                         popup.modalPresentationStyle = .overCurrentContext
//                          popup.dayCollection = "next"
//                         self.present(popup, animated: true, completion: nil)
//                     }
//
//       }
//
//       func pharmacyCourierDelegate() {
//           NSLog("pharamcy courier")
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                  AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
//                  let storyboard = UIStoryboard(name: "Main", bundle: .main)
//                  let popup = storyboard.instantiateViewController(withIdentifier: "PharmacyCollectionPopup") as! PharmacyCollectionPopup
//                  popup.modalPresentationStyle = .overCurrentContext
//                  popup.dayCollection = "courier"
//                  self.present(popup, animated: true, completion: nil)
//              }
//
//       }
//
//    func feedbackWindowClosed(index:Int) {
//        dismiss(animated: true, completion: nil)
//        let data = appointmentProcess[index]
//        if data.status == "running"{
//
//        }else{
//            return
//        }
//        NSLog("index  %d",index)
//         NSLog("index  %d",appointmentProcess.count)
//        if index == 2{
//            if appointmentProcess.count == 3{
//                appointmentProcess.append(lab_blood)
//                appointmentProcess.append(cathLab)
//                 appointmentProcess.append(radio)
//
//                tableviewHeight.constant = 700
//                tableview.reloadData()
//            }
//        }
//
//        if index == 5{
//                  if appointmentProcess.count == 6{
//                      appointmentProcess.append(cardio)
//                      tableviewHeight.constant = 900
//                      tableview.reloadData()
//                  }
//              }
//
//        if index == 6{
//                         if appointmentProcess.count == 7 {
//                             appointmentProcess.append(pharm)
//                             tableviewHeight.constant = 1000
//                             tableview.reloadData()
//                         }
//                     }
//
//        appointmentProcess[index].status = "finished"
//        if index < appointmentProcess.count - 1 {
//           appointmentProcess[index + 1].status = "running"
//        }
//        NSLog("data.step %@",data.step)
//        switch data.step {
//        case "Cardiology":
//            if index == 2 {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
//                let storyboard = UIStoryboard(name: "Main", bundle: .main)
//                let popup = storyboard.instantiateViewController(withIdentifier: "SwapPopup") as! SwapPopup
//                popup.modalPresentationStyle = .overCurrentContext
//                popup.delegate = self
//                self.present(popup, animated: true, completion: nil)
//            }
//            }
//        case "Pharmacy":
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
//            let storyboard = UIStoryboard(name: "Main", bundle: .main)
//            let popup = storyboard.instantiateViewController(withIdentifier: "PharmacyPopup") as! PharmacyPopup
//            popup.modalPresentationStyle = .overCurrentContext
//            popup.delegate = self
//            self.present(popup, animated: true, completion: nil)
//        }
//            case "Registration ":
//
//            appointmentProcess[1].startImageStatus = "true"
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
//                let storyboard = UIStoryboard(name: "Main", bundle: .main)
//                let popup = storyboard.instantiateViewController(withIdentifier: "PharmacyCollectionPopup") as! PharmacyCollectionPopup
//                popup.modalPresentationStyle = .overCurrentContext
//                 popup.dayCollection = "priority"
//                self.present(popup, animated: true, completion: nil)
//            }
////        case "X-Ray":
////            appointmentProcess[index].status = "finished"
////            appointmentProcess[index + 1].status = "running"
////        case "Blood Test":
////            break
//        default:
//            break
//        }
//
//        DispatchQueue.main.async {
//            self.tableview.reloadData()
//        }
//    }
//
//    func completeStep(index: Int) {
//        if appointmentProcess[index].status == "running"{
//
//        }else{
//            return
//        }
//        let storyboard = UIStoryboard(name: "Main", bundle: .main)
//        let popup = storyboard.instantiateViewController(withIdentifier: "ProcessFeedbackViewController") as! ProcessFeedbackViewController
//        popup.modalPresentationStyle = .overCurrentContext
//        popup.delegate = self
//        popup.index = index
//        NSLog("token index %d", index);
//        present(popup, animated: true, completion: nil)
//    }
//
//
//}


struct AppointmentStatus {
    var step:String
    var estimationTime:String
    var counter:String
    var status:String
    var tokenCallFinished:Bool
    var startImageStatus:String
    
    init(step:String,est:String,counter:String,status:String,tokenCall:Bool,startImageStatus:String) {
        self.step = step
        self.estimationTime = est
        self.counter = counter
        self.status = status
        self.tokenCallFinished = tokenCall
        self.startImageStatus = startImageStatus
    }
}
