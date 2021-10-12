//
//  AppointmentDetailsViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 19/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class AppointmentDetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var bgView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var wholeContainer: UIView!
    @IBOutlet weak var container: MyUIView!
    @IBOutlet weak var qrcodeImage: UIImageView!
    @IBOutlet weak var journeyLabel: UILabel!
    @IBOutlet weak var patientNameLabel: UILabel!
    @IBOutlet weak var patientNameTitleLabel: UILabel!
    @IBOutlet weak var tokenLabel: UILabel!
    @IBOutlet weak var timeImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateImage: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var doctorLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    
    
    @IBOutlet weak var filterButton: UIButton!
    //@IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    //    @IBOutlet weak var appointmentName: UILabel!
//    @IBOutlet weak var date: UILabel!
//    @IBOutlet weak var time: UILabel!
//    @IBOutlet weak var patientName: UILabel!
//    @IBOutlet weak var relationType: UILabel!
//    @IBOutlet weak var tableview: UITableView!
//    @IBOutlet weak var container: UIView!
//    @IBOutlet weak var backButton: UIButton!
//    @IBOutlet weak var patientDetailView: UIView!
//    @IBOutlet weak var cancelButton: UIButton!
//   @IBOutlet weak var ageLabel: UILabel!
    let viewModel = AppointmentDetailsViewModel()
    var appointmentData:ActiveAppointmentData?
    var filterCollectionView = true
    var Appointments = ["Registration","Vitals","Consultation","Pharmacy"]
    var journey = ["Registration","Vitals","Consultation","Pharmacy"]
