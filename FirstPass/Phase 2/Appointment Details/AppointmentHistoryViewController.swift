//
//  AppointmentHistoryViewController.swift
//  FirstPass
//
//  Created by Skeintech on 24/06/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class AppointmentHistoryViewController: UIViewController {
    
    @IBOutlet var headLabel: UILabel!
    @IBOutlet var scrollView: UIView!
    @IBOutlet var scrollViewContainer: UIScrollView!
    @IBOutlet var tableview: UITableView!
    var headtext = String()
    var Departmentsections = ["Registration","Vitals","Consultation","Pharmacy"]
    
    var appointment : ActiveAppointmentData?
    
    @IBOutlet weak var tokenNumber: UILabel!
    
    @IBOutlet weak var tokenNumberTitleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    
    @IBOutlet weak var TimeLabel: UILabel!
    
    @IBOutlet weak var doctorNameLabel: UILabel!
    
    @IBOutlet weak var patientNameLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib(nibName: "AppointmentHistoryTableViewCell", bundle: .main), forCellReuseIdentifier: "AppointmentHistoryTableViewCell")
        scrollView.createBorderForView(cornerRadius: 30, borderWidth: 0, borderColor: .clear)
        scrollViewContainer.createBorderForView(cornerRadius: 30, borderWidth: 0, borderColor: .clear)
        scrollView.layer.masksToBounds = false
        scrollView.layer.shadowColor = UIColor.black.cgColor
        scrollView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        scrollView.layer.shadowOpacity = 0.2
        headLabel.text = headtext
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
                dateLabel.text = string
                formatter.dateFormat = "h:mm a"
                let stringTime = formatter.string(from: date)
                TimeLabel.text = stringTime
            }
            doctorNameLabel.text = self.appointment?.doctor_name
            patientNameLabel.text = (self.appointment?.patient_name!)! + "|self|25yrs"
            tokenNumber.text = appointment?.token_no
            tokenNumberTitleLabel.text = "Token Number"
            if appointment?.token_no == ""{
                tokenNumber.text = appointment?.trans_id
                tokenNumberTitleLabel.text = "Transcation Id"
            }
            if appointment?.department == "Cardiology" {
                Departmentsections = ["Registration","Vitals","Consultation","ECG","X-ray","Pharmacy"]
            }
            
        }
        
    }
    

    @IBAction func back_clicked(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    

}
extension AppointmentHistoryViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Departmentsections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "AppointmentHistoryTableViewCell") as! AppointmentHistoryTableViewCell
        cell.departmentLabel.text = Departmentsections[indexPath.row]
        cell.container.layer.cornerRadius = 8
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}
