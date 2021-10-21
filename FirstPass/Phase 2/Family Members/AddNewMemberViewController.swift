//
//  AddNewMemberViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 19/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit

class AddNewMemberViewController: UIViewController {
    
    @IBOutlet var insuranceNumberLabel: UILabel!
    @IBOutlet var insuranceProviderLabel: UILabel!
    @IBOutlet var paymentsTitleLabel: UILabel!
    @IBOutlet var emiritesTitleLabel: UILabel!
    @IBOutlet var mrnTitleLabel: UILabel!
    @IBOutlet var dobTitleLabel: UILabel!
    @IBOutlet var relationTitleLabel: UILabel!
    @IBOutlet var fullnameTitleLabel: UILabel!
    @IBOutlet var surnameLabel: UILabel!
    @IBOutlet var headerView: UIView!
    
    @IBOutlet var bgView: UIView!
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var containerforBorder: UIView!
    @IBOutlet weak var selfpayButton: UIButton!
    @IBOutlet weak var insuranceButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var mrButton: UIButton!
    @IBOutlet weak var mrsButton: UIButton!
    @IBOutlet weak var msButton: UIButton!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var relationTextfield: UITextField!
    @IBOutlet weak var fullNameTextfield: UITextField!
    @IBOutlet weak var changeimgButtonView: UIView!
    @IBOutlet weak var maincontainer: UIView!
    @IBOutlet weak var dobTextfield: UITextField!
    @IBOutlet weak var mrnTextfield: UITextField!
    @IBOutlet weak var idProofTextfield: UITextField!
    //@IBOutlet weak var paymentMethodTextfield: UITextField!
    @IBOutlet weak var insuranceProviderTextfield: UITextField!
    @IBOutlet weak var insurancePolicyNumTextfield: UITextField!
    @IBOutlet weak var addButton: UIButton!
  //  @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var insuranceProviderView: UIView!
    @IBOutlet weak var insuranceNumberView: UIView!
    @IBOutlet weak var memberImage: UIImageView!

