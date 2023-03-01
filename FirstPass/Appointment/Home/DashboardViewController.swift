//
//  DashboardViewController.swift
//  FirstPass
//
//  Created by MacOS on 22/11/22.
//  Copyright © 2022 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import AlamofireImage
import FirebaseDatabase
import JitsiMeetSDK


class DashboardViewController: UIViewController,ScanFinishedDelegate {

    @IBOutlet weak var bottomMenuView: Tabbar!

    @IBOutlet weak var collectionviewImages: UICollectionView!
    let menus = ["dashboard1","dashboard2","dashboard3"]
    
    fileprivate var pipViewCoordinator: PiPViewCoordinator?
    fileprivate var jitsiMeetView: JitsiMeetView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionviewImages.delegate = self
        collectionviewImages.dataSource = self
        collectionviewImages.isPagingEnabled = true
//        collectionviewImages.
        if let layout = collectionviewImages.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        bottomMenuView.delegate = self
    }
    
    @IBAction func searchDoctorPressed(_ sender: Any) {
        
    }
    
    @IBAction func showNotificationPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Modified", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "AlertNotificationViewController") as! AlertNotificationViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func scanPressed(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Modified", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "ScannerViewController") as! ScannerViewController
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        //        view.window!.layer.add(rightToLeftTransition(), forKey: kCATransition)
        present(vc, animated: true)
    }
    
    @IBAction func namePressed(_ sender: Any) {
    NotificationPressed()
    }
    func fromdate() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d, yyyy"
     //   let date3 = dateFormatter.date(from:isoDate)!
        let yesterday = Calendar.current.date(byAdding: .day, value: +1, to: Date())
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "dd-MM-yyyy"
        let prevDate = dateFormatter1.string(from: yesterday!)
        return prevDate
    }
    
    func NotificationPressed()
    {
        print("buttonIsPressed function called \(fromdate())");
        let content = UNMutableNotificationContent()
        content.title = "First Pass"
        content.body = "You have a scheduled appointment with Dr Omar for Cardiology on \(fromdate()) in VM care hospital. Please reconfirm your appointment through the mobile app"
        content.categoryIdentifier = "notify-test"
//        let taskData = try? JSONEncoder().encode(task)
//        if let taskData = taskData {
          content.userInfo = ["Task": "Date"]
//        }

        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest.init(identifier: "notify-test", content: content, trigger: trigger)

        let center = UNUserNotificationCenter.current()
        center.add(request)
    }
    
    @IBAction func FindADoctorPressed(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Modified", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DoctorLookupViewController") as! DoctorLookupViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func BookAppointmentPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Modified", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BookAppointmentViewController") as! BookAppointmentViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func appointmentPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "phase2", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        vc.isfrom = "Dashboard"
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func telehealthPressed(_ sender: Any) {
        guard let url = URL(string: "https://us04web.zoom.us/j/5681256622?pwd=VWJnaVlJUUl5bkFOdk9kQ2EzUmdKUT09") else { return }
        UIApplication.shared.open(url)
    }
    
    
    @IBAction func reportPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Modified", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ReportsViewController") as! ReportsViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func pharmacyRefillpressed(_ sender: Any) {
        
    }
    
    
    @IBAction func chatWithUsPressed(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "phase2", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "ChatwithusViewController") as! ChatwithusViewController
