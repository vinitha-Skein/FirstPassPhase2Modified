//
//  InPatientViewController.swift
//  FirstPass
//
//  Created by MacOS on 22/09/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit
import StepProgressIndicatorView

class InPatientViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var activityView: UIView!

    @IBOutlet weak var MyActivitiesLabel: UILabel!

    @IBOutlet weak var UpcommingActivitiesButton: UIButton!

    @IBOutlet weak var MyActivitiesView: MyUIView!
    @IBOutlet weak var TodayLabel: UILabel!

    @IBOutlet weak var ProgressView: StepProgressIndicatorView!


    @IBOutlet weak var viewMoreButton: UIButton!

    @IBOutlet weak var servicesLabel: UILabel!

    @IBOutlet weak var servicesCollectionView: UICollectionView!

    @IBOutlet weak var activitiesViewHeight: NSLayoutConstraint!

    let firstSteps = [
        "09:00 am","10:30 am","12:30 pm","01:30 pm","04:30 pm","05:00 pm","09:30 pm"
    ]

    let details = [
        0: "Breakfast",
        1: "Visit Dr.Ayesha",
        2: "Physiotherapy",
        3: "Lunch",
        4: "Physiotherapy",
        5: "Walk",
        6: "Dinner",
    ]

    var ServicesImages = [UIImage(named:"nurseCall"),UIImage(named:"hygieneServices"),UIImage(named:"food&Beverages"),UIImage(named:"Discgharge")]
    var serviceNames = ["Nurse Call","Hygiene Services","Food & Beverages","Discharge "]
    var lesserView = true

    override func viewDidLoad() {
        super.viewDidLoad()

        ProgressView.stepTitles = firstSteps
        ProgressView.details = details
        ProgressView.direction = .topToBottom
        ProgressView.currentStep = 0
        ProgressView.circleColor = #colorLiteral(red: 0.6352941176, green: 0.6431372549, blue: 0.8156862745, alpha: 1)
        ProgressView.circleTintColor = #colorLiteral(red: 0.1752281785, green: 0.1031386331, blue: 0.5185605288, alpha: 1)
        ProgressView.currentTextColor = ProgressView.circleTintColor
        ProgressView.circleStrokeWidth = 1.0
        ProgressView.circleRadius = 5.0
        ProgressView.lineColor = ProgressView.circleColor
        ProgressView.lineTintColor = ProgressView.circleTintColor
        ProgressView.lineMargin = 0.0
        ProgressView.lineStrokeWidth = 3.0
        ProgressView.displayNumbers = false
        ProgressView.showFlag = true
        for i in 0...2 {
        ProgressView.currentStep = i
        }

        servicesCollectionView.reloadData()
        TodayLabel.text = "- Today,\(getCurrentDate()) -"
    }


    @IBAction func viewMoreButtonPressed(_ sender: Any) {
        if lesserView {
            viewMoreButton.setTitle("View Less", for: .normal)
            viewMoreButton.setImage(UIImage(named: ""), for: .normal)
            activitiesViewHeight.constant = 450
            lesserView = false
        } else {
            viewMoreButton.setTitle("View More", for: .normal)
            viewMoreButton.setImage(UIImage(named: ""), for: .normal)
            activitiesViewHeight.constant = 250
            lesserView = true
        }
    }

    @IBAction func upcommingActivitiesPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "phase2", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UpcommingActivitiesViewController") as! UpcommingActivitiesViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

        func getCurrentDate() -> String  {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myString = formatter.string(from: Date())
            let yourDate = formatter.date(from: myString)
            formatter.dateFormat = "MMM dd"
            let myStringafd = formatter.string(from: yourDate!)

            return (myStringafd)

        }
        func getYesterdayDate() -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myString = formatter.string(from: Date.yesterday )
            let yourDate = formatter.date(from: myString)
            formatter.dateFormat = "MMMM dd"
            let myStringafd = formatter.string(from: yourDate!)
            return (myStringafd)
        }

        func getTomorrowDate() -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myString = formatter.string(from: Date.tomorrow )
            let yourDate = formatter.date(from: myString)
            formatter.dateFormat = "MMMM dd"
            let myStringafd = formatter.string(from: yourDate!)
            return (myStringafd)
        }
    func gotoNurseCall(){
        let storyboard = UIStoryboard(name: "Modified", bundle: .main)
               let vc = storyboard.instantiateViewController(withIdentifier: "NurseCallViewController") as! NurseCallViewController
               vc.modalPresentationStyle = .fullScreen
               self.view.window!.layer.add(self.rightToLeftTransition(), forKey: kCATransition)
               self.present(vc, animated: true)
           }
    func gotoHygeneCall(){
        let storyboard = UIStoryboard(name: "Modified", bundle: .main)
               let vc = storyboard.instantiateViewController(withIdentifier: "HygieneViewController") as! HygieneViewController
               vc.modalPresentationStyle = .fullScreen
               self.view.window!.layer.add(self.rightToLeftTransition(), forKey: kCATransition)
               self.present(vc, animated: true)
           }
    func gotoFoodBeverages(){
        let storyboard = UIStoryboard(name: "Modified", bundle: .main)
               let vc = storyboard.instantiateViewController(withIdentifier: "FoodandBeveragesViewController") as! FoodandBeveragesViewController
               vc.modalPresentationStyle = .fullScreen
               self.view.window!.layer.add(self.rightToLeftTransition(), forKey: kCATransition)
               self.present(vc, animated: true)
           }
    func gotodischargeViewController(){
        let storyboard = UIStoryboard(name: "phase2", bundle: .main)
               let vc = storyboard.instantiateViewController(withIdentifier: "DischargeViewController") as! DischargeViewController
               vc.modalPresentationStyle = .fullScreen
               self.view.window!.layer.add(self.rightToLeftTransition(), forKey: kCATransition)
               self.present(vc, animated: true)
           }



}
extension InPatientViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = servicesCollectionView.dequeueReusableCell(withReuseIdentifier: "InPatientServicesCVC", for: indexPath) as! InPatientServicesCVC
        cell.servicesLabel.text = serviceNames[indexPath.row]
//        cell.ServicesImageView.image = ServicesImages[indexPath.row]
        return cell

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize  {

            let width = servicesCollectionView.frame.width/2-4
            return CGSize(width: width, height: 180)

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
          gotoNurseCall()
        } else if indexPath.row == 1{
            gotoHygeneCall()
        } else if indexPath.row == 2{
            gotoFoodBeverages()
        } else if indexPath.row == 3 {
            gotodischargeViewController()
        }
    }

}
