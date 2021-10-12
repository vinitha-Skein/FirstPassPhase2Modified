//
//  ContactsViewController.swift
//  FirstPass
//
//  Created by Skeintech on 23/09/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {

    @IBOutlet weak var Container: UIView!
    @IBOutlet weak var tableview: UITableView!
    var Branches = ["Branch 1","Branch 2","Branch 3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.register(UINib(nibName: "ContactsTableViewCell", bundle: .main), forCellReuseIdentifier: "ContactsTableViewCell")
        tableview.delegate = self
        tableview.dataSource = self
        Container.layer.cornerRadius = 20
//        Container.layer.borderColor = UIColor.gray.cgColor
//        Container.layer.borderWidth = 0.4
        Container.layer.masksToBounds = false
        Container.layer.shadowColor = UIColor.black.cgColor
        Container.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        Container.layer.shadowOpacity = 0.2
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func back_Clicked(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    

}
extension ContactsViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Branches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "ContactsTableViewCell") as! ContactsTableViewCell
        cell.container.layer.cornerRadius = 10
        cell.branchLabel.text = Branches[indexPath.row]
        cell.MapButtonPressed =
            {
                let latitude = "25.284903"
                let longitude = "55.321512"
                if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
                     UIApplication.shared.open(URL(string:"comgooglemaps://?center=\(latitude),\(longitude)&zoom=14&views=traffic&q=\(latitude),\(longitude)")!, options: [:], completionHandler: nil)
                 } else {
                     UIApplication.shared.open(URL(string: "http://maps.google.com/maps?q=loc:\(latitude),\(longitude)&zoom=14&views=traffic&q=\(latitude),\(longitude)")!, options: [:], completionHandler: nil)
                 }
            }
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //for Demo
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
