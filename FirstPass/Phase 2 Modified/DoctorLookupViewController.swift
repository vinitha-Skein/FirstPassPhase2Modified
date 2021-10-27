//
//  DoctorLookupViewController.swift
//  FirstPass
//
//  Created by Skeintech on 21/09/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class DoctorLookupViewController: UIViewController {
    
    @IBOutlet var filterButton: UIButton!
    @IBOutlet var bgView: UIView!
    @IBOutlet var bacButton: UIButton!
    
    @IBOutlet var doctorLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var container: UIView!
    
    let names = ["Dr. John Smith","Dr. John Carter","Dr. Emma ava","Dr. Charlotte jolie"]
    var department = ["Cardiologist","Dermatology","Medical genetics","Anesthesiology"]
    var doctorImages = ["person","person1","person2","person3","person4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableview.register(UINib(nibName: "DoctorsLookupTableViewCell", bundle: .main), forCellReuseIdentifier: "DoctorsLookupTableViewCell")
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
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "vip")
        {
            vipview()
        }
    }
    func vipview()
    {
        bgView.backgroundColor = UIColor.black
        doctorLabel.textColor = .white
        titleLabel.textColor = .white
        container.backgroundColor = UIColor(named: "#222629")
    }
    @IBAction func back_Clicked(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func fliter_Clicked(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Modified", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DoctorFilterViewController") as! DoctorFilterViewController
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
}
extension DoctorLookupViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "DoctorsLookupTableViewCell") as! DoctorsLookupTableViewCell
        if UserDefaults.standard.bool(forKey: "vip")
        {
            cell.container.backgroundColor = UIColor(hex: "#34383B")
            cell.nameLabel.textColor = UIColor(named: "vip")
            cell.departmentLabel.textColor = .white

        }
        else
        {
            cell.container.backgroundColor = UIColor(hex: "#F8F8F9")
            cell.nameLabel.textColor = .black
            cell.departmentLabel.textColor = .black
        }
        cell.container.layer.cornerRadius = 10
       
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
}
