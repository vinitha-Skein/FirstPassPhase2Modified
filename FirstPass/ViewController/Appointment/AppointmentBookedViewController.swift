//
//  AppointmentBookedViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 23/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class AppointmentBookedViewController: UIViewController,FeedbackDelegate {
    
    @IBOutlet var bookingSuccessLabel: UILabel!
    @IBOutlet var bgView: UIView!
    @IBOutlet var headerView: UIView!
    @IBOutlet var patientImage: UIImageView!
    @IBOutlet var patientnameTitleLabel: UILabel!
    @IBOutlet var physicianImage: UIImageView!
    @IBOutlet var physicianTitleLabel: UILabel!
    @IBOutlet var timeImage: UIImageView!
    @IBOutlet var appointmenttimeTitleLabel: UILabel!
    @IBOutlet var calenderImage: UIImageView!

    @IBOutlet var successImage: UIImageView!
    
    @IBOutlet var appointmentdateTitleLabel: UILabel!
    @IBOutlet var stackview: UIStackView!
    @IBOutlet var stackBottomView: UIView!
    @IBOutlet var stackTopView: UIView!
    @IBOutlet var mainContainer: UIView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var feedbackButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var patientName: UILabel!
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    let buttonBorder = UIColor(red: 233/255, green: 134/255, blue: 0/255, alpha: 1)

    var appointmentData:CreatedAppointmentData?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
        patientName.text = appointmentData?.patientName
        doctorName.text = "Dr. " + (appointmentData?.doctorName ?? "")
        date.text = appointmentData?.date
        time.text = appointmentData?.appointmentTime
    }
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "vip")
        {
            //vipview()
        }
    }
    func vipview()
    {
        bgView.backgroundColor = UIColor.black
        headerView.backgroundColor = .black
        container.backgroundColor = UIColor(hex: "#222629")
        stackview.backgroundColor = UIColor(named: "vip")
        backButton.backgroundColor = UIColor(named: "vip")
        backButton.setTitleColor(UIColor(hex: "#503E00"), for: .normal)
        feedbackButton.backgroundColor = .clear
        feedbackButton.setTitleColor(.white, for: .normal)
        feedbackButton.layer.borderColor = UIColor(named: "vip")?.cgColor
        appointmenttimeTitleLabel.textColor = UIColor(named: "vip")
        appointmentdateTitleLabel.textColor = UIColor(named: "vip")
        time.textColor = UIColor(named: "vip")
        date.textColor = UIColor(named: "vip")
        physicianTitleLabel.textColor = UIColor(named: "vip")
        doctorName.textColor = UIColor(named: "vip")
        patientName.textColor = UIColor(named: "vip")
        patientnameTitleLabel.textColor = UIColor(named: "vip")
        successImage.image = UIImage(named: "vipsuccess")
        bookingSuccessLabel.textColor = UIColor(named: "vip")
    }
    @IBAction func backAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "phase2", bundle: .main)
        let popup = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        popup.modalPresentationStyle = .overCurrentContext
        present(popup, animated: true, completion: nil)
        
    }
    
    @IBAction func feedbackAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Modified", bundle: .main)
        let popup = storyboard.instantiateViewController(withIdentifier: "ProcessFeedbackViewController") as! ProcessFeedbackViewController
        popup.modalPresentationStyle = .overCurrentContext
        present(popup, animated: true, completion: nil)
    }
    
    func setupUI(){
        container.createBorderForView(cornerRadius: 30, borderWidth: 0, borderColor: .clear)
        stackTopView.layer.cornerRadius = 10
        stackBottomView.layer.cornerRadius = 10
        stackBottomView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        stackTopView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        container.clipsToBounds = true
        container.layer.borderWidth = 0.4
        container.layer.borderColor = UIColor.gray.cgColor
        container.layer.masksToBounds = false
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        container.layer.shadowOpacity = 0.2
        mainContainer.layer.cornerRadius = 30
        scrollView.layer.cornerRadius = 30
        backButton.createBorderForButton(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        feedbackButton.createBorderForButton(cornerRadius: 8, borderWidth: 1, borderColor: buttonBorder)
    }
    func feedbackAddStatus(status: Bool, message: String) {
        self.dismiss(animated: true, completion: nil)
        if status{
            self.showAlert(message)
        }
    }

}


protocol FeedbackDelegate {
    func feedbackAddStatus(status:Bool,message:String)
}