//        UserDefaults.standard.set(false, forKey: "isLoggedIn")
//        vc.modalPresentationStyle = .fullScreen
//
//        present(vc, animated: true, completion: nil)
        
        let phoneNumber =  "+97142477772" // you need to change this number
        let appURL = URL(string: "https://api.whatsapp.com/send?phone=\(phoneNumber)")!
        if UIApplication.shared.canOpenURL(appURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            }
            else {
                UIApplication.shared.openURL(appURL)
            }
        }

    }
    
    @IBAction func vitalsPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "phase2", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "VitalsGraphViewController") as! VitalsGraphViewController
        vc.modalPresentationStyle = .fullScreen
        self.view.window!.layer.add(self.rightToLeftTransition(), forKey: kCATransition)
        self.present(vc, animated: true)
    }
    
    
    @IBAction func selfAssestmentPressed(_ sender: Any) {
    }
    
    @IBAction func bmicalculatorPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Modified", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BMICalculatorViewController") as! BMICalculatorViewController
        vc.modalPresentationStyle = .fullScreen

        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func contactsPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Modified", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ContactsViewController") as! ContactsViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func privillagesPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Modified", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SpecialOffersViewController") as! SpecialOffersViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func feedbackPressed(_ sender: Any) {
        
    }
    
   
    func scanFinished(code:String) {
        dismiss(animated: true, completion: nil)
        //        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        //        let vc = storyboard.instantiateViewController(withIdentifier: "NewTokenViewController") as! NewTokenViewController
        //        vc.modalPresentationStyle = .fullScreen
        //        present(vc, animated: true)
        //        checkInAppointmentAction()
        createBlurView()
//        createCheckIn(appointmentName: code)
    }

    func createBlurView(){
//        blurView.translatesAutoresizingMaskIntoConstraints = false
//        blurView.backgroundColor = UIColor(red: 28.0/255.0, green: 29.0/255.0, blue: 48.0/255, alpha: 0.8)
        //        blurView.alpha = 0.8
//        view.addSubview(blurView)
//        blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        blurView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        blurView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8).isActive = true
//        blurView.isUserInteractionEnabled = true
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(closePopUp))
//        blurView.addGestureRecognizer(gesture)
    }
    
    
//    @objc func checkInAppointmentAction(index:Int){
//            self.activityIndicator(self.view, startAnimate: true)
//        let params = [
//            "transid": self.appointments[index].trans_id]
//        viewModel.createCheckin(params: params as Dictionary<String, Any>)
//            viewModel.fetchSuccess = { [self] in
//                self.rolledIndex = index
//                self.fetchAppointments()
//                let journey = JourneyDetails(tokenNo: self.appointments[index].token_no, currentStatus: "1", CompletedStatus: [], currentJourneyUpdate: "Registration")
//                let key = "JOURNEY" + self.appointments[index].trans_id!
//                 do {
//                     let data = try PropertyListEncoder().encode(journey)
//                     UserDefaults.standard.set(data, forKey: key)
//                 } catch let error {
//                     debugPrint(error)
//                 }
//
//
////                DispatchQueue.main.async {
////                    self.appointmentsCollectionView.reloadData()
////                }
//            }
//
//            viewModel.loadingStatus = {
//                if self.viewModel.isLoading{
//                    self.activityIndicator(self.view, startAnimate: true)
////                    self.appointmentActivityIndicator.isHidden = false
//                }else{
//                    self.activityIndicator(self.view, startAnimate: false)
//                    UIApplication.shared.endIgnoringInteractionEvents()
////                    self.appointmentActivityIndicator.isHidden = true
//                }
//            }
//
//            viewModel.errorMessageAlert = {
//                if self.viewModel.errorMessage == ""{
//
//                }else{
//                    self.showAlert(self.viewModel.errorMessage ?? "Error")
//                }
//            }
//        }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension DashboardViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menus.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboardimagesCVC",for: indexPath) as? dashboardimagesCVC {
            cell.imageViewDashboard.image = UIImage(named: "\(menus[indexPath.row])")
            cell.imageViewDashboard.contentMode = .scaleAspectFill
            return cell
        }
        return UICollectionViewCell()
    }
    
}

extension DashboardViewController:BottomViewDelegate
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
        let storyboard = UIStoryboard(name: "phase2", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
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
//            builder.welcomePageEnabled = false
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
}

extension DashboardViewController: JitsiMeetViewDelegate {
    fileprivate func cleanUp() {
        jitsiMeetView?.removeFromSuperview()
        jitsiMeetView = nil
        pipViewCoordinator = nil
    }
    
    
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
extension Date {
    var nextDay: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    
}
