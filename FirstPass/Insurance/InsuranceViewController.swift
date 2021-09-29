//
//  InsuranceViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 27/11/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class InsuranceViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.register(UINib(nibName: "InsuranceTableViewCell", bundle: .main), forCellReuseIdentifier: "InsuranceTableViewCell")
        setupUI()
    }
    func setupUI(){
        container.createBorderForView(cornerRadius: 30, borderWidth: 0, borderColor: .clear)
        container.clipsToBounds = true
        addButton.createBorderForButton(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        
    }
    @IBAction func addAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddInsuranceViewController") as! AddInsuranceViewController
        vc.modalPresentationStyle = .fullScreen
        //        view.window!.layer.add(rightToLeftTransition(), forKey: kCATransition)
        present(vc, animated: true)
    }
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


extension InsuranceViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InsuranceTableViewCell", for: indexPath) as! InsuranceTableViewCell
        cell.updateInsuranceDataToUI()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }
    
    
}
