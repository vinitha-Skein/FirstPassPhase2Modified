//
//  FilterViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 10/11/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    var array = ["By type","By month"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.register(UINib(nibName: "FilterTableViewCell", bundle: .main), forCellReuseIdentifier: "FilterTableViewCell")
        tableview.register(UINib(nibName: "FilterCategoryTableViewCell", bundle: .main), forCellReuseIdentifier: "FilterCategoryTableViewCell")

        container.createBorderForView(cornerRadius: 14, borderWidth: 0, borderColor: .white)
        doneButton.createBorderForButton(cornerRadius: 14, borderWidth: 0, borderColor: .white)
    }
    @IBAction func doneAction(_ sender: Any) {
    }
    
}


extension FilterViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5//array.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40//60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCategoryTableViewCell", for: indexPath) as! FilterCategoryTableViewCell
//        cell.type.text = array[indexPath.row]
        return cell
    }
}
