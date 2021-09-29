//
//  UpcommingActivitiesViewController.swift
//  FirstPass
//
//  Created by MacOS on 24/09/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit
import StepProgressIndicatorView

class UpcommingActivitiesViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!

    @IBOutlet weak var buttonBack: UIButton!

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var titlesView: UIView!

    @IBOutlet weak var PreviousDAteButton: UIButton!

    @IBOutlet weak var TodayDateButton: UIButton!

    @IBOutlet weak var futureDateButton: UIButton!

    @IBOutlet weak var progressView: StepProgressIndicatorView!

    let firstSteps = ["09:00 am","10:30 am","12:30 pm","01:30 pm","04:30 pm","05:00 pm","09:30 pm"]
    let details = [
        0: "Breakfast",
        1: "Visit Dr.Ayesha",
        2: "Physiotherapy",
        3: "Lunch",
        4: "Physiotherapy",
        5: "Walk",
        6: "Dinner"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        progressView.stepTitles = firstSteps
        progressView.details = details
        progressView.direction = .topToBottom
        progressView.currentStep = 0
        progressView.circleColor = #colorLiteral(red: 0.6342966557, green: 0.6435546279, blue: 0.817643702, alpha: 1)
        progressView.circleTintColor = #colorLiteral(red: 0.1752281785, green: 0.1031386331, blue: 0.5185605288, alpha: 1)
        progressView.currentTextColor = progressView.circleTintColor
        progressView.circleStrokeWidth = 1.0
        progressView.circleRadius = 5.0
        progressView.lineColor = progressView.circleColor
        progressView.lineTintColor = progressView.circleTintColor
        progressView.lineMargin = 0.0
        progressView.lineStrokeWidth = 3.0
        progressView.displayNumbers = false
        progressView.showFlag = true
        for i in 0...2 {
            progressView.currentStep = i
        }

    }

    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }



}
