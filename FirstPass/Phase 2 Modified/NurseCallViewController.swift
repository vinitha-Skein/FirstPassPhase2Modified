//
//  NurseCallViewController.swift
//  FirstPass
//
//  Created by Skeintech on 24/09/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class NurseCallViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var container: UIView!
    var icons = ["toilet-sanitization","Clinical Assistance","massage-therapi","General Request"]
    var activities = ["Request Urinal assistance","Request Clinical Assistance","Request massage/therapist","General Request"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.register(UINib(nibName: "NurseTableViewCell", bundle: .main), forCellReuseIdentifier: "NurseTableViewCell")
        tableview.delegate = self
        tableview.dataSource = self

        container.layer.cornerRadius = 20
//        Container.layer.borderColor = UIColor.gray.cgColor
//        Container.layer.borderWidth = 0.4
        container.layer.masksToBounds = false
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        container.layer.shadowOpacity = 0.2
    
        // Do any additional setup after loading the view.
    }
    

    @IBAction func back_Clicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
extension NurseCallViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NurseTableViewCell") as! NurseTableViewCell
        cell.iconImage.image = UIImage(named: icons[indexPath.row])
        cell.activityText.text = activities[indexPath.row]
        cell.container.layer.cornerRadius = 8
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print("Enter")
        let storyboard = UIStoryboard(name: "Modified", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NurseandHygienePopupViewController") as! NurseandHygienePopupViewController
        vc.Nurse = true

        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
}