//    var index = ["1/7","2/7","3/7","4/7","5/7","6/7","7/7"]
    
    @IBOutlet weak var appointmentCollectionView: UICollectionView!
    var trans_id = ""
    var journeyDetails : JourneyDetails?
    var currentJourneyIndex = 0
    
    var centerFlowLayout: SJCenterFlowLayout?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.getUserDetails()
        tableView.register(UINib(nibName: "AppointmentdetailsNewTableViewCell", bundle: .main), forCellReuseIdentifier: "AppointmentdetailsNewTableViewCell")
        appointmentCollectionView.delegate = self
        appointmentCollectionView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        appointmentCollectionView.isHidden = false

        appointmentCollectionView.dataSource = self
        appointmentCollectionView.delegate = self
        let centerFlowLayout = SJCenterFlowLayout()
        centerFlowLayout.itemSize = CGSize(width: appointmentCollectionView.frame.size.width-70, height:  appointmentCollectionView.frame.size.height)
        centerFlowLayout.animationMode = SJCenterFlowLayoutAnimation.scale(sideItemScale: 0.6, sideItemAlpha: 0.6, sideItemShift: 0.0)
        centerFlowLayout.scrollDirection =  .horizontal
        centerFlowLayout.spacingMode = .fixed(spacing: 10)
        appointmentCollectionView.collectionViewLayout = centerFlowLayout
        
        
        if UserDefaults.standard.bool(forKey: "vip")
        {
            tableView.backgroundColor = UIColor(hex: "#222629")
            bgView.backgroundColor = UIColor(hex: "#14181A")
            wholeContainer.backgroundColor = UIColor(hex: "#14181A")
            container.backgroundColor = UIColor(hex: "#222629")
            headerView.backgroundColor = UIColor(hex: "#14181A")
            titleLabel.textColor = UIColor.white
            doctorLabel.textColor = UIColor(named: "vip")
            dateLabel.textColor = UIColor(named: "vip")
            timeLabel.textColor = UIColor(named: "vip")
            patientNameLabel.textColor = UIColor(named: "vip")
            patientNameTitleLabel.textColor = UIColor(named: "vip")
            tokenLabel.textColor = UIColor(named: "vip")
            appointmentCollectionView.backgroundColor = UIColor.black
            journeyLabel.textColor = UIColor.white
            departmentLabel.textColor = UIColor(named: "vip")
            qrcodeImage.layer.cornerRadius = 10
        }
        if self.appointmentData != nil {
            departmentLabel.text = self.appointmentData?.department
            doctorLabel.text = self.appointmentData?.doctor_name
            tokenLabel.text = self.appointmentData?.token_no
            let dateString = self.appointmentData?.appointment_time!
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM  d yyyy h:mm:ss:SSSa"
            if let date = formatter.date(from: dateString!) {
                formatter.dateFormat = "dd-MM-yyyy"
                let string = formatter.string(from: date)
                print(string)
                dateLabel.text = string
                formatter.dateFormat = "h:mm a"
                let stringTime = formatter.string(from: date)
                timeLabel.text = stringTime
            }
           
            
            
        }
    }
    override func viewDidLayoutSubviews() {

        appointmentCollectionView.scrollToItem(at:IndexPath(item: self.currentJourneyIndex, section: 0), at: .right, animated: false)
    }
    override func viewDidAppear(_ animated: Bool) {
        if self.appointmentData?.department == "Lab" {
             Appointments = ["Registration","Lab"]
        }
        let key =  "JOURNEY" + (self.appointmentData?.trans_id)!
        do {
            if let data = UserDefaults.standard.data(forKey: key) {
                let journey  = try PropertyListDecoder().decode(JourneyDetails.self, from: data)
                self.journeyDetails = journey
            }
        } catch {
            debugPrint(error)
        }
        if self.journeyDetails != nil {
            if self.journeyDetails?.currentJourneyUpdate == "Registration" {
                self.currentJourneyIndex = 0
            } else if self.journeyDetails?.currentJourneyUpdate == "Vitals" {
                self.currentJourneyIndex = 1
            } else if self.journeyDetails?.currentJourneyUpdate == "Consultation"
            {
                self.currentJourneyIndex = 2
            } else if self.journeyDetails?.currentJourneyUpdate == "ECG" {
                self.currentJourneyIndex = 3
                Appointments = ["Registration","Vitals","Consultation","ECG","X-ray","Pharmacy"]
            } else if self.journeyDetails?.currentJourneyUpdate == "X-ray" {
                self.currentJourneyIndex = 4
                Appointments = ["Registration","Vitals","Consultation","ECG","X-ray","Pharmacy"]
            } else if self.journeyDetails?.currentJourneyUpdate == "Pharmacy" {
                 if self.appointmentData?.department == "Cardiology"{
                    Appointments = ["Registration","Vitals","Consultation","ECG","X-ray","Pharmacy"]
                }
                self.currentJourneyIndex = Appointments.count-1
            } else if self.journeyDetails?.currentJourneyUpdate == "Lab"{
                self.currentJourneyIndex = Appointments.count-1
            }
//            self.currentJourneyIndex = Appointments.count-1
            self.viewDidLayoutSubviews()
            self.appointmentCollectionView.reloadData()
            self.tableView.reloadData()
        }
        
        
    }
    @IBAction func filterClicked(_ sender: Any)
    {
        if UserDefaults.standard.bool(forKey: "vip")
        {
        if (filterCollectionView)
        {
            filterCollectionView = false
            appointmentCollectionView.isHidden = true
            tableView.isHidden = false
            tableViewHeight.constant = 700
            filterButton.setImage(UIImage(named: "grid"), for: .normal)
            titleLabel.textColor = UIColor.white
            doctorLabel.textColor = UIColor.white
            dateLabel.textColor = UIColor.white
            timeLabel.textColor = UIColor.white
            patientNameLabel.textColor = UIColor.white
            patientNameTitleLabel.textColor = UIColor.white
            tokenLabel.textColor = UIColor(named: "vip")
            departmentLabel.textColor = UIColor.white
          
        }
        else
        {
            filterCollectionView = true
            appointmentCollectionView.isHidden = false
            tableViewHeight.constant = 250
            tableView.isHidden = true
            filterButton.setImage(UIImage(named: "filters"), for: .normal)
            doctorLabel.textColor = UIColor(named: "vip")
            dateLabel.textColor = UIColor(named: "vip")
            timeLabel.textColor = UIColor(named: "vip")
            patientNameLabel.textColor = UIColor(named: "vip")
            patientNameTitleLabel.textColor = UIColor(named: "vip")
            departmentLabel.textColor = UIColor(named: "vip")
        }
        }else {
            if (filterCollectionView)
            {
                filterCollectionView = false
                appointmentCollectionView.isHidden = true
                tableView.isHidden = false
                tableViewHeight.constant = 700
            }
            else
            {
                filterCollectionView = true
                appointmentCollectionView.isHidden = false
                tableViewHeight.constant = 250
                tableView.isHidden = true
            }
            }
        
    }
    @IBAction func backAction(_ sender: Any)
    {
//        let storyboard = UIStoryboard(name: "Main", bundle: .main)
//        let vc = storyboard.instantiateViewController(withIdentifier: "MyAppointmentsViewController") as! MyAppointmentsViewController
//        vc.modalPresentationStyle = .fullScreen
//        let transition = CATransition()
//        transition.duration = 0.5
//        transition.type = CATransitionType.push
//        transition.subtype = CATransitionSubtype.fromLeft
//        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
//        view.window!.layer.add(transition, forKey: kCATransition)
//        present(vc, animated: true)
//        dismiss(animated: true, completion: nil)
        
            let storyboard = UIStoryboard(name: "phase2", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
    }
    @IBAction func cancelAction(_ sender: Any)
    {
//        self.activityIndicator(self.view, startAnimate: true)
//        viewModel.cancelAppointment(appointmentId: appointmentData?.serviceBookedId ?? 0)
        viewModel.cancelSuccess = {
            self.showAlert("Appointment Cancelled")
        }
        viewModel.errorMessageAlert = {
            self.showAlert(self.viewModel.errorMessage ?? "Error")
        }
        viewModel.loadingStatus = {
            if self.viewModel.isLoading{
                self.activityIndicator(self.view, startAnimate: true)
            }else{
                self.activityIndicator(self.view, startAnimate: false)
                UIApplication.shared.endIgnoringInteractionEvents()
            }
        }
    }
    
    
    
    
   
    }
