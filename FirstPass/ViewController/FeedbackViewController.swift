//
//  FeedbackViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 23/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var container: UIView!
    var feedbackArray = ["How was Welcome/Help desk service ?","Assistance service","Token Navigation service at the facility","Nurse care","Doctor care","Lab & report services","Pharmacist","Appointment Booking","Feedback (in words)"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.register(UINib(nibName: "FeedbackTableViewCell", bundle: .main), forCellReuseIdentifier: "FeedbackTableViewCell")
        tableview.dataSource = self
        tableview.delegate = self
        tableview.transform = CGAffineTransform(rotationAngle: -(CGFloat)(Double.pi));
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        vc.modalPresentationStyle = .fullScreen
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(vc, animated: true)
    }
    
    @IBAction func nextAction(_ sender: Any) {
        array.insert("2", at: 0)
        tableview.reloadData()
    }
    
    func setupUI(){
        container.clipsToBounds = true
        container.createBorderForView(cornerRadius: 30.0, borderWidth: 0, borderColor: .clear)
        nextButton.createBorderForButton(cornerRadius: 8, borderWidth: 0, borderColor: .clear)

    }
    var array = ["1"]
}


extension FeedbackViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 107
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedbackTableViewCell", for: indexPath) as! FeedbackTableViewCell
        cell.feedback.text = "\(array[indexPath.row])"
        cell.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi));
        return cell
    }
    
    
}
