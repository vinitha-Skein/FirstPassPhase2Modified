//
//  MyAppointmentsViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 19/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class MyAppointmentsViewController: UIViewController {
    
    @IBOutlet var bgView: UIView!
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var activeAppointments: UIButton!
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var tableview: UITableView!
    
    
    let viewModel = MyAppointmentsViewModel()
    var userId = Int()
    var appointmentArray = ["Orthopedic replacement","Medicine collections","Orthopedic replacement"]
    var isActiveAppointment = Bool()
    var dummyAppointments = [ActiveAppointmentData]()
    var blurView = UIView()
    var checkInView = UIView()
    var buttonBG = UIColor(red: 53/255, green: 35/255, blue: 100/255, alpha: 1)
    var unselectedText = UIColor(red: 74/255, green: 79/255, blue: 87/255, alpha: 1)
    let service = ["Cardiology","Internal Medicine","Laboratory"]
    var precheckin = [Int]()
    var appointments = [ActiveAppointmentData]()
    var historyAppointments = [ActiveAppointmentData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableview.register(UINib(nibName: "AppointmentTableViewCell", bundle: .main), forCellReuseIdentifier: "AppointmentTableViewCell")
        tableview.dataSource = self
        tableview.delegate = self
        isActiveAppointment = true
        // Do any additional setup after loading the view.
       // fetchAllAppointments()
        
        
        //For demo purpose
//        let appointment1 = ActiveAppointmentData(pId: 0, mrnNo: "", patientName: "Patient 1", doctorName: "Doctor 1", departmentName: "Cardiology", serviceName: "Cardiology", appointmentTime: "2021-01-06 15:00:00", serviceBookedId: 0, status: "")
//        let appointment2 = ActiveAppointmentData(pId: 0, mrnNo: "", patientName: "Patient 1", doctorName: "Doctor 1", departmentName: "Internal Medicine", serviceName: "Internal Medicine", appointmentTime: "2021-01-06 16:00:00", serviceBookedId: 0, status: "")
//        let appointment3 = ActiveAppointmentData(pId: 0, mrnNo: "", patientName: "Patient 1", doctorName: "Doctor 1", departmentName: "Laboratory", serviceName: "Laboratory", appointmentTime: "2021-01-06 16:30:00", serviceBookedId: 0, status: "")
        
        
        let appoint1 = ActiveAppointmentData(doctor_name: "John", appt_status: "Not completed", trans_id: "123", appointment_time: "2021-01-06 16:00:00", patient_name: "Hari", service: "Cardiology", department: "Cardiology", token_no: "5", token_status: "Not called", room: "2rd Floor")
        let appoint2 = ActiveAppointmentData(doctor_name: "Ram", appt_status: "Not completed", trans_id: "123", appointment_time: "2021-01-06 16:00:00", patient_name: "Hari", service: "Radiology", department: "Oncology", token_no: "5", token_status: "Not called", room: "2rd Floor")
        let appoint3 = ActiveAppointmentData(doctor_name: "Harish", appt_status: "Not completed", trans_id: "123", appointment_time: "2021-01-06 16:00:00", patient_name: "Hari", service: "Pharmacy", department: "ENT", token_no: "5", token_status: "Not called", room: "3rd Floor")
        dummyAppointments = [appoint1,appoint2,appoint3]
        var data = dummyAppointments
        appointments = dummyAppointments;
        
    }
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "vip")
        {
            vipview()
        }
    }
    
    
    
    func vipview()
    {
        bgView.backgroundColor = UIColor.black
        container.backgroundColor = UIColor(hex: "#222629")
        titleLabel.textColor = UIColor.white
        bookButton.backgroundColor = UIColor(named: "vip")
        bookButton.setTitleColor(UIColor(hex: "#503E00"), for: .normal)
        backButton.setImage(UIImage(named: "vipback"), for: .normal)
        
        historyButton.backgroundColor = .clear
        activeAppointments.backgroundColor = UIColor(named: "vip")
        activeAppointments.setTitleColor(UIColor(hex: "#503E00"), for: .normal)
        historyButton.setTitleColor(UIColor(hex: "#F2F2F2"), for: .normal)
    }
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func activeAppointmentAction(_ sender: Any) {
        
        if UserDefaults.standard.bool(forKey: "vip")
        {
            historyButton.backgroundColor = .clear
            activeAppointments.backgroundColor = UIColor(named: "vip")
            activeAppointments.setTitleColor(UIColor(hex: "#503E00"), for: .normal)
            historyButton.setTitleColor(UIColor(hex: "#F2F2F2"), for: .normal)
            isActiveAppointment = true
          //  fetchActiveAppointments()
            self.tableview.reloadData()
        }
        else
        {
            activeAppointments.createBorderForButton(cornerRadius: 4, borderWidth: 1, borderColor: .lightGray)
            historyButton.createBorderForButton(cornerRadius: 4, borderWidth: 0, borderColor: .clear)
            historyButton.backgroundColor = .clear
            activeAppointments.backgroundColor = buttonBG
            activeAppointments.setTitleColor(.white, for: .normal)
            historyButton.setTitleColor(unselectedText, for: .normal)
            isActiveAppointment = true
            historyButton.createBorderForButton(cornerRadius: 4, borderWidth: 0, borderColor: .clear)
          //  fetchActiveAppointments()
            setActiveData();
            print("assigning data act");
            self.tableview.reloadData()
        }
        
        
    }
    @IBAction func historyAction(_ sender: Any) {
       
        
        if UserDefaults.standard.bool(forKey: "vip")
        {
            
            activeAppointments.backgroundColor = .clear
            historyButton.backgroundColor = UIColor(named: "vip")
            historyButton.setTitleColor(UIColor(hex: "#503E00"), for: .normal)
            activeAppointments.setTitleColor(UIColor(hex: "#F2F2F2"), for: .normal)
            isActiveAppointment = false
            activeAppointments.createBorderForButton(cornerRadius: 4, borderWidth: 0, borderColor: .clear)
        //    fetchAllAppointments()
            self.tableview.reloadData()
        }
        else
        {
            historyButton.createBorderForButton(cornerRadius: 4, borderWidth: 1, borderColor: .lightGray)
            activeAppointments.createBorderForButton(cornerRadius: 4, borderWidth: 0, borderColor: .clear)
            activeAppointments.backgroundColor = .clear
            historyButton.backgroundColor = buttonBG
            historyButton.setTitleColor(.white, for: .normal)
            activeAppointments.setTitleColor(unselectedText, for: .normal)
            isActiveAppointment = false
            
            setHistoryData()
            print("assigning data hst");
        //    fetchAllAppointments()
            self.tableview.reloadData()
        }
    }
    
    func setHistoryData()
    {
        let appoint1 = ActiveAppointmentData(doctor_name: "John", appt_status: "Not completed", trans_id: "123", appointment_time: "2021-01-06 16:00:00", patient_name: "Hari", service: "Cardiology", department: "Cardiology", token_no: "5", token_status: "Not called", room: "2rd Floor")
        dummyAppointments = [appoint1]
        var data = dummyAppointments
        historyAppointments = dummyAppointments;
    }
    func setActiveData()
    {
        let appoint1 = ActiveAppointmentData(doctor_name: "John", appt_status: "Not completed", trans_id: "123", appointment_time: "2021-01-06 16:00:00", patient_name: "Hari", service: "Cardiology", department: "Cardiology", token_no: "5", token_status: "Not called", room: "2rd Floor")
        let appoint2 = ActiveAppointmentData(doctor_name: "Ram", appt_status: "Not completed", trans_id: "123", appointment_time: "2021-01-06 16:00:00", patient_name: "Hari", service: "Radiology", department: "Oncology", token_no: "5", token_status: "Not called", room: "2rd Floor")
        let appoint3 = ActiveAppointmentData(doctor_name: "Harish", appt_status: "Not completed", trans_id: "123", appointment_time: "2021-01-06 16:00:00", patient_name: "Hari", service: "Pharmacy", department: "ENT", token_no: "5", token_status: "Not called", room: "3rd Floor")
        dummyAppointments = [appoint1,appoint2,appoint3]
        var data = dummyAppointments
        appointments = dummyAppointments;
    }
    @IBAction func bookAppointmentAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Modified", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "BookAppointmentViewController") as! BookAppointmentViewController
        vc.modalPresentationStyle = .fullScreen
        //vc.isNeedBackButton = true
        view.window!.layer.add(rightToLeftTransition(), forKey: kCATransition)
        present(vc, animated: true)
    }
    
    func setupUI(){
        activeAppointments.createBorderForButton(cornerRadius: 4, borderWidth: 1, borderColor: .lightGray)
        historyButton.createBorderForButton(cornerRadius: 4, borderWidth: 0, borderColor: .clear)
        historyButton.backgroundColor = .clear
        activeAppointments.backgroundColor = buttonBG
        activeAppointments.setTitleColor(.white, for: .normal)
        historyButton.setTitleColor(unselectedText, for: .normal)
        container.layer.cornerRadius = 20
        isActiveAppointment = true
        self.tableview.reloadData()
    }
    func fetchActiveAppointments(){
        self.activityIndicator(self.view, startAnimate: true)
        viewModel.fetchUpcomingAppointments(userId: userId)
        
        viewModel.fetchActiveSuccess = {
            self.tableview.reloadData()
        }
        
        viewModel.loadingStatus = {
            if self.viewModel.isLoading{
                self.activityIndicator(self.view, startAnimate: true)
            }else{
                self.activityIndicator(self.view, startAnimate: false)
                UIApplication.shared.endIgnoringInteractionEvents()
            }
        }
        
        viewModel.errorMessageAlert = {
            self.showAlert(self.viewModel.errorMessage ?? "Error")
        }
    }
    
    func fetchAllAppointments(){
        self.activityIndicator(self.view, startAnimate: true)
         viewModel.fetchAllAppointments()
        viewModel.fetchAllSuccess = { [self] in
            self.appointments = (self.viewModel.allAppointments?.appointments)!
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
                self.tableview.reloadData()
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
                    self.tableview.reloadData()
                }
            }
        }
    }
}

