//
//  BookAppointmentViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 19/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class BookAppointmentViewController: UIViewController {
    @IBOutlet var mainContainer: UIView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var myselfButton: UIButton!
    @IBOutlet weak var familyMemberButton: UIButton!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var locationTextfield: UITextField!
    @IBOutlet weak var departmentTextfield: UITextField!
    @IBOutlet weak var serviceTextfield: UITextField!
    @IBOutlet weak var doctorLabTextfield: UITextField!
    @IBOutlet weak var dateTextfield: UITextField!
    @IBOutlet weak var timeTextfield: UITextField!
    @IBOutlet weak var bookButton: UIButton!
  
    @IBOutlet weak var memberView: UIView!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var departmentView: UIView!
    @IBOutlet weak var serviceView: UIView!
    @IBOutlet weak var doctorView: UIView!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var deptView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedField:PopUpFor?
    let viewModel = AddAppointmentViewModel()
    var selectedTextfield = UITextField()
    var locationId = Int()
    var departmentId = Int()
    var serviceId = Int()
    var doctorId = Int()
    var memberPId = Int()
    var dataSource = [String]()
    var isNeedBackButton = false
    let buttontextColor = UIColor(red: 74/255, green: 79/255, blue: 87/255, alpha: 1)
    var timeList = ["9:30 AM","10:30 AM","11:00 AM","12:00 PM","3:00 PM","4:00 PM"]
