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
    var Departmentsections = ["Vitals","Cardiology","Blood Test","Pharmacy"]
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
        // Do any additional setup after loading the view.
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
