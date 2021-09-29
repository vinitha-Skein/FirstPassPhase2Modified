//
//  SelectPopupViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 11/11/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class SelectPopupViewController: UIViewController {
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var popUpTitle: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    @IBOutlet weak var addButtonHeight: NSLayoutConstraint!
    lazy var viewHeight:CGFloat = {
        return self.view.frame.height/1.35
    }()
    var delegate:SelectPopupDelegate?
    var popUpFor:PopUpFor?
    var locations = [LocationData]()
    var departments = [BranchData]()
    var services = [ServiceData]()
    var doctors = [DoctorData]()
    var familyMembers = [FamilyMembersList]()
    var dataCount = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        tableview.register(UINib(nibName: "MemberTableViewCell", bundle: .main), forCellReuseIdentifier: "MemberTableViewCell")
        container.createBorderForView(cornerRadius: 14, borderWidth: 0, borderColor: .white)
        cancelButton.createBorderForButton(cornerRadius: 14, borderWidth: 0, borderColor: .white)
        addButton.createBorderForButton(cornerRadius: 14, borderWidth: 0, borderColor: .white)
        addButtonHeight.constant = 0
        addButton.isHidden = true
        
        switch popUpFor {
        case .FamilyMember:
            popUpTitle.text = "Family Members"
            addButtonHeight.constant = 50
            addButton.isHidden = false
        case .Location:
            popUpTitle.text = "Location"
        case .Department:
            popUpTitle.text = "Department"
        case .Service:
            popUpTitle.text = "Services"
        case .Doctor:
            popUpTitle.text = "Doctor"
        default:
            break
        }
        if (dataCount * 50) > Int(viewHeight){
            containerHeight.constant = viewHeight
        }else{
            containerHeight.constant = CGFloat(dataCount * 50) + 50
        }
    }
    
    @IBAction func addMemberAction(_ sender: Any) {
        delegate?.addNewMember()
    }
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension SelectPopupViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch popUpFor {
        case .FamilyMember:
            return familyMembers.count
        case .Location:
            return locations.count
        case .Department:
            return departments.count
        case .Service:
            return services.count
        case .Doctor:
            return doctors.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberTableViewCell", for: indexPath) as! MemberTableViewCell
        switch popUpFor {
        case .FamilyMember:
            cell.name.text = familyMembers[indexPath.row].name
        case .Location:
            cell.name.text = locations[indexPath.row].locationNameEn
        case .Department:
            cell.name.text = departments[indexPath.row].branchNameEn
        case .Service:
            cell.name.text = services[indexPath.row].serviceNameEn
        case .Doctor:
            cell.name.text = doctors[indexPath.row].doctorName
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectedOption(index: indexPath.row)
        self.dismiss(animated: true, completion: nil)
    }
}




protocol SelectPopupDelegate {
    func addNewMember()
    func selectedOption(index:Int)
}


enum PopUpFor {
    case FamilyMember
    case Location
    case Department
    case Service
    case Doctor
}