//    var locationList = ["Riyadh","Dubai Health Street"]
//    var familyMember = ["Father","Mother","Brother","Sister","Wife","Son","Daughter"]
//    var services1 = ["Cardiac Arrhythmia","Electrophysiology","Heart Transplant","Interventional Cardiology","Pacemaker"]
//    var services2 = ["Adolescents","Diabetes nephrology","Insulin pumpt","Pituitary","Thyroid & Surgical"]
//    var services3 = ["Bladder Cancer","Pancreatic Cancer","Pituitary Tumours","Prostate Cancer"]
//    var departments = ["Cardiology","Endocrinology","Oncology"]
    
    var location = [LocationData]()
    var department = [BranchData]()
    var services1 = [ServiceData]()
    var services2 = [ServiceData]()
    var services3 = [ServiceData]()
    var doctors = [DoctorData]()
    var familyMemberData = [FamilyMembersList]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
        myselfButton.backgroundColor = UIColor(hexString: "#352364")
        myselfButton.setTitleColor(.white, for: .normal)
        familyMemberButton.backgroundColor = UIColor(hexString: "#E1E3E6")
        familyMemberButton.setTitleColor(buttontextColor, for: .normal)
        memberView.isHidden = true
        collectionView.register(UINib(nibName: "FamilyCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "FamilyCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
//        if isNeedBackButton{
//            backButton.isHidden = false
//        }else{
//            backButton.isHidden = true
//        }
        
        
        //dummy data
        let loc1 = LocationData(locationAddress: "", locationId: 0, locationIdentfier: "", locationNameAr: "", locationNameEn: "Riyadh")
        let loc2 = LocationData(locationAddress: "", locationId: 0, locationIdentfier: "", locationNameAr: "", locationNameEn: "Dubai Health Street")
        location = [loc1,loc2]
        
        let dep1 = BranchData(branchId: 0, branchNameAr: "", branchNameEn: "Cardiology", branchType: nil)
        let dep2 = BranchData(branchId: 0, branchNameAr: "", branchNameEn: "Endocrinology", branchType: nil)
        let dep3 = BranchData(branchId: 0, branchNameAr: "", branchNameEn: "Oncology", branchType: nil)
        
        department = [dep1,dep2,dep3]
        
        let ser11 = ServiceData(branchId: 0, serviceId: 0, serviceNameAr: "", serviceNameEn: "Cardiac Arrhythmia")
        let ser12 = ServiceData(branchId: 0, serviceId: 0, serviceNameAr: "", serviceNameEn: "Electrophysiology")
        let ser13 = ServiceData(branchId: 0, serviceId: 0, serviceNameAr: "", serviceNameEn: "Heart Transplant")
        let ser14 = ServiceData(branchId: 0, serviceId: 0, serviceNameAr: "", serviceNameEn: "Interventional Cardiology")
        let ser15 = ServiceData(branchId: 0, serviceId: 0, serviceNameAr: "", serviceNameEn: "Pacemaker")
        
        services1 = [ser11,ser12,ser13,ser14,ser15]
        

        let ser21 = ServiceData(branchId: 0, serviceId: 0, serviceNameAr: "", serviceNameEn: "Adolescents")
        let ser22 = ServiceData(branchId: 0, serviceId: 0, serviceNameAr: "", serviceNameEn: "Diabetes nephrology")
        let ser23 = ServiceData(branchId: 0, serviceId: 0, serviceNameAr: "", serviceNameEn: "Insulin pumpt")
        let ser24 = ServiceData(branchId: 0, serviceId: 0, serviceNameAr: "", serviceNameEn: "Pituitary")
        let ser25 = ServiceData(branchId: 0, serviceId: 0, serviceNameAr: "", serviceNameEn: "Thyroid & Surgical")
        
        services2 = [ser21,ser22,ser23,ser24,ser25]
        
        
        let ser31 = ServiceData(branchId: 0, serviceId: 0, serviceNameAr: "", serviceNameEn: "Bladder Cancer")
        let ser32 = ServiceData(branchId: 0, serviceId: 0, serviceNameAr: "", serviceNameEn: "Pancreatic Cancer")
        let ser33 = ServiceData(branchId: 0, serviceId: 0, serviceNameAr: "", serviceNameEn: "Pituitary Tumours")
        let ser34 = ServiceData(branchId: 0, serviceId: 0, serviceNameAr: "", serviceNameEn: "Prostate Cancer")
        
        services3 = [ser31,ser32,ser33,ser34]
        
        let doc1 = DoctorData(drId: 0, isActive: 0, doctorName: "Dr.Albert", userName: "")
        let doc2 = DoctorData(drId: 0, isActive: 0, doctorName: "Dr.Mitchell", userName: "")

        doctors = [doc1,doc2]
        

//        let member1 = FamilyMembersList(name: "Mr. Johnsmith", dob: "18-08-1956", memberId: 0, pId: 0, releation: "Husband", title: "Mrs", nationalId: "", id_proof: "", paymentmethod: "", insurancename: "", insuranceno: "", insurancevalidity: "", insurancecardimage: "", mrnNo: "998878563", profile_pic: "")
//        let member2 = FamilyMembersList(name: "Mr. Johnathan", dob: "07-11-1985", memberId: 0, pId: 0, releation: "Son", title: "Mr", nationalId: "", id_proof: "", paymentmethod: "", insurancename: "", insuranceno: "", insurancevalidity: "", insurancecardimage: "", mrnNo: "678878563", profile_pic: "")
        let member1 = FamilyMembersList(full_name: "Johnsmith", relation: "Husband", dob: "18-08-1956", mrn: "99884556", national_id: "5566225", id: "1")
        let member2 = FamilyMembersList(full_name: "Johnathan", relation: "wife", dob: "18-04-1946", mrn: "99884556", national_id: "5566225", id: "1")
        familyMemberData = [member1,member2]
        //        let ser1 = ServiceData(branchId: 0, serviceId: 0, serviceNameAr: 0, serviceNameEn: "")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getUserDetails()
    }
    
    @IBAction func backAction(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Main", bundle: .main)
//        let vc = storyboard.instantiateViewController(withIdentifier: "MyAppointmentsViewController") as! MyAppointmentsViewController
//        vc.modalPresentationStyle = .fullScreen
//        view.window!.layer.add(leftToRightTransition(), forKey: kCATransition)
//        //        present(vc, animated: true)
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func mySelfAction(_ sender: Any) {
        memberView.isHidden = true
        myselfButton.backgroundColor = UIColor(hexString: "#352364")
        familyMemberButton.backgroundColor = UIColor(hexString: "#E1E3E6")
        familyMemberButton.backgroundColor = UIColor(hexString: "#E1E3E6")
        myselfButton.setTitleColor(.white, for: .normal)
        familyMemberButton.setTitleColor(buttontextColor, for: .normal)
        
    }
    @IBAction func famlyMemberAction(_ sender: Any) {
        memberView.isHidden = false
        myselfButton.backgroundColor = UIColor(hexString: "#E1E3E6")
        familyMemberButton.backgroundColor = UIColor(hexString: "#352364")
        familyMemberButton.setTitleColor(.white, for: .normal)
        myselfButton.setTitleColor(buttontextColor, for: .normal)
    }
    @IBAction func clearAction(_ sender: Any) {
        locationTextfield.text = ""
        departmentTextfield.text = ""
        serviceTextfield.text = ""
        doctorLabTextfield.text = ""
        dateTextfield.text = ""
        timeTextfield.text = ""
    }
    @IBAction func bookAppointments(_ sender: Any) {
        guard let location = locationTextfield.text,let department = departmentTextfield.text,let service = serviceTextfield.text,let doctor = doctorLabTextfield.text,let date = dateTextfield.text, let time = timeTextfield.text else {
            return
        }
        
//        if !memberView.isHidden{
//            if member == ""{
//                self.showAlert("Please Select family member")
//                return
//            }
//        }
        if location == ""{
            self.showAlert("Please select location")
            return
        }
        if department == ""{
            self.showAlert("Please select department")
            return
        }
        if service == ""{
            self.showAlert("Please select service")
            return
        }
        if doctor == ""{
            self.showAlert("Please select doctor")
            return
        }
        if date == ""{
            self.showAlert("Please select appointment date")
            return
        }
        if time == ""{
            self.showAlert("Please select appointment time")
            return
        }
        let converetedTime = self.getAppointmentTime(date: time, format: "h:mm a", requiredFormat: "HH:mm:ss")
        let appointmentTime = date + " " + converetedTime
        
        var params = [
            "appointmentTime": converetedTime,
            "branchId": departmentId,
            "date": date,
            "doctorId": doctorId,
            "locationId": locationId,
            "serviceId": serviceId,
            "tokenid": "CD001"
            ] as [String : Any]
        if memberView.isHidden{
            params["appointfor"] = viewModel.userName
            params["pId"] = viewModel.userPId
        }else
        {
            params["appointfor"] = ""
            params["pId"] = memberPId
        }
        let storyboard = UIStoryboard(name: "Modified", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "AppointmentBookedViewController") as! AppointmentBookedViewController
        vc.appointmentData = CreatedAppointmentData(pId: 0, messages: "", mrnNo: "347834455", patientName: "Natasha", doctorName: doctor, departmentName: department, serviceName: "Cardiology", appointmentTime: time, serviceBookedId: 0, status: "", message: "", error: "",date:date)
        
//        let appointment = ActiveAppointmentData(doctor_name: doctor, appt_status: "SCHEDULED", trans_id: "23409876510", appointment_time: appointmentTime, patient_name: "John", service: serviceTextfield.text, department: departmentTextfield.text, token_no: "", token_status: "", room: "")
//        UserDefaults.standard.setValue(appointment, forKey: "Dummy Appointments")
//
        
        vc.modalPresentationStyle = .fullScreen
       
        self.present(vc, animated: true)

        bookAppointment(params: params)
    }
    
    func bookAppointment(params:[String:Any])
    {
//        self.activityIndicator(self.view, startAnimate: true)
//        viewModel.createAppointment(params: params)
//
//        viewModel.appointmentAddSuccess =
//            {
//            let storyboard = UIStoryboard(name: "Modified", bundle: .main)
//            let vc = storyboard.instantiateViewController(withIdentifier: "AppointmentBookedViewController") as! AppointmentBookedViewController
//            vc.appointmentData = self.viewModel.createdAppointmentData
//            vc.modalPresentationStyle = .fullScreen
//            //            self.view.window!.layer.add(self.leftToRightTransition(), forKey: kCATransition)
//            self.present(vc, animated: true)
//        }
//
//        viewModel.loadingStatus = {
//            if self.viewModel.isLoading{
//                self.activityIndicator(self.view, startAnimate: true)
//            }else{
//                self.activityIndicator(self.view, startAnimate: false)
//                UIApplication.shared.endIgnoringInteractionEvents()
//            }
//        }
//
//        viewModel.errorMessageAlert = {
//            self.showAlert(self.viewModel.errorMessage ?? "Error")
//        }
        
    }
    
    func fetchLocations(){
        //        self.activityIndicator(self.view, startAnimate: true)
        //        viewModel.getAllLocation()
        
        viewModel.locationFetchSuccess = {
            self.selectedField = PopUpFor.Location
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let popup = storyboard.instantiateViewController(withIdentifier: "SelectPopupViewController") as! SelectPopupViewController
            popup.modalPresentationStyle = .overCurrentContext
            popup.popUpFor = PopUpFor.Location
            popup.dataCount = self.viewModel.locationData?.locations?.count ?? 0
            popup.locations = self.viewModel.locationData?.locations ?? []
            popup.delegate = self
            self.present(popup, animated: true, completion: nil)
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
        
        //dummy data
        
        self.selectedField = PopUpFor.Location
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let popup = storyboard.instantiateViewController(withIdentifier: "SelectPopupViewController") as! SelectPopupViewController
        popup.modalPresentationStyle = .overCurrentContext
        popup.popUpFor = PopUpFor.Location
        popup.dataCount = self.location.count
        popup.locations = self.location
        popup.delegate = self
        self.present(popup, animated: true, completion: nil)
    }
    
    func fetchDepartments(){
        //        self.activityIndicator(self.view, startAnimate: true)
        //        viewModel.getAllBranches(locationID: locationId)
        
        viewModel.branchFetchSuccess = {
            self.selectedField = PopUpFor.Department
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let popup = storyboard.instantiateViewController(withIdentifier: "SelectPopupViewController") as! SelectPopupViewController
            popup.modalPresentationStyle = .overCurrentContext
            popup.popUpFor = PopUpFor.Department
            //            popup.dataCount = self.viewModel.branchData?.locations?.count ?? 0
            //            popup.departments = self.viewModel.branchData?.locations ?? []
            
            //Dummy
            popup.dataCount = self.department.count
            popup.departments = self.department
            popup.delegate = self
            self.present(popup, animated: true, completion: nil)
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
        
        //dummy data
        
        self.selectedField = PopUpFor.Department
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let popup = storyboard.instantiateViewController(withIdentifier: "SelectPopupViewController") as! SelectPopupViewController
        popup.modalPresentationStyle = .overCurrentContext
        popup.popUpFor = PopUpFor.Department
        popup.dataCount = self.department.count
        popup.departments = self.department
        popup.delegate = self
        self.present(popup, animated: true, completion: nil)
    }
    
    func fetchServices(){
//        self.activityIndicator(self.view, startAnimate: true)
//        viewModel.getAllServices(branchID: departmentId)
        //        viewModel.getAllServices(branchID: departmentId)
        
        viewModel.serviceFetchSuccess = {
            self.selectedField = PopUpFor.Service
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let popup = storyboard.instantiateViewController(withIdentifier: "SelectPopupViewController") as! SelectPopupViewController
            popup.modalPresentationStyle = .overCurrentContext
            popup.popUpFor = PopUpFor.Service
            popup.dataCount = self.viewModel.serviceData?.services?.count ?? 0
            popup.services = self.viewModel.serviceData?.services ?? []
            popup.delegate = self
            self.present(popup, animated: true, completion: nil)
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
        
        //dummy
        
        self.selectedField = PopUpFor.Service
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let popup = storyboard.instantiateViewController(withIdentifier: "SelectPopupViewController") as! SelectPopupViewController
        popup.modalPresentationStyle = .overCurrentContext
        popup.popUpFor = PopUpFor.Service
        
        switch departmentTextfield.text {
        case "Cardiology":
            popup.dataCount = self.services1.count
            popup.services = self.services1
        case "Endocrinology":
            popup.dataCount = self.services2.count
            popup.services = self.services2
        case "Oncology":
            popup.dataCount = self.services3.count
            popup.services = self.services3
        default:
            break
        }
        popup.delegate = self
        self.present(popup, animated: true, completion: nil)
    }
    
    
    func fetchDoctors(){
//        self.activityIndicator(self.view, startAnimate: true)
//        viewModel.getAllDoctors(userId:viewModel.userId ?? 0, locationID: locationId, serviceID: serviceId)
        
        viewModel.doctorFetchSuccess = {
            if self.viewModel.doctorData?.doctors?.count != 0{
                self.selectedField = PopUpFor.Doctor
                let storyboard = UIStoryboard(name: "Main", bundle: .main)
                let popup = storyboard.instantiateViewController(withIdentifier: "SelectPopupViewController") as! SelectPopupViewController
                popup.modalPresentationStyle = .overCurrentContext
                popup.popUpFor = PopUpFor.Doctor
                popup.dataCount = self.viewModel.doctorData?.doctors?.count ?? 0
                popup.doctors = self.viewModel.doctorData?.doctors ?? []
                popup.delegate = self
                self.present(popup, animated: true, completion: nil)
            }else{
                self.showAlert("No Doctors available")
            }
        }
        
        viewModel.loadingStatus = {
            if self.viewModel.isLoading{
                self.activityIndicator(self.view, startAnimate: true)
            }else{
                self.activityIndicator(self.view, startAnimate: false)
                UIApplication.shared.endIgnoringInteractionEvents()
            }
        }
        
        viewModel.errorMessageAlert =
            {
            self.showAlert(self.viewModel.errorMessage ?? "Error")
        }
        
        
        //dummy data
        self.selectedField = PopUpFor.Doctor
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let popup = storyboard.instantiateViewController(withIdentifier: "SelectPopupViewController") as! SelectPopupViewController
        popup.modalPresentationStyle = .overCurrentContext
        popup.popUpFor = PopUpFor.Doctor
        popup.dataCount = doctors.count
        popup.doctors = doctors
        popup.delegate = self
        self.present(popup, animated: true, completion: nil)
    }
    
    func fetchFamilyMembers()
    {
      //  self.activityIndicator(self.view, startAnimate: true)
     //   viewModel.fetchFamilyMember(userId: viewModel.userId ?? 0)
        
        viewModel.memberFetchSuccess =
            {
            if self.viewModel.doctorData?.doctors?.count != 0
            {
                self.selectedField = PopUpFor.FamilyMember
                let storyboard = UIStoryboard(name: "Main", bundle: .main)
                let popup = storyboard.instantiateViewController(withIdentifier: "SelectPopupViewController") as! SelectPopupViewController
                popup.modalPresentationStyle = .overCurrentContext
                popup.popUpFor = PopUpFor.FamilyMember
                popup.dataCount = self.viewModel.familyMemberData?.count ?? 0
                popup.familyMembers = self.viewModel.familyMemberData ?? []
                popup.delegate = self
                self.present(popup, animated: true, completion: nil)
            }else{
                self.showAlert("No Doctors available")
            }
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
        
        
        self.selectedField = PopUpFor.FamilyMember
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let popup = storyboard.instantiateViewController(withIdentifier: "SelectPopupViewController") as! SelectPopupViewController
        popup.modalPresentationStyle = .overCurrentContext
        popup.popUpFor = PopUpFor.FamilyMember
        popup.dataCount = familyMemberData.count
        popup.familyMembers = familyMemberData
        popup.delegate = self
        self.present(popup, animated: true, completion: nil)
    }
    
    
    
    func setupUI(){
        container.createBorderForView(cornerRadius: 30, borderWidth: 0, borderColor: .clear)
        scrollView.layer.cornerRadius = 30
        mainContainer.layer.cornerRadius = 30
        container.clipsToBounds = true
        container.layer.borderWidth = 0.4
        container.layer.borderColor = UIColor.gray.cgColor
        container.layer.masksToBounds = false
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        container.layer.shadowOpacity = 0.2
        //memberTextfield.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        locationTextfield.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        departmentTextfield.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        serviceTextfield.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        doctorLabTextfield.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        dateTextfield.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        timeTextfield.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        bookButton.createBorderForButton(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
//        clearButton.createBorderForButton(cornerRadius: 8, borderWidth: 0.5, borderColor: .black)
        familyMemberButton.createBorderForButton(cornerRadius: 4, borderWidth: 0, borderColor: .clear)
        myselfButton.createBorderForButton(cornerRadius: 4, borderWidth: 0, borderColor: .black)
        //clearButton.backgroundColor = .clear
        
       // memberTextfield.addRightView(imageName: "rightView")
        locationTextfield.addRightView(imageName: "dropdown")
        departmentTextfield.addRightView(imageName: "dropdown")
        serviceTextfield.addRightView(imageName: "dropdown")
        
        doctorLabTextfield.addRightView(imageName: "dropdown")
        dateTextfield.addRightView(imageName: "calendar")
        timeTextfield.addRightView(imageName: "TimeSquare")
        //memberTextfield.setPlaceholder(placeholderText: "Select member")
        locationTextfield.setPlaceholder(placeholderText: "Select location")
        departmentTextfield.setPlaceholder(placeholderText: "Select department")
        serviceTextfield.setPlaceholder(placeholderText: "Select service")
        doctorLabTextfield.setPlaceholder(placeholderText: "Select details")
        dateTextfield.setPlaceholder(placeholderText: "Select date")
        timeTextfield.setPlaceholder(placeholderText: "Select time")
        
        //memberTextfield.delegate = self
        locationTextfield.delegate = self
        departmentTextfield.delegate = self
        serviceTextfield.delegate = self
        doctorLabTextfield.delegate = self
        dateTextfield.delegate = self
        timeTextfield.delegate = self
    }
    
}

extension BookAppointmentViewController:UITextFieldDelegate,DatePickerDelegate,SelectPopupDelegate,AddMemberFromAppointmentScreenDelegate{
    func appointmentAdded() {
        fetchFamilyMembers()
    }
    
    func addNewMember() {
        self.dismiss(animated: true, completion: nil)
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let popup = storyboard.instantiateViewController(withIdentifier: "AddNewMemberViewController") as! AddNewMemberViewController
        popup.delegate = self
        present(popup, animated: true, completion: nil)
        
    }
    
    func selectedOption(index: Int) {
        switch selectedField {
        case .FamilyMember:
//            let data = viewModel.familyMemberData?[index]
            let data = familyMemberData[index]
           // memberTextfield.text = data.name
        case .Location:
//            let data = viewModel.locationData?.locations?[index]
            //dummy
            let data = location[index]
            locationId = data.locationId ?? 0
            locationTextfield.text = data.locationNameEn ?? ""
            departmentTextfield.text = ""
            serviceTextfield.text = ""
            doctorLabTextfield.text = ""
            departmentId = 0
            serviceId = 0
            doctorId = 0
        case .Department:
//            let data = viewModel.branchData?.locations?[index]
            let data = department[index]
            departmentId = data.branchId ?? 0
            departmentTextfield.text = data.branchNameEn ?? ""
            serviceTextfield.text = ""
            doctorLabTextfield.text = ""
            serviceId = 0
            doctorId = 0
        case .Service: 
//            let data = viewModel.serviceData?.services?[index]
//            serviceId = data?.serviceId ?? 0
//            serviceTextfield.text = data?.serviceNameEn ?? ""
//            doctorLabTextfield.text = ""
//            doctorId = 0
            var data:ServiceData?
            switch departmentTextfield.text {
            case "Cardiology":
                data = services1[index]
                serviceTextfield.text = data?.serviceNameEn
            case "Endocrinology":
                data = services2[index]
                serviceTextfield.text = data?.serviceNameEn
            case "Oncology":
                data = services3[index]
                serviceTextfield.text = data?.serviceNameEn
            default:
                break
            }
            serviceId = data?.serviceId ?? 0
            serviceTextfield.text = data?.serviceNameEn ?? ""
            doctorLabTextfield.text = ""
            doctorId = 0
        case .Doctor:
//            let data = viewModel.doctorData?.doctors?[index]
            let data = doctors[index]
            doctorId = data.drId ?? 0
            doctorLabTextfield.text = data.doctorName ?? ""
        default:
            break
        }
    }
    
    func selectedDate(date: String) {
        dateTextfield.text = date
    }
    
    func cancelDateSelection() {
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        selectedTextfield = textField
        switch textField {
        case locationTextfield:
            fetchLocations()
        case departmentTextfield:
            if locationTextfield.text == ""{
                self.showAlert("Please select location")
            }else{
                fetchDepartments()
            }
        case serviceTextfield:
            if departmentTextfield.text == ""{
                self.showAlert("Please select department")
            }else{
                fetchServices()
            }
        case doctorLabTextfield:
            if serviceTextfield.text == ""{
                self.showAlert("Please select service")
            }else{
                fetchDoctors()
            }
//        case memberTextfield:
//            fetchFamilyMembers()
        case dateTextfield:
            selectedTextfield = dateTextfield
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let popup = storyboard.instantiateViewController(withIdentifier: "DatePickerViewController") as! DatePickerViewController
            popup.isTimePicker = false
            popup.modalPresentationStyle = .overCurrentContext
            popup.delegate = self
            present(popup, animated: true, completion: nil)
        case timeTextfield:
            selectedTextfield = timeTextfield
            createDropDownAlert(title: "Select Time", data: timeList)
        default:
            break
        }
    }
}

extension BookAppointmentViewController{
    func createDropDownAlert(title:String,data:[String]){
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.view.tintColor = UIColor(hexString: "#777EDC")
        for item in data{
            alert.addAction(UIAlertAction(title: item, style: .default, handler: {action in
                self.selectedTextfield.text = item
            }))
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}

class CellClass: UITableViewCell {
    
}
extension BookAppointmentViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // return viewModel.familyMemberData?.count ?? 0
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FamilyCollectionViewCell", for: indexPath) as! FamilyCollectionViewCell
        let users = ["person1","person2","person3","person"]
        if indexPath.row == 4
        {
            cell.memberImage.image = UIImage(named: "add")
            cell.height.constant = 20
            cell.width.constant = 20
        }
        else
        {
            cell.memberImage.image = UIImage(named:users[indexPath.row])
            cell.memberImage.layer.cornerRadius = 15
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.row == 4)
        {
            let storyboard = UIStoryboard(name: "Modified", bundle: .main)
            let vc = storyboard.instantiateViewController(withIdentifier: "AddNewMemberViewController") as! AddNewMemberViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
}