    var selectedTextfield = UITextField()
    var memberTitle = String()
    var isEdit = Bool()
    var familyMember:FamilyMembersList?
    var userId = Int()
    var imagePicker: ImagePicker!
    var viewModel = AddMemberViewModel()
    var delegate:AddMemberFromAppointmentScreenDelegate?
    var paymentMethodchoosen = String()
    var base64String = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        if isEdit{
            headingLabel.text = "Edit"
            fullNameTextfield.text = familyMember?.full_name
            dobTextfield.text = familyMember?.dob
            relationTextfield.text = familyMember?.relation
            mrnTextfield.text = familyMember?.mrn
            //idProofTextfield.text = familyMember?.id_proof
            //paymentMethodTextfield.text = familyMember?.paymentmethod
            idProofTextfield.text = familyMember?.national_id
//            if paymentMethodTextfield.text == "Insurance"
//            {
//                insuranceProviderTextfield.text = familyMember?.insurancename
//                insurancePolicyNumTextfield.text = familyMember?.insuranceno
//            }
//            if familyMember?.profile_pic != ""{
//                base64String = familyMember?.profile_pic ?? ""
//                memberImage.image = UIImage(named: familyMember?.profile_pic ?? "")
//            }
            memberTitle(title: familyMember?.full_name ?? "")
            addButton.setTitle("Update Member", for: .normal)
          //  clearButton.isHidden = true
        }
        memberTitle = "Mr"
        viewModel.getUserDetails()
        print(viewModel.userId ?? 0)
    }
   
    override func viewDidAppear(_ animated: Bool)
    {
        vipview()
    }
    func vipview()
    {
        bgView.backgroundColor = UIColor.black
        containerforBorder.backgroundColor = UIColor(hex: "#222629")
        headerView.backgroundColor = UIColor.black
        fullnameTitleLabel.textColor = UIColor(named: "vip")
        fullNameTextfield.backgroundColor = UIColor(hex: "#34383B")
        relationTitleLabel.textColor = UIColor(named: "vip")
        relationTextfield.backgroundColor = UIColor(hex: "#34383B")
        dobTitleLabel.textColor = UIColor(named: "vip")
        dobTextfield.backgroundColor = UIColor(hex: "#34383B")
        mrnTitleLabel.textColor = UIColor(named: "vip")
        mrnTextfield.backgroundColor = UIColor(hex: "#34383B")
        emiritesTitleLabel.textColor = UIColor(named: "vip")
        idProofTextfield.backgroundColor = UIColor(hex: "#34383B")
        paymentsTitleLabel.textColor = UIColor(named: "vip")
        insuranceProviderLabel.textColor = UIColor(named: "vip")
        insuranceProviderTextfield.backgroundColor = UIColor(hex: "#34383B")
        insuranceNumberLabel.textColor = UIColor(named: "vip")
        insurancePolicyNumTextfield.backgroundColor = UIColor(hex: "#34383B")
        addButton.backgroundColor = UIColor(named: "vip")
        addButton.setTitleColor(UIColor(named: "vip"), for: .normal)
        addButton.setTitleColor(UIColor(hex: "#503E00"), for: .normal)
        headingLabel.textColor = .white
        memberTitle(title: "Mr")
        fullNameTextfield.attributedPlaceholder = NSAttributedString(string: "Enter Fullname", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "#72767C")])
        relationTextfield.attributedPlaceholder = NSAttributedString(string: "Enter Relation", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "#72767C")])
        dobTextfield.attributedPlaceholder = NSAttributedString(string: "Enter DOB ", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "#72767C")])
        mrnTextfield.attributedPlaceholder = NSAttributedString(string: "Enter MRN ID", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "#72767C")])
        idProofTextfield.attributedPlaceholder = NSAttributedString(string: "Enter Emirites ID", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "#72767C")])
        insuranceProviderTextfield.attributedPlaceholder = NSAttributedString(string: "Enter Insurance Provider", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "#72767C")])
        insurancePolicyNumTextfield.attributedPlaceholder = NSAttributedString(string: "Enter Insurance Number", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "#72767C")])
        
        
        selfpayButton.backgroundColor = UIColor(named: "vip")
        insuranceButton.backgroundColor = UIColor.clear
        selfpayButton.setTitleColor(UIColor(hex: "#503E00"), for: .normal)
        insuranceButton.setTitleColor(UIColor(hex: "#72767C"), for: .normal)
        paymentMethodchoosen = "Selfpay"
        insuranceProviderView.isHidden = true
        insuranceNumberView.isHidden = true
        insuranceButton.layer.borderColor = UIColor(hex: "#72767C").cgColor
        insuranceButton.layer.borderWidth = 0.5
        
    }
    @IBAction func chooseImage(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        delegate?.appointmentAdded()
    }
    @IBAction func mrClicked(_ sender: Any) {
//        mrButton.backgroundColor = UIColor(hexString: "#6B38C1")
//        mrsButton.backgroundColor = UIColor(hexString: "#E1E3E6")
//        msButton.backgroundColor = UIColor(hexString: "#E1E3E6")
//        mrButton.setTitleColor(.white, for: .normal)
//        mrsButton.setTitleColor(.black, for: .normal)
//        msButton.setTitleColor(.black, for: .normal)
//        memberTitle = "Mr"
        memberTitle(title: "Mr")
    }
    func memberTitle(title:String)
    {
        switch title {
        case "Mr":
            
            if UserDefaults.standard.bool(forKey: "vip")
            {
                mrButton.backgroundColor = UIColor(named: "vip")
                mrsButton.backgroundColor = UIColor.clear
                msButton.backgroundColor = UIColor.clear
                mrButton.setTitleColor(UIColor(hex: "#503E00"), for: .normal)
                mrsButton.setTitleColor(UIColor(hex: "#72767C"), for: .normal)
                msButton.setTitleColor(UIColor(hex: "#72767C"), for: .normal)
                msButton.layer.borderColor = UIColor(hex: "#72767C").cgColor
                mrsButton.layer.borderColor = UIColor(hex: "#72767C").cgColor
            }
            else
            {
                mrButton.backgroundColor = UIColor(hexString: "#352364")
                mrsButton.backgroundColor = UIColor(hexString: "#E1E3E6")
                msButton.backgroundColor = UIColor(hexString: "#E1E3E6")
                mrButton.setTitleColor(.white, for: .normal)
                mrsButton.setTitleColor(.black, for: .normal)
                msButton.setTitleColor(.black, for: .normal)
                msButton.layer.borderColor = UIColor.black.cgColor
                mrsButton.layer.borderColor = UIColor.black.cgColor
            }
            
            
            msButton.layer.borderWidth = 0.5
            mrsButton.layer.borderWidth = 0.5

            memberTitle = "Mr"
        case "Mrs":
            if UserDefaults.standard.bool(forKey: "vip")
            {
                mrsButton.backgroundColor = UIColor(named: "vip")
                mrButton.backgroundColor = UIColor.clear
                msButton.backgroundColor = UIColor.clear
                mrsButton.setTitleColor(UIColor(hex: "#503E00"), for: .normal)
                mrButton.setTitleColor(UIColor(hex: "#72767C"), for: .normal)
                msButton.setTitleColor(UIColor(hex: "#72767C"), for: .normal)
                msButton.layer.borderColor = UIColor(hex: "#72767C").cgColor
                mrButton.layer.borderColor = UIColor(hex: "#72767C").cgColor
            }
            else
            {
                mrsButton.backgroundColor = UIColor(hexString: "#352364")
                mrButton.backgroundColor = UIColor(hexString: "#E1E3E6")
                msButton.backgroundColor = UIColor(hexString: "#E1E3E6")
                mrsButton.setTitleColor(.white, for: .normal)
                mrButton.setTitleColor(.black, for: .normal)
                msButton.setTitleColor(.black, for: .normal)
                msButton.layer.borderColor = UIColor.black.cgColor
                mrButton.layer.borderColor = UIColor.black.cgColor
           
            }
            msButton.layer.borderWidth = 0.5
            mrButton.layer.borderWidth = 0.5
            memberTitle = "Mrs"
           
        default:
            
            if UserDefaults.standard.bool(forKey: "vip")
            {
                msButton.backgroundColor = UIColor(named: "vip")
                mrButton.backgroundColor = UIColor.clear
                mrsButton.backgroundColor = UIColor.clear
                msButton.setTitleColor(UIColor(hex: "#503E00"), for: .normal)
                mrButton.setTitleColor(UIColor(hex: "#72767C"), for: .normal)
                mrsButton.setTitleColor(UIColor(hex: "#72767C"), for: .normal)
                mrsButton.layer.borderColor = UIColor(hex: "#72767C").cgColor
                mrButton.layer.borderColor = UIColor(hex: "#72767C").cgColor
            }
            else
            {
                msButton.backgroundColor = UIColor(hexString: "#352364")
                mrButton.backgroundColor = UIColor(hexString: "#E1E3E6")
                mrsButton.backgroundColor = UIColor(hexString: "#E1E3E6")
                msButton.setTitleColor(.white, for: .normal)
                mrsButton.setTitleColor(.black, for: .normal)
                mrButton.setTitleColor(.black, for: .normal)
                mrButton.layer.borderColor = UIColor.black.cgColor
                mrsButton.layer.borderColor = UIColor.black.cgColor
            }
            
            
            mrButton.layer.borderWidth = 0.5
            mrsButton.layer.borderWidth = 0.5
            memberTitle = "Ms"
        }
    }
    @IBAction func mrsClicked(_ sender: Any) {
//        mrsButton.backgroundColor = UIColor(hexString: "#6B38C1")
//        mrButton.backgroundColor = UIColor(hexString: "#E1E3E6")
//        msButton.backgroundColor = UIColor(hexString: "#E1E3E6")
//        mrsButton.setTitleColor(.white, for: .normal)
//        mrButton.setTitleColor(.black, for: .normal)
//        msButton.setTitleColor(.black, for: .normal)
//        memberTitle = "Mrs"
        memberTitle(title: "Mrs")

    }
    @IBAction func msClicked(_ sender: Any) {
//        msButton.backgroundColor = UIColor(hexString: "#6B38C1")
//        mrButton.backgroundColor = UIColor(hexString: "#E1E3E6")
//        mrsButton.backgroundColor = UIColor(hexString: "#E1E3E6")
//        msButton.setTitleColor(.white, for: .normal)
//        mrsButton.setTitleColor(.black, for: .normal)
//        mrButton.setTitleColor(.black, for: .normal)
//        memberTitle = "Ms"
        memberTitle(title: "Ms")

    }
    @IBAction func selfpay_clicked(_ sender: Any)
    {
        if UserDefaults.standard.bool(forKey: "vip")
        {
            selfpayButton.backgroundColor = UIColor(named: "vip")
            insuranceButton.backgroundColor = UIColor.clear
            selfpayButton.setTitleColor(UIColor(hex: "#503E00"), for: .normal)
            insuranceButton.setTitleColor(UIColor(hex: "#72767C"), for: .normal)
            paymentMethodchoosen = "Selfpay"
            insuranceProviderView.isHidden = true
            insuranceNumberView.isHidden = true
            insuranceButton.layer.borderColor = UIColor(hex: "#72767C").cgColor
            insuranceButton.layer.borderWidth = 0.5
        }
        else
        {
            selfpayButton.backgroundColor = UIColor(hexString: "#352364")
            insuranceButton.backgroundColor = UIColor(hexString: "#E1E3E6")
            selfpayButton.setTitleColor(.white, for: .normal)
            insuranceButton.setTitleColor(.black, for: .normal)
            paymentMethodchoosen = "Selfpay"
            insuranceProviderView.isHidden = true
            insuranceNumberView.isHidden = true
            insuranceButton.layer.borderColor = UIColor(hex: "#72767C").cgColor
            insuranceButton.layer.borderWidth = 0.5
        }
        
      
    }
    @IBAction func insurance_clicked(_ sender: Any)
    {
        if UserDefaults.standard.bool(forKey: "vip")
        {
            selfpayButton.backgroundColor = UIColor.clear
            insuranceButton.backgroundColor = UIColor(named: "vip")
            selfpayButton.setTitleColor(UIColor(hex: "#72767C"), for: .normal)
            insuranceButton.setTitleColor(UIColor(hex: "#503E00"), for: .normal)
            paymentMethodchoosen = "Insurance"
            insuranceProviderView.isHidden = false
            insuranceNumberView.isHidden = false
            selfpayButton.layer.borderColor = UIColor.white.cgColor
            selfpayButton.layer.borderWidth = 0.5
        }
        else
        {
            selfpayButton.backgroundColor = UIColor(hexString: "#E1E3E6")
            insuranceButton.backgroundColor = UIColor(hexString: "#352364")
            selfpayButton.setTitleColor(.black, for: .normal)
            insuranceButton.setTitleColor(.white, for: .normal)
            paymentMethodchoosen = "Insurance"
            insuranceProviderView.isHidden = false
            insuranceNumberView.isHidden = false
            selfpayButton.layer.borderColor = UIColor.black.cgColor
            selfpayButton.layer.borderWidth = 0.5
        }
        
        
    }
    @IBAction func clearAction(_ sender: Any) {
        clearAllFields()
    }
    func clearAllFields(){
        fullNameTextfield.text = ""
        dobTextfield.text = ""
        relationTextfield.text = ""
        mrnTextfield.text = ""
        idProofTextfield.text = ""
//        paymentMethodTextfield.text = ""
        insuranceProviderTextfield.text = ""
        insurancePolicyNumTextfield.text = ""
        insuranceProviderView.isHidden = true
        insuranceNumberView.isHidden = true
        base64String = ""
    }
    @IBAction func addMemberAction(_ sender: Any) {
        guard let relation = relationTextfield.text,let name = fullNameTextfield.text,let dob = dobTextfield.text,let mrn = mrnTextfield.text,let emiratesId = idProofTextfield.text, let insuranceName = insuranceProviderTextfield.text, let insuranceNumber = insuranceProviderTextfield.text else {
            return
        }
        let paymentMethod = paymentMethodchoosen
        if relation == ""{
            self.showAlert("Please select relation")
            return
        }
        if name == ""{
            self.showAlert("Please enter name")
            return
        }
        if dob == ""{
            self.showAlert("Please select DOB")
            return
        }
        if mrn == ""{
            self.showAlert("Please enter MRN")
            return
        }
        if emiratesId == ""{
            self.showAlert("Please enter Emirates ID")
            return
        }
        if paymentMethod == ""{
            self.showAlert("Please select payment method")
            return
        }
        if paymentMethod == "Insurance"{
            if insuranceName == ""{
                self.showAlert("Please enter Insurance provider name")
                return
            }
            if insuranceNumber == ""{
                self.showAlert("Please enter Insurance provider number")
                return
            }
        }
        
        var params = [
            "full_name":name,
            "mrn":mrn,
            "dob":dob,
            "relation":relation,
            "national_id": emiratesId
            ] as [String : Any]
        
        
        
        
        
        addFamilyMembers(params: params)
//        if paymentMethod == "Insurance"{
//            params["insurancename"] = insuranceName
//            params["insuranceno"] = insuranceNumber
//            params["insurancevalidity"] = ""
//            params["insurancecardimage"] = ""
//        }
        
//        if base64String != ""{
//            params["profilepic"] = base64String
//        }
//
//        if isEdit{
//            params["memberId"] = familyMember?.memberId
//            params["pId"] = familyMember?.pId
//            editFamilyMembers(params: params)
//        }else{
//            addFamilyMembers(params: params)
//        }
    }
    
    func addFamilyMembers(params:Dictionary<String,Any>){
        print(params)
        
        self.activityIndicator(self.view, startAnimate: true)
        viewModel.addFamilyMember(params: params)
        viewModel.addMemberSuccess =
            {
                self.view.makeToast("Family Member added Successfully.")
                self.clearAllFields()
                Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (_) in
                    self.dismiss(animated: true, completion: nil)
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
    func editFamilyMembers(params:[String:Any]){
        self.activityIndicator(self.view, startAnimate: true)
        viewModel.editFamilyMember(userId: viewModel.userId ?? 0, params: params)
        viewModel.editMemberSuccess = {
            self.dismiss(animated: true, completion: nil)
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


    
    func setupUI()
    {
        //container.createBorderForView(cornerRadius: 30, borderWidth: 0, borderColor: .clear)
        paymentMethodchoosen = "Selfpay"
        memberImage.layer.cornerRadius = 30
        changeimgButtonView.layer.cornerRadius = 12
        containerforBorder.layer.cornerRadius = 30
        containerforBorder.layer.borderWidth = 0.4
        containerforBorder.layer.borderColor = UIColor.lightGray.cgColor
        maincontainer.layer.cornerRadius = 30
        scrollview.layer.cornerRadius = 30
        container.clipsToBounds = true
        //memberImage.createCircle()
        relationTextfield.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        fullNameTextfield.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        dobTextfield.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        mrnTextfield.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
//        paymentMethodTextfield.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        insuranceProviderTextfield.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
         insurancePolicyNumTextfield.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        idProofTextfield.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)

        addButton.createBorderForButton(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
      //  clearButton.createBorderForButton(cornerRadius: 8, borderWidth: 0.5, borderColor: .black)
        insuranceButton.createBorderForButton(cornerRadius: 10, borderWidth: 0, borderColor: .black)
        selfpayButton.createBorderForButton(cornerRadius: 10, borderWidth: 0, borderColor: .black)
        mrButton.createBorderForButton(cornerRadius: 5, borderWidth: 0, borderColor: .black)
        mrsButton.createBorderForButton(cornerRadius: 5, borderWidth: 0, borderColor: .black)
        msButton.createBorderForButton(cornerRadius: 5, borderWidth: 0, borderColor: .black)
      //  clearButton.backgroundColor = .clear
        
        relationTextfield.addRightView(imageName: "rightView")
        dobTextfield.addRightView(imageName: "calendar")
      //  idProofTextfield.addRightView(imageName: "rightView")
//        paymentMethodTextfield.addRightView(imageName: "rightView")
       //insuranceProviderTextfield.addRightView(imageName: "rightView")
        relationTextfield.setPlaceholder(placeholderText: "Select relation")
        fullNameTextfield.setPlaceholder(placeholderText: "Enter full name")
        dobTextfield.setPlaceholder(placeholderText: "Select details")
        mrnTextfield.setPlaceholder(placeholderText: "Enter MRN ID")
        idProofTextfield.setPlaceholder(placeholderText: "Enter Emirites ID")
//        paymentMethodTextfield.setPlaceholder(placeholderText: "Payment Method")
        insuranceProviderTextfield.setPlaceholder(placeholderText: "Enter the name of the insurance provider")
        insurancePolicyNumTextfield.setPlaceholder(placeholderText: "Insurance number")
        relationTextfield.delegate = self
        dobTextfield.delegate = self
//        idProofTextfield.delegate = self
//        paymentMethodTextfield.delegate = self
//
       insuranceProviderView.isHidden = true
        insuranceNumberView.isHidden = true
    }
}
extension AddNewMemberViewController:UITextFieldDelegate,DatePickerDelegate{
    func selectedDate(date: String) {
        dobTextfield.text = date
    }
    
    func cancelDateSelection() {
        
    }
    func createDropDownAlert(title:String,data:[String]){
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.view.tintColor = UIColor(hexString: "#777EDC")
        for item in data{
            alert.addAction(UIAlertAction(title: item, style: .default, handler: {action in
                self.selectedTextfield.text = item
//                if self.selectedTextfield == self.paymentMethodTextfield
//                {
//                    if self.selectedTextfield.text == "Insurance"{
//                        self.insuranceProviderView.isHidden = false
//                        self.insuranceNumberView.isHidden = false
//                    }else{
//                        self.insuranceProviderView.isHidden = true
//                        self.insuranceNumberView.isHidden = true
//                    }
//                }
            }))
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        switch textField {
        case relationTextfield:
            selectedTextfield = relationTextfield
          createDropDownAlert(title: "Family Member", data: ["Father","Mother","Brother","Sister","Wife","Son","Daughter"])
        case dobTextfield:
            selectedTextfield = dobTextfield
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let popup = storyboard.instantiateViewController(withIdentifier: "DatePickerViewController") as! DatePickerViewController
            popup.isTimePicker = false
            popup.modalPresentationStyle = .overCurrentContext
            popup.delegate = self
            present(popup, animated: true, completion: nil)
//        case idProofTextfield:
//            selectedTextfield = idProofTextfield
//            createDropDownAlert(title: "ID Proof", data: ["Emirates ID","Passport"])
        default:
            break
        }
    }
}

extension AddNewMemberViewController: ImagePickerDelegate
{
    func didSelect(image: String?) {
        base64String = image!
        let imgData = Data(base64Encoded: image!, options: .ignoreUnknownCharacters)
        DispatchQueue.main.async {
            self.memberImage.image = UIImage(data: imgData!)
        }
    }
}


protocol AddMemberFromAppointmentScreenDelegate {
    func appointmentAdded()
}
