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
    @IBOutlet weak var collectionview: UICollectionView!
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
    var index = ["1/7","2/7","3/7","4/7","5/7","6/7","7/7"]
    
    @IBOutlet weak var appointmentCollectionView: UICollectionView!
    var trans_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.getUserDetails()
        tableView.register(UINib(nibName: "AppointmentdetailsNewTableViewCell", bundle: .main), forCellReuseIdentifier: "AppointmentdetailsNewTableViewCell")
        collectionview.delegate = self
        collectionview.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        collectionview.isHidden = false
        collectionview.collectionViewLayout = CardsJourneyCollectionViewLayout()
        collectionview.isPagingEnabled = true
        collectionview.showsHorizontalScrollIndicator = false
        collectionview.dataSource = self
        collectionview.delegate = self
        
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
            collectionview.backgroundColor = UIColor.black
            journeyLabel.textColor = UIColor.white
            departmentLabel.textColor = UIColor(named: "vip")
            qrcodeImage.layer.cornerRadius = 10
        }
        if self.appointmentData != nil {
            departmentLabel.text = self.appointmentData?.department
            doctorLabel.text = self.appointmentData?.doctor_name
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
    @IBAction func filterClicked(_ sender: Any)
    {
        if UserDefaults.standard.bool(forKey: "vip")
        {
        if (filterCollectionView)
        {
            filterCollectionView = false
            collectionview.isHidden = true
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
            collectionview.isHidden = false
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
        dismiss(animated: true, completion: nil)
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
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentdetailsNewTableViewCell") as! AppointmentdetailsNewTableViewCell
        cell.statusButton.layer.cornerRadius = 5
        if UserDefaults.standard.bool(forKey: "vip")
        {
            cell.Container.backgroundColor = UIColor(hex: "#34383B")
            cell.categoryLabel.textColor = UIColor(named: "vip")
            cell.estimatedWaitTimeLabel.textColor = UIColor.white
            cell.waitTimesMinsLabel.textColor = UIColor.white
            cell.ServingCounterLabel.textColor = UIColor.white
            cell.ServingLabel.textColor = UIColor.white
            cell.WholeContainer.backgroundColor = UIColor(hex: "#222629")
        }
        if(indexPath.row == 1)
        {
            cell.iconImage.image = UIImage(named: "iconlyCurvedPaper")
            cell.categoryLabel.text = Appointments[indexPath.row]
            cell.categoryLabel.textColor = UIColor.white
            cell.statusButton.setTitleColor(UIColor.white, for: .normal)
            cell.statusButton.setTitle("Ongoing", for: .normal)
            cell.statusButton.backgroundColor = UIColor(red: 233/255, green: 134/255, blue: 0/255, alpha: 1)
            cell.ServingCounterLabel.textColor = UIColor.white
            cell.estimatedWaitTimeLabel.textColor = UIColor.white
            cell.waitTimesMinsLabel.textColor = UIColor.white
            cell.ServingLabel.textColor = UIColor.white
            cell.indoorMapicon.setImage( UIImage(named: "indoor"), for: .normal)
            cell.Container.layer.cornerRadius = 10
            cell.statusButton.layer.cornerRadius = 5
            
            if UserDefaults.standard.bool(forKey: "vip")
            {
                cell.Container.backgroundColor = UIColor(named: "accountsbg")
                cell.statusButton.backgroundColor = UIColor.white
                cell.statusButton.setTitleColor(UIColor.brown, for: .normal)
                cell.categoryLabel.textColor = UIColor.brown
                cell.estimatedWaitTimeLabel.textColor = UIColor.brown
                cell.waitTimesMinsLabel.textColor = UIColor.brown
                cell.ServingCounterLabel.textColor = UIColor.brown
                cell.ServingLabel.textColor = UIColor.brown

            }
            
        }
        else if(indexPath.row == 2)
        {
            cell.statusButton.backgroundColor = UIColor(red: 204/255, green: 192/255, blue: 255/255, alpha: 1)
            cell.statusButton.setTitle("Upcomming", for: .normal)
            let bg = UIColor(red: 53/255, green: 35/255, blue: 100/255, alpha: 1)
            cell.statusButton.setTitleColor(bg, for: .normal)
            cell.categoryLabel.text = Appointments[indexPath.row]
            cell.Container.layer.cornerRadius = 10
            cell.statusButton.layer.cornerRadius = 5
            cell.statusButton.isHidden = false
            if UserDefaults.standard.bool(forKey: "vip")
            {
                cell.statusButton.backgroundColor = UIColor(hex: "#14181A")
                cell.statusButton.setTitleColor(UIColor.white, for: .normal)

            }

        }
        else
        {
            cell.categoryLabel.text = Appointments[indexPath.row]
            cell.Container.layer.cornerRadius = 10
            if(indexPath.row == 0)
            {
                cell.statusButton.isHidden = false
            }
            else
            {
                cell.statusButton.isHidden = true

            }
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
                if (cell.statusButton.currentTitle == "Upcomming")
                {
                    let storyboard = UIStoryboard(name: "Modified", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "TokenPopup") as! TokenPopup
                    vc.modalPresentationStyle = .fullScreen
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
            
        }
        
        cells.categoryLabel.text = Appointments[indexPath.row]
        cells.indexLabel.text = index[indexPath.row]
        
        if (indexPath.row == 0)
        {
            cells.statusButton.backgroundColor = UIColor(red: 21/255, green: 181/255, blue: 48/255, alpha: 1)
            cells.statusButton.setTitle("Completed", for: .normal)
            cells.statusButton.setTitleColor(UIColor.white, for: .normal)
            cells.statusButton.isHidden = false
        }
        else if (indexPath.row == 2)
        {
            cells.statusButton.isHidden = false
            cells.statusButton.backgroundColor = UIColor(red: 204/255, green: 192/255, blue: 255/255, alpha: 1)
            cells.statusButton.setTitle("Upcomming", for: .normal)
            cells.statusButton.setTitleColor(UIColor(red: 53/255, green: 35/255, blue: 100/255, alpha: 1), for: .normal)
            cells.statusButton.isHidden = false
        }
        else if (indexPath.row == 1)
        {
            cells.statusButton.backgroundColor = UIColor(red: 233/255, green: 134/255, blue: 0, alpha: 1)
            cells.statusButton.setTitle("Ongoing", for: .normal)
            cells.statusButton.setTitleColor(UIColor.white, for: .normal)
            cells.statusButton.isHidden = false
        }
        else
        {
            cells.statusButton.isHidden = true
        }
        cells.indoorMapButtonPressed =
        {
//            let storyboard = UIStoryboard(name: "Modified", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "IndoorMapViewController") as! IndoorMapViewController
//            vc.modalPresentationStyle = .fullScreen
//            self.present(vc, animated: true, completion: nil)
        }
        cells.statusButtonPressed =
            {
                if (indexPath.row == 2)
                {
                    let storyboard = UIStoryboard(name: "Modified", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "TokenPopup") as! TokenPopup
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
            }
        return cells
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 334, height: 228)
    }

}
//    extension AppointmentDetailsViewController:UITableViewDelegate,UITableViewDataSource{
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return 5
//        }
//
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentDetailsTableViewCell", for: indexPath) as! AppointmentDetailsTableViewCell
//            cell.updateBackgroundColorUI(indexPath: indexPath)
//            return cell
//        }
//
//        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//            return 135
//        }
//
//
//    }
