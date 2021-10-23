//
//  DoctorFilterViewController.swift
//  FirstPass
//
//  Created by Skeintech on 21/09/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.


import UIKit

class DoctorFilterViewController: UIViewController
{
    
    
    @IBOutlet var departmenttitleLabel: UILabel!
    @IBOutlet var locationTitleLabel: UILabel!
    @IBOutlet var applyButton: UIButton!
    @IBOutlet var clearallButton: UIButton!
    @IBOutlet var closeButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet weak var popupContainer: UIView!
    @IBOutlet weak var Container: UIView!
    @IBOutlet weak var locationFeild: UITextField!
    @IBOutlet weak var departmentFeild: UITextField!
    
    
    var location = [LocationData]()
    var department = [BranchData]()
    var selectedField:PopUpFor?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.isOpaque = false
        Container.layer.cornerRadius = 30
        popupContainer.layer.cornerRadius = 30
        locationFeild.addRightView(imageName: "dropdown")
        departmentFeild.addRightView(imageName: "dropdown")
        locationFeild.delegate = self
        departmentFeild.delegate = self
        
        
        //dummy data
        let loc1 = LocationData(locationAddress: "", locationId: 0, locationIdentfier: "", locationNameAr: "", locationNameEn: "Riyadh")
        let loc2 = LocationData(locationAddress: "", locationId: 0, locationIdentfier: "", locationNameAr: "", locationNameEn: "Dubai Health Street")
        location = [loc1,loc2]
        
        let dep1 = BranchData(branchId: 0, branchNameAr: "", branchNameEn: "Cardiology", branchType: nil)
        let dep2 = BranchData(branchId: 0, branchNameAr: "", branchNameEn: "Endocrinology", branchType: nil)
        let dep3 = BranchData(branchId: 0, branchNameAr: "", branchNameEn: "Oncology", branchType: nil)
        
        department = [dep1,dep2,dep3]
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
        popupContainer.backgroundColor = UIColor(named: "vip")
    }
    
    @IBAction func clearAll_Clicked(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func back_Pressed(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func apply_Clicked(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    func fetchLocations(){
      
        
        self.selectedField = PopUpFor.Location
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let popup = storyboard.instantiateViewController(withIdentifier: "SelectPopupViewController") as! SelectPopupViewController
        popup.modalPresentationStyle = .overCurrentContext
        popup.popUpFor = PopUpFor.Location
        popup.dataCount = self.location.count
        popup.locations = self.location
        popup.delegate = self
        self.present(popup, animated: true, completion: nil)
    }
    
    func fetchDepartments(){
      
        //dummy data
        
        self.selectedField = PopUpFor.Department
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let popup = storyboard.instantiateViewController(withIdentifier: "SelectPopupViewController") as! SelectPopupViewController
        popup.modalPresentationStyle = .overCurrentContext
        popup.popUpFor = PopUpFor.Department
        popup.dataCount = self.department.count
        popup.departments = self.department
        popup.delegate = self
        self.present(popup, animated: true, completion: nil)
    }
}
extension DoctorFilterViewController:UITextFieldDelegate,SelectPopupDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.resignFirstResponder()
        //selectedTextfield = textField
        switch textField {
        case locationFeild:
            fetchLocations()
        case departmentFeild:
            if locationFeild.text == ""{
                self.showAlert("Please select location")
            }
            else{
                fetchDepartments()
            }
        default:
            do {
                self.showAlert("Invalid Data")
            }
        }
    }
    func addNewMember() {
        
    }
    
    func selectedOption(index: Int)
    {
        switch selectedField {
        case .Location:
          
            let data = location[index]
           
            locationFeild.text = data.locationNameEn ?? ""
            departmentFeild.text = ""
           
        case .Department:
            let data = department[index]
            departmentFeild.text = data.branchNameEn ?? ""
            
        default:
            break
        }
    }
    
}