extension AppointmentDetailsViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        Appointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentdetailsNewTableViewCell") as! AppointmentdetailsNewTableViewCell
        cell.statusButton.layer.cornerRadius = 5
//        if UserDefaults.standard.bool(forKey: "vip")
//        {
//            cell.Container.backgroundColor = UIColor(hex: "#34383B")
//            cell.categoryLabel.textColor = UIColor(named: "vip")
//            cell.estimatedWaitTimeLabel.textColor = UIColor.white
//            cell.waitTimesMinsLabel.textColor = UIColor.white
//            cell.ServingCounterLabel.textColor = UIColor.white
//            cell.ServingLabel.textColor = UIColor.white
//            cell.WholeContainer.backgroundColor = UIColor(hex: "#222629")
////        } else if {
////
////        }
//        }
//        if(indexPath.row == 1)
//        {
//            cell.iconImage.image = UIImage(named: "iconlyCurvedPaper")
//            cell.categoryLabel.text = Appointments[indexPath.row]
//            cell.categoryLabel.textColor = UIColor.white
//            cell.statusButton.setTitleColor(UIColor.white, for: .normal)
//            cell.statusButton.setTitle("Ongoing", for: .normal)
//            cell.statusButton.backgroundColor = UIColor(red: 233/255, green: 134/255, blue: 0/255, alpha: 1)
//            cell.ServingCounterLabel.textColor = UIColor.white
//            cell.estimatedWaitTimeLabel.textColor = UIColor.white
//            cell.waitTimesMinsLabel.textColor = UIColor.white
//            cell.ServingLabel.textColor = UIColor.white
//            cell.indoorMapicon.setImage( UIImage(named: "indoor"), for: .normal)
//            cell.Container.layer.cornerRadius = 10
//            cell.statusButton.layer.cornerRadius = 5
//
//            if UserDefaults.standard.bool(forKey: "vip")
//            {
//                cell.Container.backgroundColor = UIColor(named: "accountsbg")
//                cell.statusButton.backgroundColor = UIColor.white
//                cell.statusButton.setTitleColor(UIColor.brown, for: .normal)
//                cell.categoryLabel.textColor = UIColor.brown
//                cell.estimatedWaitTimeLabel.textColor = UIColor.brown
//                cell.waitTimesMinsLabel.textColor = UIColor.brown
//                cell.ServingCounterLabel.textColor = UIColor.brown
//                cell.ServingLabel.textColor = UIColor.brown
//
//            }
//
//        }
//        else if(indexPath.row == 2)
//        {
//            cell.statusButton.backgroundColor = UIColor(red: 204/255, green: 192/255, blue: 255/255, alpha: 1)
//            cell.statusButton.setTitle("Upcomming", for: .normal)
//            let bg = UIColor(red: 53/255, green: 35/255, blue: 100/255, alpha: 1)
//            cell.statusButton.setTitleColor(bg, for: .normal)
//            cell.categoryLabel.text = Appointments[indexPath.row]
//            cell.Container.layer.cornerRadius = 10
//            cell.statusButton.layer.cornerRadius = 5
//            cell.statusButton.isHidden = false
//            if UserDefaults.standard.bool(forKey: "vip")
//            {
//                cell.statusButton.backgroundColor = UIColor(hex: "#14181A")
//                cell.statusButton.setTitleColor(UIColor.white, for: .normal)
//
//            }
//
//        }
//        else
//        {
            cell.categoryLabel.text = Appointments[indexPath.row]
            cell.Container.layer.cornerRadius = 10
        
            if currentJourneyIndex == indexPath.row {
                cell.statusButton.backgroundColor = UIColor(red: 233/255, green: 134/255, blue: 0, alpha: 1)
                cell.statusButton.setTitle("Ongoing", for: .normal)
                cell.statusButton.setTitleColor(UIColor.white, for: .normal)
                cell.statusButton.isHidden = false
                cell.Container.backgroundColor = #colorLiteral(red: 0.2078431373, green: 0.137254902, blue: 0.3921568627, alpha: 1)
                cell.categoryLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                cell.estimatedTitleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                cell.estimatedLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                cell.counterTitleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                cell.counterNumberLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else if currentJourneyIndex < indexPath.row {
                if currentJourneyIndex+1 == indexPath.row {
                    cell.statusButton.isHidden = false
                    cell.statusButton.backgroundColor = UIColor(red: 204/255, green: 192/255, blue: 255/255, alpha: 1)
                    cell.statusButton.setTitle("Upcomming", for: .normal)
                    cell.statusButton.setTitleColor(UIColor(red: 53/255, green: 35/255, blue: 100/255, alpha: 1), for: .normal)
                    cell.statusButton.isHidden = false
                } else {
                    cell.statusButton.isHidden = true
                }
                cell.Container.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9294117647, blue: 1, alpha: 1)
                cell.categoryLabel.textColor = #colorLiteral(red: 0.2078431373, green: 0.137254902, blue: 0.3921568627, alpha: 1)
                cell.estimatedTitleLabel.textColor = #colorLiteral(red: 0.2901960784, green: 0.3098039216, blue: 0.3411764706, alpha: 1)
                cell.estimatedLabel.textColor = #colorLiteral(red: 0.2901960784, green: 0.3098039216, blue: 0.3411764706, alpha: 1)
                cell.counterTitleLabel.textColor = #colorLiteral(red: 0.2901960784, green: 0.3098039216, blue: 0.3411764706, alpha: 1)
                cell.counterNumberLabel.textColor = #colorLiteral(red: 0.2901960784, green: 0.3098039216, blue: 0.3411764706, alpha: 1)
            } else {
                cell.Container.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
                cell.categoryLabel.textColor = #colorLiteral(red: 0.2078431373, green: 0.137254902, blue: 0.3921568627, alpha: 1)
                cell.estimatedTitleLabel.textColor = #colorLiteral(red: 0.2901960784, green: 0.3098039216, blue: 0.3411764706, alpha: 1)
                cell.estimatedLabel.textColor = #colorLiteral(red: 0.2901960784, green: 0.3098039216, blue: 0.3411764706, alpha: 1)
                cell.counterTitleLabel.textColor = #colorLiteral(red: 0.2901960784, green: 0.3098039216, blue: 0.3411764706, alpha: 1)
                cell.counterNumberLabel.textColor = #colorLiteral(red: 0.2901960784, green: 0.3098039216, blue: 0.3411764706, alpha: 1)
                cell.statusButton.backgroundColor = UIColor(red: 21/255, green: 181/255, blue: 48/255, alpha: 1)
                cell.statusButton.setTitle("Completed", for: .normal)
                cell.statusButton.setTitleColor(UIColor.white, for: .normal)
                cell.statusButton.isHidden = false
            }
        
        
        cell.indoorMapButtonPressed =
            {
//                let storyboard = UIStoryboard(name: "Modified", bundle: nil)
//                let vc = storyboard.instantiateViewController(withIdentifier: "IndoorMapViewController") as! IndoorMapViewController
//                vc.modalPresentationStyle = .fullScreen
//                self.present(vc, animated: true, completion: nil)

            }
        cell.statusButtonPressed =
            {
                if cell.statusButton.titleLabel?.text! == "Ongoing"
                {
                    let storyboard = UIStoryboard(name: "Modified", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "TokenPopup") as! TokenPopup
                    vc.modalPresentationStyle = .fullScreen
                    vc.appointmentData = self.appointmentData
                    self.present(vc, animated: true, completion: nil)
                }
            }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
}
extension AppointmentDetailsViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        Appointments.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cells = collectionView.dequeueReusableCell(withReuseIdentifier: "AppointdetailsCollectionViewCell", for: indexPath) as! AppointdetailsCollectionViewCell
        
        if UserDefaults.standard.bool(forKey: "vip")
        {
            cells.Container.backgroundColor = UIColor(named: "vip")
            cells.nextStopDepartmentLabel.textColor = UIColor.brown
            cells.categoryLabel.textColor = UIColor.brown
            cells.WaitTimeLabel.textColor = UIColor.brown
            cells.NextStopLabel.textColor = UIColor.brown
            cells.nextStopDepartmentLabel.textColor = UIColor.brown
            
        } else {
            if currentJourneyIndex == indexPath.row {
                cells.statusButton.backgroundColor = UIColor(red: 233/255, green: 134/255, blue: 0, alpha: 1)
                cells.statusButton.setTitle("Ongoing", for: .normal)
                cells.statusButton.setTitleColor(UIColor.white, for: .normal)
                cells.statusButton.isHidden = false
                cells.Container.backgroundColor = #colorLiteral(red: 0.2078431373, green: 0.137254902, blue: 0.3921568627, alpha: 1)
                cells.categoryLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                cells.estimatedTitleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                cells.estimatedLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                cells.counterTitleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                cells.counterNumberLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                cells.NextStopLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                cells.nextStopDepartmentLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                cells.WaitTimeLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                cells.indexLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else if currentJourneyIndex < indexPath.row {
                if currentJourneyIndex+1 == indexPath.row {
                    cells.statusButton.isHidden = false
                    cells.statusButton.backgroundColor = UIColor(red: 204/255, green: 192/255, blue: 255/255, alpha: 1)
                    cells.statusButton.setTitle("Upcomming", for: .normal)
                    cells.statusButton.setTitleColor(UIColor(red: 53/255, green: 35/255, blue: 100/255, alpha: 1), for: .normal)
                    cells.statusButton.isHidden = false
                } else {
                    cells.statusButton.isHidden = true
                }
                cells.Container.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9294117647, blue: 1, alpha: 1)
                cells.categoryLabel.textColor = #colorLiteral(red: 0.2078431373, green: 0.137254902, blue: 0.3921568627, alpha: 1)
                cells.estimatedTitleLabel.textColor = #colorLiteral(red: 0.2901960784, green: 0.3098039216, blue: 0.3411764706, alpha: 1)
                cells.estimatedLabel.textColor = #colorLiteral(red: 0.2901960784, green: 0.3098039216, blue: 0.3411764706, alpha: 1)
                cells.counterTitleLabel.textColor = #colorLiteral(red: 0.2901960784, green: 0.3098039216, blue: 0.3411764706, alpha: 1)
                cells.counterNumberLabel.textColor = #colorLiteral(red: 0.2901960784, green: 0.3098039216, blue: 0.3411764706, alpha: 1)
                cells.NextStopLabel.textColor = #colorLiteral(red: 0.2901960784, green: 0.3098039216, blue: 0.3411764706, alpha: 1)
                cells.nextStopDepartmentLabel.textColor = #colorLiteral(red: 0.2901960784, green: 0.3098039216, blue: 0.3411764706, alpha: 1)
                cells.WaitTimeLabel.textColor = #colorLiteral(red: 0.2901960784, green: 0.3098039216, blue: 0.3411764706, alpha: 1)
                cells.indexLabel.textColor = #colorLiteral(red: 0.2901960784, green: 0.3098039216, blue: 0.3411764706, alpha: 1)
            } else {
                cells.Container.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
                cells.categoryLabel.textColor = #colorLiteral(red: 0.2078431373, green: 0.137254902, blue: 0.3921568627, alpha: 1)
                cells.estimatedTitleLabel.textColor = #colorLiteral(red: 0.2901960784, green: 0.3098039216, blue: 0.3411764706, alpha: 1)
                cells.estimatedLabel.textColor = #colorLiteral(red: 0.2901960784, green: 0.3098039216, blue: 0.3411764706, alpha: 1)
                cells.counterTitleLabel.textColor = #colorLiteral(red: 0.2901960784, green: 0.3098039216, blue: 0.3411764706, alpha: 1)
                cells.counterNumberLabel.textColor = #colorLiteral(red: 0.2901960784, green: 0.3098039216, blue: 0.3411764706, alpha: 1)
                cells.NextStopLabel.textColor = #colorLiteral(red: 0.2901960784, green: 0.3098039216, blue: 0.3411764706, alpha: 1)
                cells.nextStopDepartmentLabel.textColor = #colorLiteral(red: 0.2901960784, green: 0.3098039216, blue: 0.3411764706, alpha: 1)
                cells.WaitTimeLabel.textColor = #colorLiteral(red: 0.2901960784, green: 0.3098039216, blue: 0.3411764706, alpha: 1)
                cells.statusButton.backgroundColor = UIColor(red: 21/255, green: 181/255, blue: 48/255, alpha: 1)
                cells.statusButton.setTitle("Completed", for: .normal)
                cells.statusButton.setTitleColor(UIColor.white, for: .normal)
                cells.statusButton.isHidden = false
                cells.indexLabel.textColor = #colorLiteral(red: 0.2901960784, green: 0.3098039216, blue: 0.3411764706, alpha: 1)
                
            }
        }
        
        cells.categoryLabel.text = Appointments[indexPath.row]
        cells.indexLabel.text = "\(indexPath.row+1)/\(Appointments.count)"
        
