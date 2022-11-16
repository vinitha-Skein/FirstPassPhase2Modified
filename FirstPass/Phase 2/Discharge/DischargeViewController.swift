//
//  DischargeViewController.swift
//  FirstPass
//
//  Created by MacOS on 25/09/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class DischargeViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var mainView: MyUIView!
    
    @IBOutlet weak var firstDot: MyUIView!
    
    @IBOutlet weak var ProgressTitleOne: UILabel!
    
    @IBOutlet weak var PatientEducationViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var patientEducationView: UIView!
    
    @IBOutlet weak var patientEducationLabel: UILabel!
    
    @IBOutlet weak var progressViewFirst: UIView!

    @IBOutlet weak var progressViewoneHEight: NSLayoutConstraint!
    
    @IBOutlet weak var secondDot: MyUIView!
    @IBOutlet weak var progressTitleTwo: UILabel!
    
    @IBOutlet weak var medicalDispensingView: UIView!
    
    @IBOutlet weak var medicalDispensingTableView: UITableView!
    
    @IBOutlet weak var medicalDispenseTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var secondProgressView: UIView!
    
    @IBOutlet weak var ProgessviewTwoHeight: NSLayoutConstraint!
    
    @IBOutlet weak var thirdDot: MyUIView!
    
    @IBOutlet weak var billingPaymentLabel: UILabel!
    
    @IBOutlet weak var billpaymentView: UIView!
    
    @IBOutlet weak var payonlineView: MyUIView!
    
    @IBOutlet weak var deskView: MyUIView!
    
    @IBOutlet weak var billpaymentViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var medicalDispensesViewHeight: NSLayoutConstraint!
    
    
    var progress = 0
    var tableviewheading = [["Medicine":"Medicine","1":"M","2":"A","3":"E","4":"N"],["Medicine":"Acetaminophen :  ","1":"1","2":"-","3":"1","4":"-"],["Medicine":"Cyclobenzaprine:","1":"-","2":"-","3":"1","4":"-"],["Medicine":"Januvia :","1":"1","2":"-","3":"-","4":"1"],["Medicine":"Omeprazole :","1":"-","2":"-","3":"1","4":"1"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        progressSetup()
        medicalDispensingTableView.delegate = self
        medicalDispensingTableView.dataSource = self
    }
 
    

    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextProgressPressed(_ sender: UIButton) {
        if sender.tag == 0 {
            progress = 1
            progressSetup()
           
        } else if sender.tag == 1 {
            progress = 2
            progressSetup()
         
        }
    }
    
    @IBAction func progressBackPressed(_ sender: UIButton) {
        if progress == 2 {
            progress = 1
            progressSetup()
        } else if progress == 1 {
            progress = 0
            progressSetup()
        }
    }
    
    @IBAction func onlinePaymentPressed(_ sender: UIButton) {
    }
    
    @IBAction func deskPaymentViewController(_ sender: Any) {
    }
    
    func progressSetup() {
        if progress == 1 {
            progressViewoneHEight.constant = 50
            patientEducationView.isHidden = true
            PatientEducationViewHeight.constant = 0
            progressTitleTwo.font = UIFont.boldSystemFont(ofSize: 15.0)
            ProgressTitleOne.font = UIFont.systemFont(ofSize: 15.0)
            billingPaymentLabel.font = UIFont.systemFont(ofSize: 15.0)
            progressViewFirst.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.1019607843, blue: 0.5176470588, alpha: 1)
            secondProgressView.backgroundColor = #colorLiteral(red: 0.6352941176, green: 0.6431372549, blue: 0.8156862745, alpha: 1)
            medicalDispenseTableViewHeight.constant = CGFloat(5*50)
            medicalDispensesViewHeight.constant = CGFloat(5*50) + 100
            ProgessviewTwoHeight.constant = CGFloat(5*50) + 150
            medicalDispensingView.isHidden = false
            billpaymentView.isHidden = true
            billpaymentViewHeight.constant = 0
            medicalDispensingTableView.reloadData()
        } else if progress == 2{
            progressViewoneHEight.constant = 50
            ProgessviewTwoHeight.constant = 50
            patientEducationView.isHidden = true
            PatientEducationViewHeight.constant = 0
            progressTitleTwo.font = UIFont.systemFont(ofSize: 15.0)
            ProgressTitleOne.font = UIFont.systemFont(ofSize: 15.0)
            billingPaymentLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
            billpaymentView.isHidden = false
            billpaymentViewHeight.constant = 250
            progressViewFirst.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.1019607843, blue: 0.5176470588, alpha: 1)
            secondProgressView.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.1019607843, blue: 0.5176470588, alpha: 1)
            medicalDispensingView.isHidden = true
        } else {
            progressViewoneHEight.constant = 270
            ProgessviewTwoHeight.constant = 50
            patientEducationView.isHidden = false
            PatientEducationViewHeight.constant = 250
            ProgressTitleOne.font = UIFont.boldSystemFont(ofSize: 15.0)
            progressTitleTwo.font = UIFont.systemFont(ofSize: 15.0)
            billingPaymentLabel.font = UIFont.systemFont(ofSize: 15.0)
            billpaymentView.isHidden = true
            billpaymentViewHeight.constant = 0
            progressViewFirst.backgroundColor = #colorLiteral(red: 0.6352941176, green: 0.6431372549, blue: 0.8156862745, alpha: 1)
            secondProgressView.backgroundColor = #colorLiteral(red: 0.6352941176, green: 0.6431372549, blue: 0.8156862745, alpha: 1)
            medicalDispensingView.isHidden = true
        }
    }
    
}
extension DischargeViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableviewheading.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DischargeMedicalTableViewCell") as! DischargeMedicalTableViewCell
        cell.MedicineLabel.text = tableviewheading[indexPath.row]["Medicine"]
        cell.morningLabel.text = tableviewheading[indexPath.row]["1"]
        cell.afternoonLabel.text = tableviewheading[indexPath.row]["2"]
        cell.eveningLabel.text = tableviewheading[indexPath.row]["3"]
        cell.NightLable.text = tableviewheading[indexPath.row]["4"]
        if indexPath.row == 0  {
            cell.MedicineLabel.textColor = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
            cell.morningLabel.textColor = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
            cell.afternoonLabel.textColor = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
            cell.eveningLabel.textColor = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
            cell.NightLable.textColor = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
        } else {
            cell.MedicineLabel.textColor = UIColor.black
            cell.morningLabel.textColor = UIColor.black
            cell.afternoonLabel.textColor = UIColor.black
            cell.eveningLabel.textColor = UIColor.black
            cell.NightLable.textColor = UIColor.black
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
