//
//  SideMenuViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 22/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    let viewModel = MenuViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        viewModel.getMenuItems()
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func logoutAction(_ sender: Any) {
        viewModel.removeUserData()
        viewModel.removeUserDataSuccess = {
            UserDefaults.standard.set(false,forKey: "isLoggedIn")
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
 
    @IBAction func closeAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

extension SideMenuViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell", for: indexPath) as! SideMenuTableViewCell
        cell.menuItem.text = viewModel.menuItems[indexPath.row].name
        cell.icon.image = UIImage(named: viewModel.menuItems[indexPath.row].imageName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let vc = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        case 1:
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let vc = storyboard.instantiateViewController(withIdentifier: "AlertNotificationViewController") as! AlertNotificationViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        case 2:
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let vc = storyboard.instantiateViewController(withIdentifier: "FamilyMemberViewController") as! FamilyMemberViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        case 3:
            break
//            let storyboard = UIStoryboard(name: "Main", bundle: .main)
//            let vc = storyboard.instantiateViewController(withIdentifier: "AppointmentDetailsViewController") as! AppointmentDetailsViewController
//            vc.modalPresentationStyle = .fullScreen
//            present(vc, animated: true)
        case 4:
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let vc = storyboard.instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        case 5:
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let vc = storyboard.instantiateViewController(withIdentifier: "ReportsViewController") as! ReportsViewController
            vc.modalPresentationStyle = .fullScreen
            vc.isNeedBackButton = true
            present(vc, animated: true)
        case 6:
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let vc = storyboard.instantiateViewController(withIdentifier: "IndoorMapViewController")
                //as! IndoorMapViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        case 7:
            tabBarController?.selectedIndex = 3
            
        case 8:
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let vc = storyboard.instantiateViewController(withIdentifier: "AppointmentViewController") as! AppointmentViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        default:
            break
        }
    }
    
    
}