//        if (indexPath.row == 0)
//        {
//            cells.statusButton.backgroundColor = UIColor(red: 21/255, green: 181/255, blue: 48/255, alpha: 1)
//            cells.statusButton.setTitle("Completed", for: .normal)
//            cells.statusButton.setTitleColor(UIColor.white, for: .normal)
//            cells.statusButton.isHidden = false
//        }
//        else if (indexPath.row == 2)
//        {
//            cells.statusButton.isHidden = false
//            cells.statusButton.backgroundColor = UIColor(red: 204/255, green: 192/255, blue: 255/255, alpha: 1)
//            cells.statusButton.setTitle("Upcomming", for: .normal)
//            cells.statusButton.setTitleColor(UIColor(red: 53/255, green: 35/255, blue: 100/255, alpha: 1), for: .normal)
//            cells.statusButton.isHidden = false
//        }
//        else if (indexPath.row == 1)
//        {
//            cells.statusButton.backgroundColor = UIColor(red: 233/255, green: 134/255, blue: 0, alpha: 1)
//            cells.statusButton.setTitle("Ongoing", for: .normal)
//            cells.statusButton.setTitleColor(UIColor.white, for: .normal)
//            cells.statusButton.isHidden = false
//        }
//        else
//        {
//            cells.statusButton.isHidden = true
//        }
        cells.indoorMapButtonPressed =
        {
//            let storyboard = UIStoryboard(name: "Modified", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "IndoorMapViewController") as! IndoorMapViewController
//            vc.modalPresentationStyle = .fullScreen
//            self.present(vc, animated: true, completion: nil)
        }
        cells.statusButtonPressed =
            {
                if cells.statusButton.titleLabel?.text! == "Ongoing"
                {
                    let storyboard = UIStoryboard(name: "Modified", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "TokenPopup") as! TokenPopup
                    vc.modalPresentationStyle = .fullScreen
                    vc.appointmentData = self.appointmentData
                    self.present(vc, animated: true, completion: nil)
                }
            }
        return cells
    }
   
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 334, height: 228)
//    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("did select")
       if self.currentJourneyIndex == Appointments.count-1 {
        let storyboard = UIStoryboard(name: "phase2", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CoffeeOfferViewController") as! CoffeeOfferViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        }
    }
}


