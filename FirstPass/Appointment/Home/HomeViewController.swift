//
//  HomeViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 18/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import AlamofireImage
import FirebaseDatabase
import JitsiMeet
import Foundation


class HomeViewController: UIViewController,ScanFinishedDelegate {
    
   
    
    @IBOutlet weak var upcommingAppointmentsView: UIView!
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet var bgView: UIView!
    
    @IBOutlet weak var notificationButton: UIButton!
    
    @IBOutlet weak var scannerViewButton: UIButton!
    
    
    @IBOutlet weak var upcommingAppointmentsLabel: UILabel!
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var viewAllButton: UIButton!
    
    @IBOutlet weak var bottomMenuView: Tabbar!
    
    //    @IBOutlet weak var upcommingView: MyUIView!
    
    //    @IBOutlet weak var prefilledLabel: UILabel!
    
    //    @IBOutlet weak var preArrivalButton: Mybutton!
    
    
    //    @IBOutlet weak var checkinButton: Mybutton!
    
    //    @IBOutlet weak var headingLabel: UILabel!
    
    //    @IBOutlet weak var indoormapButton: UIButton!
    
    //    @IBOutlet weak var noteLabel: UILabel!
    
    @IBOutlet weak var appointmentsCollectionView: UICollectionView!
    
    
    var familyMemberData = [FamilyMembersList]()
    
    var blurView = UIView()
    var checkInView = UIView()
    var userId = Int()
    let viewModel = HomeViewModel()
    var familyMemberCount = Int()
    var CurrentAppointment = String()
    
    var dummyAppointments = [ActiveAppointmentData]()
    var appointments = [ActiveAppointmentData]()
    var historyAppointments = [ActiveAppointmentData]()
    
    
    var titleMenu = ["Medicine Collections","Cardiology","Cardiology","In Patient"]
//    var titleColor = [#colorLiteral(red: 0.2078431373, green: 0.137254902, blue: 0.3921568627, alpha: 1),#colorLiteral(red: 0.427859962, green: 0.3798725903, blue: 0.5662087798, alpha: 1),#colorLiteral(red: 0.7609769702, green: 0.7396642566, blue: 0.8182614446, alpha: 1)]
    var checkinSelected = -1
    var appointmentBooked = -1
    var preArrivalfilled = [Int]()
    var itisInitialLoad = true
    var rolledIndex = -1
    
    @IBOutlet weak var NoAppointmentsLabel: UILabel!
    
    fileprivate var pipViewCoordinator: PiPViewCoordinator?
    fileprivate var jitsiMeetView: JitsiMeetView?
    var codefromScan = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        layout.itemSize = CGSize(width: appointmentsCollectionView.frame.size.width-70, height:  appointmentsCollectionView.frame.size.height-40)
//        layout.animationMode = SJCenterFlowLayoutAnimation.scale(sideItemScale: 0.6, sideItemAlpha: 0.6, sideItemShift: 0.0)
//        layout.scrollDirection =  .horizontal
//        appointmentsCollectionView.collectionViewLayout = layout
        appointmentsCollectionView.collectionViewLayout = CardsCollectionViewLayout()
        appointmentsCollectionView.isPagingEnabled = true
        appointmentsCollectionView.showsHorizontalScrollIndicator = false
        appointmentsCollectionView.dataSource = self
        appointmentsCollectionView.delegate = self
        
        
        setupUI()
        //        getUserDetailsFromLocal()
        bottomMenuView.delegate = self
        
