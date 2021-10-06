//
//  FamilyMemberViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 21/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class FamilyMemberViewController: UIViewController {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var addButton: UIButton!
    let viewModel = FamilyMemberViewModel()
    var familyMemberData = [FamilyMembersList]()
    var userId = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.register(UINib(nibName: "FamilyMemberTableViewCell", bundle: .main), forCellReuseIdentifier: "FamilyMemberTableViewCell")
        tableview.dataSource = self
        tableview.delegate = self
        setupUI()
        viewModel.getUserDetails()
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchFamilyMembers()
//        let myself = FamilyMembersList(name: "Mrs. Kiara Parker", dob: "Mar 03,1972", memberId: 0, pId: 0, releation: "Mother", title: "Mrs", nationalId: "", id_proof: "Emirates ID", paymentmethod: "", insurancename: "", insuranceno: "", insurancevalidity: "", insurancecardimage: "", mrnNo: "456878563", profile_pic: "person")
//        let member1 = FamilyMembersList(name: "Ms. Julie Parker", dob: "Aug 29,1996", memberId: 0, pId: 0, releation: "Sister", title: "Mrs", nationalId: "", id_proof: "Emirates ID", paymentmethod: "", insurancename: "", insuranceno: "", insurancevalidity: "", insurancecardimage: "", mrnNo: "998878563", profile_pic: "person1")
//        let member2 = FamilyMembersList(name: "Mr. John Parker", dob: "Jun 29, 1993", memberId: 0, pId: 0, releation: "Brother", title: "Mr", nationalId: "", id_proof: "Emirates ID", paymentmethod: "", insurancename: "", insuranceno: "", insurancevalidity: "", insurancecardimage: "", mrnNo: "678878563", profile_pic: "person2")
//        let member3 = FamilyMembersList(name: "Ms. Julie Parker", dob: "Aug 29,1996", memberId: 0, pId: 0, releation: "Sister", title: "Mrs", nationalId: "", id_proof: "Emirates ID", paymentmethod: "", insurancename: "person3", insuranceno: "", insurancevalidity: "Emirates ID", insurancecardimage: "", mrnNo: "998878563", profile_pic: "")
//        familyMemberData = [myself,member1,member2,member3]
    }

    @IBAction func backAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        vc.modalPresentationStyle = .fullScreen
        view.window!.layer.add(leftToRightTransition(), forKey: kCATransition)
        //                present(vc, animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addMemberAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Modified", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddNewMemberViewController") as! AddNewMemberViewController
        vc.modalPresentationStyle = .fullScreen
        vc.userId = userId
        view.window!.layer.add(rightToLeftTransition(), forKey: kCATransition)
        present(vc, animated: true)
    }
    
    func setupUI(){
        container.createBorderForView(cornerRadius: 30, borderWidth: 1, borderColor: .lightGray)
        container.clipsToBounds = true
        addButton.createBorderForButton(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
    }
    
    func fetchFamilyMembers(){
        self.activityIndicator(self.view, startAnimate: true)
        viewModel.fetchFamilyMember()
        viewModel.dataFetchSuccess = {
            self.familyMemberData = self.viewModel.familyMemberData ?? []
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
        viewModel.loadingStatus = {
            if self.viewModel.isLoading{
                self.activityIndicator(self.view, startAnimate: true)
            }else{
                self.activityIndicator(self.view, startAnimate: false)
                UIApplication.shared.endIgnoringInteractionEvents()
            }
        }
        viewModel.errorMessageAlert = {
            self.showAlert(self.viewModel.errorMessage ?? "Error")
        }
    }
}

extension FamilyMemberViewController:UITableViewDelegate,UITableViewDataSource,EditFamilyMemberDelegate{
    func editFamilyMember(index: Int) {
        let storyboard = UIStoryboard(name: "Modified", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddNewMemberViewController") as! AddNewMemberViewController
        vc.modalPresentationStyle = .fullScreen
        vc.isEdit = true
        vc.familyMember = viewModel.familyMemberData![index]
        vc.userId = userId
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return familyMemberData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyMemberTableViewCell", for: indexPath) as! FamilyMemberTableViewCell
        cell.updateData(data: viewModel.familyMemberData![indexPath.row])
        cell.container.layer.cornerRadius = 5
        //cell.updateData(data: familyMemberData[indexPath.row])
        //cell.editButton.tag = indexPath.row
        cell.delegate = self
//        cell.imageUrl = viewModel.familyMemberData![indexPath.row].profile_pic
        let users = ["person","person1","person2","person3"]
       // cell.pic.image = UIImage(named: users[indexPath.row])
        cell.pic.layer.cornerRadius = 18
        cell.deleteButtonPressed =
        {
            let storyboard = UIStoryboard(name: "Modified", bundle: .main)
            let vc = storyboard.instantiateViewController(withIdentifier: "DeleteFamilyMemberViewController") as! DeleteFamilyMemberViewController
            vc.modalPresentationStyle = .overCurrentContext
            //vc.isEdit = true
    //        vc.familyMember = viewModel.familyMemberData![index]
            //vc.userId = userId
            self.present(vc, animated: true)
        }
        cell.editButtonPressed =
            {
                let storyboard = UIStoryboard(name: "Modified", bundle: .main)
                let vc = storyboard.instantiateViewController(withIdentifier: "AddNewMemberViewController") as! AddNewMemberViewController
                vc.modalPresentationStyle = .fullScreen
                vc.isEdit = true
                vc.familyMember = self.familyMemberData[indexPath.row]
                vc.userId = self.userId
                self.present(vc, animated: true)

            }
        //cell.container.layer.cornerRadius = 30
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 103+16
        
    }
}



protocol EditFamilyMemberDelegate {
    func editFamilyMember(index:Int)
}
