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

class HomeViewController: UIViewController,ScanFinishedDelegate {
    
    @IBOutlet weak var notificationButton: UIButton!
    
    @IBOutlet weak var scannerViewButton: UIButton!
    
    
    @IBOutlet weak var upcommingAppointmentsLabel: UILabel!
    
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
    
    var titleMenu = ["Medicine Collections","Cardiology","Cardiology"]
    var checkinSelected = -1
    var appointmentBooked = -1
    var preArrivalfilled = [Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        appointmentsCollectionView.dataSource = self
        appointmentsCollectionView.delegate = self
        setupUI()
        //        getUserDetailsFromLocal()
        bottomMenuView.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getUserDetailsFromLocal()
        
        //        viewModel.getUserDetails()
        viewModel.fetchFamilySuccess = {
            
            DispatchQueue.main.async {
                self.appointmentsCollectionView.reloadData()
            }
        }
        self.userId = self.viewModel.userId ?? 0
        
        //        self.fetchAppointments()
        //        self.fetchFamilyMembers()
        
        
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
    //    func fetchAppointments(){
    //        appointmentActivityIndicator.startAnimating()
    //        appointmentActivityIndicator.isHidden = false
    //        viewModel.fetchUpcomingAppointments(userId: userId)
    //        viewModel.fetchSuccess = {
    //            self.appointmentActivityIndicator.stopAnimating()
    //            self.appointmentActivityIndicator.isHidden = true
    //            DispatchQueue.main.async {
    //                self.tableview.reloadData()
    //            }
    //        }
    //
    //        viewModel.loadingStatus = {
    //            if self.viewModel.isLoading{
    //                self.appointmentActivityIndicator.startAnimating()
    //                self.appointmentActivityIndicator.isHidden = false
    //            }else{
    //                self.appointmentActivityIndicator.stopAnimating()
    //                self.appointmentActivityIndicator.isHidden = true
    //            }
    //        }
    //
    //        viewModel.errorMessageAlert = {
    //            if self.viewModel.errorMessage == ""{
    //
    //            }else{
    //                self.showAlert(self.viewModel.errorMessage ?? "Error")
    //            }
    //        }
    //    }
    func scanFinished() {
        dismiss(animated: true, completion: nil)
        //        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        //        let vc = storyboard.instantiateViewController(withIdentifier: "NewTokenViewController") as! NewTokenViewController
        //        vc.modalPresentationStyle = .fullScreen
        //        present(vc, animated: true)
        //        checkInAppointmentAction()
        createBlurView()
        createCheckIn(appointmentName: "Cardiology")
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
        
        //For demo purpose
        let appointment1 = ActiveAppointmentData(pId: 0, mrnNo: "", patientName: "Patient 1", doctorName: "Doctor 1", departmentName: "Cardiology", serviceName: "Cardiology", appointmentTime: "2021-01-06 15:00:00", serviceBookedId: 0, status: "")
        let appointment2 = ActiveAppointmentData(pId: 0, mrnNo: "", patientName: "Patient 1", doctorName: "Doctor 1", departmentName: "Laboratory", serviceName: "Laboratory", appointmentTime: "2021-01-06 16:00:00", serviceBookedId: 0, status: "")
        let appointment3 = ActiveAppointmentData(pId: 0, mrnNo: "", patientName: "Patient 1", doctorName: "Doctor 1", departmentName: "Internal Medicine", serviceName: "Internal Medicine", appointmentTime: "2021-01-06 16:30:00", serviceBookedId: 0, status: "")
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
        cell.updateAppointmentDataToUI(data: dummyAppointments[indexPath.row], indexpath: indexPath)
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
        
        return titleMenu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppointmentCollectionViewCell", for: indexPath) as! AppointmentCollectionViewCell
        cell.titleLabel.text = titleMenu[indexPath.row]
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
        else
        {
            cell.prearrivalButton.setTitle("Pre- arrival", for: .normal)
            cell.checkinButton.setTitle("Check-in", for: .normal)
            cell.noteLabel.text = "Note: Please arrive 15 mins early from the scheduled appointment time."
        }
        
        if appointmentBooked == indexPath.row
        {
            cell.DetailsView.isHidden = false
        }
        else
        {
            cell.DetailsView.isHidden = true
        }
        
        cell.prearrivalButton.accessibilityHint = cell.prearrivalButton.titleLabel?.text!
        cell.prearrivalButton.tag = indexPath.row
        cell.checkinButton.tag = indexPath.row
        cell.checkinButton.accessibilityHint = cell.checkinButton.titleLabel?.text!
        
        cell.checkinButton.addTarget(self, action: #selector(CheckinButtonPressed(sender:)), for: .touchUpInside)
        cell.prearrivalButton.addTarget(self, action: #selector(prearrivalButtonPressed(sender:)), for: .touchUpInside)
        cell.indoorMapButton.addTarget(self, action: #selector(indoorMapButtonPressed(sender:)), for: .touchUpInside)
        cell.indoorMapDetails.addTarget(self, action: #selector(indoorMapButtonPressed(sender:)), for: .touchUpInside)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 538)
    }
    
    @objc func CheckinButtonPressed(sender : UIButton)
    {
        if sender.accessibilityHint! == "Check-in" {
            self.checkinSelected = sender.tag
            appointmentsCollectionView.reloadData()
        }
        else
        {
            self.appointmentBooked = sender.tag
            appointmentsCollectionView.reloadData()
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
    @objc func checkInAppointmentAction(){
        blurView.removeFromSuperview()
        for view in checkInView.subviews{
            view.removeFromSuperview()
        }
        checkInView.removeFromSuperview()
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "NewTokenViewController") as! NewTokenViewController
        NSLog("corrent app %@---->", CurrentAppointment);
        vc.serviceName = CurrentAppointment
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
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
        
        let checkInButton = UIButton()
        checkInButton.setTitle("Check in", for: .normal)
        checkInButton.setTitleColor(.white, for: .normal)
        checkInButton.backgroundColor = UIColor(hexString: Colors.buttonColor)
        checkInButton.titleLabel?.font =  UIFont.systemFont(ofSize: 14, weight: .bold)
        checkInButton.addTarget(self, action: #selector(checkInAppointmentAction), for: .touchUpInside)
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
        CurrentAppointment = dummyAppointments[appointmentIndex].serviceName ?? ""
        createCheckIn(appointmentName: dummyAppointments[appointmentIndex].serviceName ?? "")
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
    
}
protocol CheckInDelegate{
    func appointmentCheckIn(appointmentIndex:Int)
    func appointmentIndoorMap(appointmentIndex:Int)
    func appointmentPreCheckIn(appointmentIndex:Int)
    func appointmentArrived(appointmentIndex:Int)
    func appointmentParking(appointmentIndex:Int)
}
