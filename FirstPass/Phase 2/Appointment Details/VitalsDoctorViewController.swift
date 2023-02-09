//
//  VitalsDoctorViewController.swift
//  FirstPass
//
//  Created by MacOS on 23/11/22.
//  Copyright © 2022 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class VitalsDoctorViewController: UIViewController {

    @IBOutlet weak var vitalsDoctorTableView: UITableView!
    var doctornames = ["Angelina","Benjamin","Isabella","Elibeth"]
    var relations = ["Self","Father","Mother","Sister"]
    var doctorImages = ["VitalsDoctor1","VitalsDoctor2","VitalsDoctor3","VitalsDoctor4"]
    override func viewDidLoad() {
        super.viewDidLoad()

        vitalsDoctorTableView.delegate = self
        vitalsDoctorTableView.dataSource = self
    }
    
    @IBAction func buttonBackPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
  

}
extension VitalsDoctorViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doctornames.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VitalsDoctorTableViewCell", for: indexPath) as! VitalsDoctorTableViewCell
        
        cell.doctorImageView.image = UIImage(named: doctorImages[indexPath.row])
        cell.nameLabel.text = doctornames[indexPath.row]
        cell.familyRelationLabel.text = relations[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "phase2", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "VitalsGraphViewController") as! VitalsGraphViewController
        vc.name  = "\(doctornames[indexPath.row])'s Vitals (\(relations[indexPath.row]))"
        vc.modalPresentationStyle = .fullScreen
        self.view.window!.layer.add(self.rightToLeftTransition(), forKey: kCATransition)
        self.present(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
