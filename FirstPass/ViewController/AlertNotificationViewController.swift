//
//  AlertNotificationViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 14/10/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class AlertNotificationViewController: UIViewController {

    @IBOutlet var bgView: UIView!
    @IBOutlet var optionsButton: UIButton!
    @IBOutlet var headerView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var tableview:UITableView!
    let indexcount = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                   overrideUserInterfaceStyle = .light
               } 
        //container.createBorderForView(cornerRadius: 30, borderWidth: 0, borderColor: .clear)
//        container.clipsToBounds = true
//        container.layer.masksToBounds = false
//        container.layer.shadowColor = UIColor.black.cgColor
//        container.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        container.layer.shadowOpacity = 1
        container.layer.cornerRadius = 30
        container.layer.borderColor = UIColor.lightGray.cgColor
        container.layer.borderWidth = 0.2
        tableview.register(UINib(nibName: "AlertTableCell", bundle: .main), forCellReuseIdentifier: "AlertTableCell")
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool)
    {
        if UserDefaults.standard.bool(forKey: "vip")
        {
            vipview()
        }
    }
    func vipview()
    {
        headerView.backgroundColor = UIColor.black
        bgView.backgroundColor = UIColor.black
        container.backgroundColor = UIColor(hex: "#222629")
        titleLabel.textColor = UIColor.white
        
    }
    @IBAction func backAction(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Main", bundle: .main)
//        let vc = storyboard.instantiateViewController(withIdentifier: "FamilyMemberViewController") as! FamilyMemberViewController
//        vc.modalPresentationStyle = .fullScreen
        dismiss(animated: true, completion: nil)
        
    }

}


extension AlertNotificationViewController:UITableViewDelegate,UITableViewDataSource{
   
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return 120
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
            let cell = tableView.dequeueReusableCell(withIdentifier: "AlertTableCell", for: indexPath) as! AlertTableCell
        if UserDefaults.standard.bool(forKey: "vip")
        {
            cell.notificationMessage.textColor =
                UIColor.black
            cell.notificationTime.textColor = UIColor(named: "vip")
            cell.selectionButton.setImage(UIImage(named: "vipcheckboxunselected"), for: .normal)
        }
        else
        {
            cell.notificationMessage.textColor =
                UIColor.black
        }
        
        
        if indexPath.row == 0
        {
        cell.notificationMessage.text = "Dear Natasha, your personal concierge is Waiting for you near the reception."
            cell.notificationTime.text = "Just now"
        }else if indexPath.row == 1 {
        cell.notificationMessage.text = "Dear Natasha, your personal concierge is Waiting for you near the reception."
            cell.notificationTime.text = "Just now"
        }else if indexPath.row == 2 {
        cell.notificationMessage.text = "Dear Natasha, your personal concierge is Waiting for you near the reception."
            cell.notificationTime.text = "Mar 30,2021"
        }
        else if indexPath.row == 3 {
        cell.notificationMessage.text = "Dear Natasha, your personal concierge is Waiting for you near the reception."
            cell.notificationTime.text = "March 12,2021"
        }
        else if indexPath.row == 4 {
        cell.notificationMessage.text = "Dear Natasha, your personal concierge is Waiting for you near the reception."
            cell.notificationTime.text = "March 12,2021"
        }
        else if indexPath.row == 5 {
        cell.notificationMessage.text = "Dear Natasha, your personal concierge is Waiting for you near the reception."
            cell.notificationTime.text = "March 06,2021"
        }
        else if indexPath.row == 6 {
        cell.notificationMessage.text = "Dear Natasha, your personal concierge is Waiting for you near the reception."
            cell.notificationTime.text = "March 03,2021"
        }
        var index = Int()
        
        if UserDefaults.standard.bool(forKey: "vip")
        {
            cell.buttonPressed =
            {
                
                if (index == 1)
                    {
                    cell.selectionButton.setImage(UIImage(named: "vipcheckboxunselected"), for: .normal)
                    index = 0
                    }
                else
                {
                    cell.selectionButton.setImage(UIImage(named: "vipcheckboxselected"), for: .normal)
                    index = 1
                }
            }
        }
        else
        {
            cell.buttonPressed =
            {
                
                if (index == 1)
                    {
                    cell.selectionButton.setImage(UIImage(named: "checkboxDeselected"), for: .normal)
                    index = 0
                    }
                else
                {
                    cell.selectionButton.setImage(UIImage(named: "checkboxSelected"), for: .normal)
                    index = 1
                }
            }
        }
            return cell
       
    }
    
    
}