        if UserDefaults.standard.bool(forKey: "vip")
        {
            vipView()
        }
      
//        firebaseObserver()
//        firebaseDatabaseForNotification()
    }
    @objc func methodOfReceivedNotification(notification: Notification) {
        print(notification.userInfo)
        if notification.userInfo?["department"] as! String == "vitals" {
         //Show feedback after end vitals.
            let storyboard = UIStoryboard(name: "Modified", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ProcessFeedbackViewController") as! ProcessFeedbackViewController
            vc.index = 0
            for i in 0..<appointments.count {
                if notification.userInfo?["Token"]  as? String == self.appointments[i].token_no {
                    vc.appointmentData = appointments[i]
                }
            }
//            vc.appointmentData = self.appointmentData
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
        if notification.userInfo?["department"] as! String == "doctor" {
        //show feedback after end consultation.
            let storyboard = UIStoryboard(name: "Modified", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ProcessFeedbackViewController") as! ProcessFeedbackViewController
            vc.index = 1
            for i in 0..<appointments.count {
                if notification.userInfo?["Token"]  as? String == self.appointments[i].token_no {
                    vc.appointmentData = appointments[i]
                }
            }
//            vc.appointmentData = self.appointmentData
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
            
        }
        self.fetchAppointments()
    }
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("HomeAppointmentRefreshNotification"), object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("HomeAppointmentRefreshNotification"), object: nil)
        getUserDetailsFromLocal()
        
        viewModel.fetchFamilySuccess = {
            
            DispatchQueue.main.async {
                self.appointmentsCollectionView.reloadData()
            }
        }
        self.userId = self.viewModel.userId ?? 0
        
                self.fetchAppointments()
        //        self.fetchFamilyMembers()
        
        
    }
    func vipView()
        {
            
        upcommingAppointmentsLabel.textColor = UIColor.white
        viewAllButton.setTitleColor(UIColor(named: "vip"), for: .normal)
        bgView.backgroundColor = UIColor.black
            headerView.backgroundColor = UIColor.black
           upcommingAppointmentsView.backgroundColor = UIColor.black
            appointmentsCollectionView.backgroundColor = UIColor.black
        scannerViewButton.setImage(UIImage(named: "vipscanner"), for: .normal)
        notificationButton.setImage(UIImage(named: "notificationvip"), for: .normal)
        logoImage.image = UIImage(named: "firstpass-logo")
        }
    func firebaseObserver(){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("TokenCalled").observe(.value, with: { snapshot in
          // Get user value
          let value = snapshot.value as? NSDictionary
          let username = value?["Token Id"] as? String ?? ""
            let Counter = value?["Counter"] as? String ?? ""
         print(username)
            print(Counter)
           
            if !self.itisInitialLoad {
                let storyboard = UIStoryboard(name: "Modified", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "TokenPopup") as! TokenPopup
                vc.modalPresentationStyle = .fullScreen
                vc.counter = Counter
                vc.token = username
                self.present(vc, animated: true, completion: nil)
            } else {
                self.itisInitialLoad = false
            }
        }) { error in
          print(error.localizedDescription)
        }
    }
    func firebaseDatabaseForNotification()
        {
            var ref: DatabaseReference!
            ref = Database.database().reference()
            
        ref.child("NotificationText").observe(.value, with: { [self] snapshot in
              // Get user value
              let value = snapshot.value as? NSDictionary
              let notificationText = value?["Notification"] as? String ?? ""
                
                if !self.itisInitialLoad {
                    if notificationText.contains("is called for") {
                        let fullNotificationString = notificationText
                        let fullNameArr = fullNotificationString.components(separatedBy: "your token number ")
                        debugPrint(fullNameArr[0])
                        let tokenSeperation = fullNameArr[1].components(separatedBy: " ")
                        debugPrint(tokenSeperation[0])
                        let counterNumberArray = fullNotificationString.components(separatedBy: ":")
                        debugPrint(counterNumberArray[1])
                        self.showTokenPopup(token: tokenSeperation[0], Counter: counterNumberArray[1])
                    } else if notificationText.contains("is ended for") {
                        let fullNotificationString = notificationText
                        let fullNameArr = fullNotificationString.components(separatedBy: "is ended for ")
                        debugPrint(fullNameArr[0])
                        let departmentSepaeration = fullNameArr[1].components(separatedBy: " ")
                        debugPrint(departmentSepaeration[0])
                        let fullTokenArr = fullNotificationString.components(separatedBy: "your token number ")
                        debugPrint(fullTokenArr[0])
                        let tokenSeperation = fullTokenArr[1].components(separatedBy: " ")
                        debugPrint(tokenSeperation[0])
                        NotificationCenter.default.post(name: Notification.Name("HomeAppointmentRefreshNotification"), object: nil, userInfo: ["department":"\(departmentSepaeration[0])","Token":"\(tokenSeperation[0])"])
                    }
                } else {
                    self.itisInitialLoad = false
                }
            }) { error in
              print(error.localizedDescription)
            }
        
    }
    
    func showTokenPopup(token:String,Counter:String){
        let storyboard = UIStoryboard(name: "Modified", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TokenPopup") as! TokenPopup
        vc.modalPresentationStyle = .fullScreen
        vc.token = token
        vc.counter = Counter
        self.present(vc, animated: true, completion: nil)
    }
    
    func getUserDetailsFromLocal(){
        
    }
    //    func fetchFamilyMembers(){
    //        familyActivityIndicator.startAnimating()
    //        familyActivityIndicator.isHidden = false
    //        viewModel.fetchFamilyMember(userId: viewModel.userId ?? 0)
    //        viewModel.fetchFamilySuccess = {
    //            self.familyMemberData = self.viewModel.familyMemberData ?? []
    //            self.familyMemberCount = self.viewModel.familyMemberData?.count ?? 0
    //            DispatchQueue.main.async {
    //                self.collectionview.reloadData()
    //            }
    //        }
    //        viewModel.loadingStatus = {
    //            if self.viewModel.isLoading{
    //                self.familyActivityIndicator.startAnimating()
    //                self.familyActivityIndicator.isHidden = false
    //            }else{
    //                self.familyActivityIndicator.stopAnimating()
    //                self.familyActivityIndicator.isHidden = true
    //            }
    //        }
    //        viewModel.errorMessageAlert = {
    //            if self.viewModel.errorMessage == ""{
    //
    //            }else{
    //                self.showAlert(self.viewModel.errorMessage ?? "Error")
    //            }
    //        }
    //    }
        func fetchAppointments(){
            self.activityIndicator(self.view, startAnimate: true)
             viewModel.fetchUpcomingAppointments()
            viewModel.fetchSuccess = { [self] in
                self.appointments = (self.viewModel.appointmentData?.appointments)!
                var tempappointments = [ActiveAppointmentData]()
                for i in  0..<self.appointments.count {
                    var journeyDetails : JourneyDetails?
                    if self.appointments[i].appt_status == "FLOTING" {
                        let key =  "JOURNEY" + (self.appointments[i].trans_id)!
                        do {
                            if let data = UserDefaults.standard.data(forKey: key) {
                                let journey  = try PropertyListDecoder().decode(JourneyDetails.self, from: data)
                                journeyDetails = journey
                            }
                        } catch {
                            debugPrint(error)
                        }
                        
                        if journeyDetails != nil {
                            if journeyDetails?.currentJourneyUpdate == "Finish Token" {
                                self.historyAppointments.append(self.appointments[i])
                            }else {
                                tempappointments.append(self.appointments[i])
                            }
                        } else {
                            tempappointments.append(self.appointments[i])
                        }
                    } else {
                        tempappointments.append(self.appointments[i])
                    }
                    
                }
                self.appointments = tempappointments
                DispatchQueue.main.async {
                    self.appointmentsCollectionView.reloadData()
                }
            }
    
            viewModel.loadingStatus = {
                if self.viewModel.isLoading{
                    self.activityIndicator(self.view, startAnimate: true)
//                    self.appointmentActivityIndicator.isHidden = false
                }else{
                    self.activityIndicator(self.view, startAnimate: false)
                    UIApplication.shared.endIgnoringInteractionEvents()
//                    self.appointmentActivityIndicator.isHidden = true
                }
            }
    
            viewModel.errorMessageAlert = {
                if self.viewModel.errorMessage == ""{
    
                }else{
                    self.showAlert(self.viewModel.errorMessage ?? "Error")
                   
                    DispatchQueue.main.async {
                        self.appointmentsCollectionView.reloadData()
                    }
                }
            }
        }
    
    
    func scanFinished(code:String) {
        dismiss(animated: true, completion: nil)
        //        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        //        let vc = storyboard.instantiateViewController(withIdentifier: "NewTokenViewController") as! NewTokenViewController
        //        vc.modalPresentationStyle = .fullScreen
        //        present(vc, animated: true)
        //        checkInAppointmentAction()
        createBlurView()
        createCheckIn(appointmentName: code)
    }
    @IBAction func showProfile(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        vc.modalPresentationStyle = .fullScreen
        //        view.window!.layer.add(rightToLeftTransition(), forKey: kCATransition)
        present(vc, animated: true)
    }
    @IBAction func showNotifications(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Modified", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "AlertNotificationViewController") as! AlertNotificationViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    @IBAction func openScanner(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Modified", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "ScannerViewController") as! ScannerViewController
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        //        view.window!.layer.add(rightToLeftTransition(), forKey: kCATransition)
        present(vc, animated: true)
    }
    @IBAction func myFamily(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "FamilyMemberViewController") as! FamilyMemberViewController
        vc.userId = viewModel.userId ?? 0
        vc.modalPresentationStyle = .fullScreen
        //        view.window!.layer.add(rightToLeftTransition(), forKey: kCATransition)
        present(vc, animated: true)
    }
    
    @IBAction func upcomingAppointments(_ sender: Any) {
        let storyboard = UIStoryboard(name: "phase2", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "MyAppointmentsViewController") as! MyAppointmentsViewController
        vc.userId = userId
        vc.modalPresentationStyle = .fullScreen
        view.window!.layer.add(rightToLeftTransition(), forKey: kCATransition)
        present(vc, animated: true)
    }
    
    @IBAction func preArrivalButtonPressed(_ sender: Any) {
    }
    
    
    @IBAction func checkinButtonPressed(_ sender: Any) {
    }

    func setupUI(){
       //For Demo Purpose
        let appointment1 = ActiveAppointmentData(doctor_name: "Dr.Hussian", appt_status: "SCHEDULED", trans_id: "234567891101", appointment_time: "oct  10 2021 12:35:00:000pm", patient_name: "John", service: "Doctor", department: "Cardiology", token_no: "", token_status: "", room: "")
        let appointment2 = ActiveAppointmentData(doctor_name: "Dr.Suman", appt_status: "SCHEDULED", trans_id: "234567891102", appointment_time: "oct  10 2021 12:35:00:000pm", patient_name: "John", service: "Doctor", department: "Pediatrics", token_no: "", token_status: "", room: "")
        let appointment3 =  ActiveAppointmentData(doctor_name: "Dr.Jagan", appt_status: "SCHEDULED", trans_id: "234567891103", appointment_time: "oct  10 2021 12:35:00:000pm", patient_name: "John", service: "Doctor", department: "Lab", token_no: "", token_status: "", room: "")
        dummyAppointments = [appointment1,appointment2,appointment3]
        
    }
    
}


extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return viewModel.appointmentData?.appointmentDetails?.count ?? 0
        return dummyAppointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentTableViewCell", for: indexPath) as! AppointmentTableViewCell
        cell.delegate = self
        //        cell.updateAppointmentDataToUI(data: (viewModel.appointmentData?.appointmentDetails?[indexPath.row])!, indexpath: indexPath)
//        cell.updateAppointmentDataToUI(data: dummyAppointments[indexPath.row], indexpath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "AppointmentDetailsViewController") as! AppointmentDetailsViewController
        //        vc.appointmentData = viewModel.appointmentData?.appointmentDetails?[indexPath.row]
        vc.appointmentData = dummyAppointments[indexPath.row]
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
}
extension HomeViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.appointments.count != 0 {
            NoAppointmentsLabel.isHidden = true
        } else {
            return dummyAppointments.count
//            NoAppointmentsLabel.isHidden = false
        }
        return appointments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppointmentCollectionViewCell", for: indexPath) as! AppointmentCollectionViewCell
        let currentAppointment: ActiveAppointmentData
        if UserDefaults.standard.bool(forKey: "vip"){
            cell.appointmentsView.backgroundColor = UIColor(named: "vip")
            cell.DetailsView.backgroundColor = UIColor(named: "vip")
            cell.titleLabel.textColor = #colorLiteral(red: 0.3137254902, green: 0.2431372549, blue: 0, alpha: 1)
//            cell.
        } else {
            cell.appointmentsView.backgroundColor = #colorLiteral(red: 0.272008568, green: 0.2020958066, blue: 0.4683443308, alpha: 1)
            cell.DetailsView.backgroundColor = #colorLiteral(red: 0.272008568, green: 0.2020958066, blue: 0.4683443308, alpha: 1)
            cell.titleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            
        }
        
        if appointments.count != 0 {
         currentAppointment = self.appointments[indexPath.row]
        } else {
            currentAppointment = self.dummyAppointments[indexPath.row]
        }
        cell.titleLabel.text = currentAppointment.department
        
        if titleMenu[indexPath.row] == "In Patient"{
            cell.InPatientView.isHidden = false
        } else {
            cell.InPatientView.isHidden = true
        }
        if preArrivalfilled.contains(indexPath.row)
        {
            cell.prearrivalButtonHeight.constant = 0
            cell.prefilledLabel.isHidden = false
        }
        else
        {
            cell.prefilledLabel.isHidden = true
            cell.prearrivalButtonHeight.constant = 50
        }
        if checkinSelected == indexPath.row
        {
            let attrStri = NSMutableAttributedString.init(string:"Cancel")
            cell.prearrivalButton.setAttributedTitle(attrStri, for: .normal)
            cell.checkinButton.setTitle("Yes, Check-in", for: .normal)
            cell.noteLabel.text = "Are you sure you want to check in?"
        }
        else if currentAppointment.appt_status == "SCHEDULED"
        {
            cell.prearrivalButton.setTitle("Pre- arrival", for: .normal)
            cell.checkinButton.setTitle("Check-in", for: .normal)
            cell.noteLabel.text = "Note: Please arrive 15 mins early from the scheduled appointment time."
        }
        else {
            cell.prearrivalButton.setTitle("Pre- arrival", for: .normal)
            cell.checkinButton.setTitle("Check-in", for: .normal)
            cell.noteLabel.text = "Note: Please arrive 15 mins early from the scheduled appointment time."
        }
        
        if currentAppointment.appt_status == "CHECKIN" || currentAppointment.appt_status == "FLOTING"
        {
            if rolledIndex == indexPath.row {
            let flipDirection:UIView.AnimationOptions =  .transitionFlipFromRight
            let options: UIView.AnimationOptions = [flipDirection, .showHideTransitionViews]
                UIView.transition(from: cell.appointmentsView, to: cell.DetailsView, duration: 0.6, options: options) { [self]
                       finished in
                cell.DetailsView.isHidden = false
                    self.rolledIndex = -1
                   }
            }
            else {
                if currentAppointment.appt_status == "FLOTING" && currentAppointment.department == "Cardiology" {
                    var journeyDetails : JourneyDetails?
                        let key =  "JOURNEY" + (currentAppointment.trans_id)!
                        do {
                            if let data = UserDefaults.standard.data(forKey: key) {
                                let journey  = try PropertyListDecoder().decode(JourneyDetails.self, from: data)
                                journeyDetails = journey
                            }
                        } catch {
                            debugPrint(error)
                        }
                        
                        if journeyDetails != nil {
                            if journeyDetails?.currentJourneyUpdate == "ECG" {
                                cell.currentStepDetails.text = "ECG"
                            }else if  journeyDetails?.currentJourneyUpdate == "X-ray"  {
                                cell.currentStepDetails.text = "X-ray"
                            }
                            else if  journeyDetails?.currentJourneyUpdate == "Pharmacy"  {
                                cell.currentStepDetails.text = "Pharmacy"
                            } else {
                                cell.currentStepDetails.text = "ECG"
                            }
                        } else {
                            cell.currentStepDetails.text = "ECG"
                        }
                } else if currentAppointment.appt_status == "FLOTING" && currentAppointment.department != "Cardiology" {
                    cell.currentStepDetails.text = "Pharmacy"
                    }
                if currentAppointment.appt_status == "CHECKIN" {
                    switch currentAppointment.token_status {
                    case "R-WAITING" ,"R-SERVING":
                        cell.currentStepDetails.text = "Registration"
                    case "V-WAITING","V-SERVING":
                        cell.currentStepDetails.text = "Vitals"
                    case "WAITING","SERVING":
                    cell.currentStepDetails.text = "Consultation"
                    default:
                        print("Registration")
                    }
                }
                cell.DetailsView.isHidden = false
            }
            
            cell.TitleCheckedIn.text = currentAppointment.department
            cell.doctorName.text = currentAppointment.doctor_name
            let dateString = currentAppointment.appointment_time!
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM  d yyyy h:mm:ss:SSSa"
            if let date = formatter.date(from: dateString) {
                formatter.dateFormat = "dd-MM-yyyy"
                let string = formatter.string(from: date)
                print(string)
                cell.dateOngoing.text = string
                formatter.dateFormat = "h:mm a"
                let stringTime = formatter.string(from: date)
                cell.timeOngoing.text = stringTime
            }
            
        }
        else
        {
            cell.appointmentsView.isHidden = false
            cell.DetailsView.isHidden = true
        }
        
        cell.doctorNameCurrent.text = currentAppointment.doctor_name
        cell.patientNameCurrent.text = currentAppointment.patient_name
        
        let dateString = currentAppointment.appointment_time!
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM  d yyyy h:mm:ss:SSSa"
        if let date = formatter.date(from: dateString) {
            formatter.dateFormat = "dd-MM-yyyy"
            let string = formatter.string(from: date)
            print(string)
            cell.appointmentDateCurrent.text = string
            formatter.dateFormat = "h:mm a"
            let stringTime = formatter.string(from: date)
            cell.appointmentTimeCurrent.text = stringTime
        }
            
            
        cell.prearrivalButton.accessibilityHint = cell.prearrivalButton.titleLabel?.text!
        cell.prearrivalButton.tag = indexPath.row
        cell.checkinButton.tag = indexPath.row
        cell.checkinButton.accessibilityHint = cell.checkinButton.titleLabel?.text!
        cell.viewDetailsButton.tag = indexPath.row
        
        cell.checkinButton.addTarget(self, action: #selector(CheckinButtonPressed(sender:)), for: .touchUpInside)
        cell.prearrivalButton.addTarget(self, action: #selector(prearrivalButtonPressed(sender:)), for: .touchUpInside)
        cell.indoorMapButton.addTarget(self, action: #selector(indoorMapButtonPressed(sender:)), for: .touchUpInside)
        cell.indoorMapDetails.addTarget(self, action: #selector(indoorMapButtonPressed(sender:)), for: .touchUpInside)
        cell.viewDetailsInPatientButton.addTarget(self, action: #selector(ViewDetailsInPatientPressed(sender:)), for: .touchUpInside)
        cell.viewDetailsButton.addTarget(self, action: #selector(ViewDetailsPressed(sender:)), for: .touchUpInside)
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//       if let cIndexPath = layout.currentCenteredIndexPath,
//          cIndexPath != indexPath {
//        layout.scrollToPage(atIndex: indexPath.row)
//      }
//    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? AppointmentCollectionViewCell else { return }
        cell.appointmentsView.backgroundColor = #colorLiteral(red: 0.2078431373, green: 0.137254902, blue: 0.3921568627, alpha: 1)
    }
    
    @objc func CheckinButtonPressed(sender : UIButton)
    {
        if sender.accessibilityHint! == "Check-in" && checkinSelected != sender.tag {
            self.checkinSelected = sender.tag
            appointmentsCollectionView.reloadData()
        }
        else
        {
            if (appointments.count != 0){
            self.checkInAppointmentAction(index: sender.tag)
            } else {
                dummyAppointments[sender.tag].appt_status = "CHECKIN"
                dummyAppointments[sender.tag].token_no = "CROO\(sender.tag)"
               let journey = JourneyDetails(tokenNo: "CROO\(sender.tag)", currentStatus: "1", CompletedStatus: [], currentJourneyUpdate: "Registration")
                let key = "JOURNEY" + dummyAppointments[sender.tag].trans_id!
                do {
                    let data = try PropertyListEncoder().encode(journey)
                    UserDefaults.standard.set(data, forKey: key)
                } catch let error {
                    debugPrint(error)
                }
                
                self.appointmentsCollectionView.reloadData()
            }
//            self.appointmentBooked = sender.tag
//            appointmentsCollectionView.reloadData()
        }
    }
    
    @objc func prearrivalButtonPressed(sender : UIButton)
    {
        if sender.accessibilityHint! == "Pre- arrival"
        {
            let storyboard = UIStoryboard(name: "Modified", bundle: .main)
            let vc = storyboard.instantiateViewController(withIdentifier: "PreChekinPopup") as! PreChekinPopup
            vc.modalPresentationStyle = .fullScreen
            self.view.window!.layer.add(self.rightToLeftTransition(), forKey: kCATransition)
            self.present(vc, animated: true)
            self.preArrivalfilled.append(sender.tag)
            print(sender.tag)
            appointmentsCollectionView.reloadData()
        }
        else
        {
            self.checkinSelected = -1
            self.appointmentBooked = -1
        }
    }
    
    @objc func indoorMapButtonPressed(sender: UIButton)
    {
//        let storyboard = UIStoryboard(name: "Modified", bundle: .main)
//        let vc = storyboard.instantiateViewController(withIdentifier: "IndoorMapViewController") as! IndoorMapViewController
//        vc.modalPresentationStyle = .fullScreen
//        self.view.window!.layer.add(self.rightToLeftTransition(), forKey: kCATransition)
//        self.present(vc, animated: true)
//        NotificationCenter.default.post(name: Notification.Name("HomeAppointmentRefreshNotification"), object: nil, userInfo: ["department":"doctor","Token":"CLA274"])
    }
    @objc func ViewDetailsInPatientPressed(sender : UIButton)    {
        let storyboard = UIStoryboard(name: "phase2", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "InPatientViewController") as! InPatientViewController
        vc.modalPresentationStyle = .fullScreen
        self.view.window!.layer.add(self.rightToLeftTransition(), forKey: kCATransition)
        self.present(vc, animated: true)
    }
    @objc func ViewDetailsPressed(sender : UIButton)    {
        let storyboard = UIStoryboard(name: "phase2", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "AppointmentDetailsViewController") as! AppointmentDetailsViewController
        vc.modalPresentationStyle = .fullScreen
        if appointments.count != 0 {
        vc.appointmentData = self.appointments[sender.tag]
            switch  self.appointments[sender.tag].token_status{
            case "R-SERVING","R-WAITING":
                updateJourney(Status:"Registration",index:sender.tag)
            case "V-WAITING","V-SERVING":
                updateJourney(Status: "Vitals", index: sender.tag)
            case "WAITING","SERVING":
                updateJourney(Status: "Consultation", index: sender.tag)
            case "FLOTING" :
                if self.appointments[sender.tag].department == "Cardiology"{
                    var journeyDetails : JourneyDetails?
                        let key =  "JOURNEY" + (self.appointments[sender.tag].trans_id)!
                        do {
                            if let data = UserDefaults.standard.data(forKey: key) {
                                let journey  = try PropertyListDecoder().decode(JourneyDetails.self, from: data)
                                journeyDetails = journey
                            }
                        } catch {
                            debugPrint(error)
                        }
                        
                        if journeyDetails != nil {
                            if journeyDetails?.currentJourneyUpdate == "ECG" {
                                updateJourney(Status:"ECG",index: sender.tag)
                            }else if  journeyDetails?.currentJourneyUpdate == "X-ray"  {
                                updateJourney(Status:"X-ray",index: sender.tag)
                            }
                            else if  journeyDetails?.currentJourneyUpdate == "Pharmacy"  {
                                updateJourney(Status:"Pharmacy",index: sender.tag)
                            } else {
                                updateJourney(Status:"ECG",index: sender.tag)
                            }
                        } else {
                            updateJourney(Status:"ECG",index: sender.tag)
                        }
                } else {
                    updateJourney(Status:"Pharmacy",index: sender.tag)
                }
            default:
                updateJourney(Status:"Registration",index:sender.tag)
            }
            
//            if self.appointments[sender.tag].token_status == "R-SERVING" {
////                let journey = JourneyDetails(tokenNo: self.appointments[sender.tag].token_no, currentStatus: "1", CompletedStatus: [], currentJourneyUpdate: "Registration")
////                 let key = "JOURNEY" + self.appointments[sender.tag].trans_id!
////                 do {
////                     let data = try PropertyListEncoder().encode(journey)
////                     UserDefaults.standard.set(data, forKey: key)
////                 } catch let error {
////                     debugPrint(error)
////                 }
//                updateJourney(Status:"Registration",index:sender.tag)
//            } else
//            if self.appointments[sender.tag].token_status == "V-WAITING" {
//                let journey = JourneyDetails(tokenNo: self.appointments[sender.tag].token_no, currentStatus: "1", CompletedStatus: [], currentJourneyUpdate: "Vitals")
//                 let key = "JOURNEY" + self.appointments[sender.tag].trans_id!
//                 do {
//                     let data = try PropertyListEncoder().encode(journey)
//                     UserDefaults.standard.set(data, forKey: key)
//                 } catch let error {
//                     debugPrint(error)
//                 }
//            }
//            else
//            if self.appointments[sender.tag].token_status == "FLOTING" {
//                let journey = JourneyDetails(tokenNo: self.appointments[sender.tag].token_no, currentStatus: "1", CompletedStatus: [], currentJourneyUpdate: "Pharmacy")
//                 let key = "JOURNEY" + self.appointments[sender.tag].trans_id!
//                 do {
//                     let data = try PropertyListEncoder().encode(journey)
//                     UserDefaults.standard.set(data, forKey: key)
//                 } catch let error {
//                     debugPrint(error)
//                 }
//            }
            
        } else {
            vc.appointmentData = self.dummyAppointments[sender.tag]
        }
        self.view.window!.layer.add(self.rightToLeftTransition(), forKey: kCATransition)
        self.present(vc, animated: true)
    }
    
    func  updateJourney(Status:String,index:Int){
        let journey = JourneyDetails(tokenNo: self.appointments[index].token_no, currentStatus: "1", CompletedStatus: [], currentJourneyUpdate: Status)
        let key = "JOURNEY" + self.appointments[index].trans_id!
        do {
            let data = try PropertyListEncoder().encode(journey)
            UserDefaults.standard.set(data, forKey: key)
        } catch let error {
            debugPrint(error)
        }
    }
    
    
}

extension HomeViewController{
    func createBlurView(){
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.backgroundColor = UIColor(red: 28.0/255.0, green: 29.0/255.0, blue: 48.0/255, alpha: 0.8)
        //        blurView.alpha = 0.8
        view.addSubview(blurView)
        blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        blurView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        blurView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8).isActive = true
        blurView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(closePopUp))
        blurView.addGestureRecognizer(gesture)
    }
    @objc func closePopUp(){
        
    }
    @objc func checkInAppointmentAction(index:Int){
            self.activityIndicator(self.view, startAnimate: true)
        let params = [
            "transid": self.appointments[index].trans_id]
        viewModel.createCheckin(params: params as Dictionary<String, Any>)
            viewModel.fetchSuccess = { [self] in
                self.rolledIndex = index
                self.fetchAppointments()
                let journey = JourneyDetails(tokenNo: self.appointments[index].token_no, currentStatus: "1", CompletedStatus: [], currentJourneyUpdate: "Registration")
                let key = "JOURNEY" + self.appointments[index].trans_id!
                 do {
                     let data = try PropertyListEncoder().encode(journey)
                     UserDefaults.standard.set(data, forKey: key)
                 } catch let error {
                     debugPrint(error)
                 }
               
               
//                DispatchQueue.main.async {
//                    self.appointmentsCollectionView.reloadData()
//                }
            }
    
            viewModel.loadingStatus = {
                if self.viewModel.isLoading{
                    self.activityIndicator(self.view, startAnimate: true)
//                    self.appointmentActivityIndicator.isHidden = false
                }else{
                    self.activityIndicator(self.view, startAnimate: false)
                    UIApplication.shared.endIgnoringInteractionEvents()
//                    self.appointmentActivityIndicator.isHidden = true
                }
            }
    
            viewModel.errorMessageAlert = {
                if self.viewModel.errorMessage == ""{
    
                }else{
                    self.showAlert(self.viewModel.errorMessage ?? "Error")
                }
            }
        }
        
    @objc func checkinAppointmentQRCode() {
            self.activityIndicator(self.view, startAnimate: true)
        let params = [
            "department":codefromScan]
        viewModel.createqrCheckin(params: params as Dictionary<String, Any>)
            viewModel.fetchSuccess = { [self] in
//                self.rolledIndex = index
                self.fetchAppointments()
               
                DispatchQueue.main.async {
                    self.appointmentsCollectionView.reloadData()
                }
            }
    
            viewModel.loadingStatus = {
                if self.viewModel.isLoading{
                    self.activityIndicator(self.view, startAnimate: true)
//                    self.appointmentActivityIndicator.isHidden = false
                }else{
                    self.activityIndicator(self.view, startAnimate: false)
                    UIApplication.shared.endIgnoringInteractionEvents()
//                    self.appointmentActivityIndicator.isHidden = true
                }
            }
        blurView.removeFromSuperview()
        checkInView.removeFromSuperview()
        for view in checkInView.subviews{
            view.removeFromSuperview()
        }
            viewModel.errorMessageAlert = {
                if self.viewModel.errorMessage == ""{
    
                }else{
                    self.showAlert(self.viewModel.errorMessage ?? "Error")
                }
            }
        }
    
    @objc func cancelCheckInAction(){
        blurView.removeFromSuperview()
        checkInView.removeFromSuperview()
        for view in checkInView.subviews{
            view.removeFromSuperview()
        }
    }
    
    //Password change Success POPUP view
    func createCheckIn(appointmentName:String){
        createBlurView()
        checkInView.layer.cornerRadius = 30
        checkInView.backgroundColor = UIColor(hexString: "#fbfbfb")
        view.addSubview(checkInView)
        
        checkInView.translatesAutoresizingMaskIntoConstraints = false
        checkInView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        checkInView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        checkInView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        let cancelButton = UIButton()
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.backgroundColor = UIColor.white
        cancelButton.createBorderForButton(cornerRadius: 10, borderWidth: 1, borderColor: .black)
        cancelButton.titleLabel?.font =  UIFont.systemFont(ofSize: 14, weight: .bold)
        cancelButton.addTarget(self, action: #selector(cancelCheckInAction), for: .touchUpInside)
        cancelButton.layer.cornerRadius = 10
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        checkInView.addSubview(cancelButton)
        cancelButton.leadingAnchor.constraint(equalTo: checkInView.leadingAnchor,constant: 30).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: checkInView.trailingAnchor,constant: -30).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: checkInView.bottomAnchor,constant: -20).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        codefromScan = appointmentName
        
        let checkInButton = UIButton()
        checkInButton.setTitle("Check in", for: .normal)
        checkInButton.setTitleColor(.white, for: .normal)
        checkInButton.backgroundColor = UIColor(hexString: Colors.buttonColor)
        checkInButton.titleLabel?.font =  UIFont.systemFont(ofSize: 14, weight: .bold)
        checkInButton.addTarget(self, action: #selector(checkinAppointmentQRCode), for: .touchUpInside)
        checkInButton.layer.cornerRadius = 10
        checkInButton.translatesAutoresizingMaskIntoConstraints = false
        checkInView.addSubview(checkInButton)
        checkInButton.leadingAnchor.constraint(equalTo: checkInView.leadingAnchor,constant: 30).isActive = true
        checkInButton.trailingAnchor.constraint(equalTo: checkInView.trailingAnchor,constant: -30).isActive = true
        checkInButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor,constant: -20).isActive = true
        checkInButton.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        
        let label = UILabel()
        label.text = "are you sure you want to check in, " + appointmentName
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = UIColor(hexString: "#35373a")
        label.textAlignment = .center
        //        label.backgroundColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        checkInView.addSubview(label)
        label.leadingAnchor.constraint(equalTo: checkInView.leadingAnchor,constant: 30).isActive = true
        label.trailingAnchor.constraint(equalTo: checkInView.trailingAnchor,constant: -30).isActive = true
        label.bottomAnchor.constraint(equalTo: checkInButton.topAnchor,constant: -40).isActive = true
        label.topAnchor.constraint(equalTo: checkInView.topAnchor,constant: 30).isActive = true
    }
    
}

extension HomeViewController:CheckInDelegate{
    func appointmentArrived(appointmentIndex: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "ArrivedPopup") as! ArrivedPopup
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    func appointmentParking(appointmentIndex: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "ParkingMapPopup") as! ParkingMapPopup
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    func appointmentPreCheckIn(appointmentIndex: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "PreChekinPopup") as! PreChekinPopup
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    func appointmentCheckIn(appointmentIndex: Int) {
        createBlurView()
        //        createCheckIn(appointmentName: viewModel.appointmentData?.appointmentDetails?[appointmentIndex].serviceName ?? "")
        NSLog("Tag------->%d", appointmentIndex)
//        CurrentAppointment = dummyAppointments[appointmentIndex].serviceName ?? ""
//        createCheckIn(appointmentName: dummyAppointments[appointmentIndex].serviceName ?? "")
    }
    
    func appointmentIndoorMap(appointmentIndex: Int) {
        
    }
}
extension HomeViewController:BottomViewDelegate
{
    func AccountsClicked()
    {
        let storyboard = UIStoryboard(name: "Modified", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "AccountViewController") as! AccountViewController
        //NSLog("corrent app %@---->", CurrentAppointment);
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    func AppointmentsClicked() {
        
    }
    func VideCallClicked() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("VideoCallForNurse").setValue(["Token Id": "Nurse0002"])
        
        self.cleanUp()
        let jitsiMeetView = JitsiMeetView()
        jitsiMeetView.delegate = self
        self.jitsiMeetView = jitsiMeetView
        let options = JitsiMeetConferenceOptions.fromBuilder { (builder) in
            builder.welcomePageEnabled = false
            builder.room = "Nurse0002"
        }
        jitsiMeetView.join(options)

        // Enable jitsimeet view to be a view that can be displayed
        // on top of all the things, and let the coordinator to manage
        // the view state and interactions
        self.pipViewCoordinator = PiPViewCoordinator(withView: jitsiMeetView)
        self.pipViewCoordinator?.configureAsStickyView(withParentView: self.view)

        // animate in
        jitsiMeetView.alpha = 0
        self.pipViewCoordinator?.show()
        
    }
    
    fileprivate func cleanUp() {
        jitsiMeetView?.removeFromSuperview()
        jitsiMeetView = nil
        pipViewCoordinator = nil
    }
    
    
}
protocol CheckInDelegate{
    func appointmentCheckIn(appointmentIndex:Int)
    func appointmentIndoorMap(appointmentIndex:Int)
    func appointmentPreCheckIn(appointmentIndex:Int)
    func appointmentArrived(appointmentIndex:Int)
    func appointmentParking(appointmentIndex:Int)
}


extension HomeViewController: JitsiMeetViewDelegate {
    func conferenceTerminated(_ data: [AnyHashable : Any]!) {
        DispatchQueue.main.async {
            self.pipViewCoordinator?.hide() { _ in
                self.cleanUp()
            }
        }
    }

    func enterPicture(inPicture data: [AnyHashable : Any]!) {
        DispatchQueue.main.async {
            self.pipViewCoordinator?.enterPictureInPicture()
        }
    }
}