extension MyAppointmentsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isActiveAppointment{
            return self.appointments.count
        }else{
            return self.historyAppointments.count
        }
//        return dummyAppointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentTableViewCell", for: indexPath) as! AppointmentTableViewCell
        cell.delegate = self
        cell.updateBackgroundColorUI(indexPath: indexPath)
        cell.container.layer.cornerRadius = 10
        if UserDefaults.standard.bool(forKey: "vip")
        {
            cell.container.backgroundColor = UIColor(hex: "#34383B")
            cell.appointmentName.textColor = UIColor.white
            cell.time.textColor = UIColor(named: "vip")
            cell.date.textColor = UIColor(named: "vip")
            cell.doctorName.textColor = UIColor(named: "vip")
            cell.precheckinButton.setTitleColor(UIColor(named: "vip"), for: .normal)
            cell.checkinButton.setTitleColor(UIColor(named: "vip"), for: .normal)
        }
        else
        {
            cell.container.backgroundColor = UIColor(hex: "#F8F8F9")
            cell.appointmentName.textColor = UIColor(hex: "#352364")
            cell.time.textColor = UIColor(hex: "#72767C")
            cell.date.textColor = UIColor(hex: "#72767C")
            cell.doctorName.textColor = UIColor(hex: "#72767C")
            cell.precheckinButton.setTitleColor(UIColor(hex: "#2F74E2"), for: .normal)
            cell.checkinButton.setTitleColor(UIColor(hex: "#2F74E2"), for: .normal)
        }
        
        
        
        
        if isActiveAppointment
        {
//            cell.updateAppointmentDataToUI(data: (viewModel.activeAppointments?.appointmentDetails?[indexPath.row])!, indexpath: indexPath)
//        cell.updateAppointmentDataToUI(data: (dummyAppointments[indexPath.row]), indexpath: indexPath)
           let currentAppointment = self.appointments[indexPath.row]
            cell.waitLabel.isHidden = true
            cell.waiTimeLabel.isHidden = true
            cell.indoorButton.isHidden = false
            cell.indoorButtonPressed =
                {
//                    let storyboard = UIStoryboard(name: "Modified", bundle: .main)
//                    let vc = storyboard.instantiateViewController(withIdentifier: "IndoorMapViewController") as! IndoorMapViewController
//                    vc.modalPresentationStyle = .fullScreen
//                    self.present(vc, animated: true)
                }
            cell.appointmentName.text = self.appointments[indexPath.row].department
            let dateString = currentAppointment.appointment_time!
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM  d yyyy h:mm:ss:SSSa"
            if let date = formatter.date(from: dateString) {
                formatter.dateFormat = "dd-MM-yyyy"
                let string = formatter.string(from: date)
                print(string)
                cell.date.text = string
                formatter.dateFormat = "h:mm a"
                let stringTime = formatter.string(from: date)
                cell.time.text = stringTime
            }
            cell.doctorName.text = currentAppointment.doctor_name
            if currentAppointment.appt_status == "SCHEDULED" {
                cell.precheckinButton.isHidden = false
                cell.checkinButton.isHidden = false
            } else {
                cell.precheckinButton.isHidden = true
                cell.checkinButton.isHidden = false
                cell.checkinButton.setTitle("Ongoing", for: .normal)
            }
        }else
        {
            //cell.checkinButton.isHidden = true
//            cell.updateAppointmentDataToUI(data: (viewModel.allAppointments?.appointmentDetails?[indexPath.row])!, indexpath: indexPath)
//        cell.updateAppointmentDataToUI(data: (dummyAppointments[indexPath.row]), indexpath: indexPath)
            let currentAppointment = self.historyAppointments[indexPath.row]
            cell.waitLabel.isHidden = true
            cell.waiTimeLabel.isHidden = true
            cell.precheckinButton.isHidden = true
            cell.checkinButton.isHidden = true
            cell.indoorButton.isHidden = true
            cell.appointmentName.text = currentAppointment.department
            let dateString = currentAppointment.appointment_time!
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM  d yyyy h:mm:ss:SSSa"
            if let date = formatter.date(from: dateString) {
                formatter.dateFormat = "dd-MM-yyyy"
                let string = formatter.string(from: date)
                print(string)
                cell.date.text = string
                formatter.dateFormat = "h:mm a"
                let stringTime = formatter.string(from: date)
                cell.time.text = stringTime
            }
            cell.doctorName.text = currentAppointment.doctor_name
        }
        cell.preCheckinButtonPressed =
            {
                let storyboard = UIStoryboard(name: "Modified", bundle: .main)
                let vc = storyboard.instantiateViewController(withIdentifier: "PreChekinPopup") as! PreChekinPopup
                vc.modalPresentationStyle = .overCurrentContext
                self.present(vc, animated: true)
                
                self.precheckin.append(indexPath.row)
                self.tableview.reloadData()
            }
        
        if precheckin.contains(indexPath.row)
        {
            cell.precheckinButton.isHidden = true
            cell.checkinHorizontalLayout.constant = 0
            cell.waitLabel.isHidden = false
            cell.waiTimeLabel.isHidden = false
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isActiveAppointment
        {
            return 180
        }
        else
        {
        return 140
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if isActiveAppointment
        {
        let storyboard = UIStoryboard(name: "phase2", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "NewTokenViewController") as! NewTokenViewController
        vc.modalPresentationStyle = .fullScreen
            vc.appointment = self.appointments[indexPath.row]
        view.window!.layer.add(rightToLeftTransition(), forKey: kCATransition)
        present(vc, animated: true)
        }
        else
        {
            let storyboard = UIStoryboard(name: "phase2", bundle: .main)
            let vc = storyboard.instantiateViewController(withIdentifier: "AppointmentHistoryViewController") as! AppointmentHistoryViewController
            vc.modalPresentationStyle = .fullScreen
            vc.headtext = service[indexPath.row]
            vc.appointment = self.historyAppointments[indexPath.row]
            view.window!.layer.add(rightToLeftTransition(), forKey: kCATransition)
            present(vc, animated: true)
        }
    }
    
    
}


extension MyAppointmentsViewController:CheckInDelegate{
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
//        let storyboard = UIStoryboard(name: "Modified", bundle: .main)
//        let vc = storyboard.instantiateViewController(withIdentifier: "PreChekinPopup") as! PreChekinPopup
//        vc.modalPresentationStyle = .overCurrentContext
//        present(vc, animated: true)
    }
    
    func appointmentCheckIn(appointmentIndex: Int) {
        //createBlurView()
//        createCheckIn(appointmentName: viewModel.appointmentData?.appointmentDetails?[appointmentIndex].serviceName ?? "")
        NSLog("Tag------->%d", appointmentIndex)
        //createCheckIn(appointmentName: dummyAppointments[appointmentIndex].serviceName ?? "")
        let storyboard = UIStoryboard(name: "phase2", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "AppointmentDetailsViewController") as! AppointmentDetailsViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func appointmentIndoorMap(appointmentIndex: Int)
    {
//        let storyboard = UIStoryboard(name: "Modified", bundle: .main)
//        let vc = storyboard.instantiateViewController(withIdentifier: "IndoorMapViewController") //as! IndoorMapViewController
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: true)
    }
}


extension MyAppointmentsViewController{
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
