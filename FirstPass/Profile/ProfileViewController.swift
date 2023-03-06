//
//  ProfileViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 17/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit
import RealmSwift
class ProfileViewController: UIViewController,UITextFieldDelegate,ImagePickerDelegate {
    
    @IBOutlet var viewAllButton: UIButton!
    @IBOutlet var mrnIDHeadLabel: UILabel!
    @IBOutlet var familyMembersHeadLabel: UILabel!
    @IBOutlet var emailHeadLabel: UILabel!
    @IBOutlet var mobileHeadLabel: UILabel!
    @IBOutlet var firstnameHeadLabel: UILabel!
    @IBOutlet var personalInfoHeadLabel: UILabel!
    @IBOutlet var passwordHeadLabel: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var headerView: UIView!
    @IBOutlet var bgView: UIView!
    
    
    @IBOutlet var MrnLabel: UILabel!
    @IBOutlet weak var container: UIView!
    
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet weak var changePicBgView: UIView!
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var changePicButton: UIButton!
    var imagePicker: ImagePicker!
    var blurView = UIView()
    let passwordSuccess = UIView()
    let changePasswordView = UIView()
    let confirmTextfield = UITextField()
    let newTextfield = UITextField()
    let otpView = UIView()
    var isShowNewPassord = false
    var isShowConfirmPassord = false
    let viewModel = ProfileViewModel()
    var userId = Int()
    var familyMemberData = [FamilyMembersList]()

    override func viewDidLoad() {
        super.viewDidLoad()
       // getProfile()
        collectionview.register(UINib(nibName: "FamilyCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "FamilyCollectionViewCell")
        collectionview.dataSource = self
        collectionview.delegate = self
        
        
        setupUI()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
 //       viewModel.getUserProfileData()
        viewModel.fetchUserProfileSuccess = {
            DispatchQueue.main.async {
//                self.collectionview.reloadData()
                
               // self.userId = self.viewModel.userProfileDetails.userId
               
            }
            self.fetchFamilyMembers()
            
        }
        
        
        //dummy data
        
        
//        let myself = FamilyMembersList(name: "Mrs. Natasha", dob: "04-03-1960", memberId: 0, pId: 0, releation: "Self", title: "Mrs", nationalId: "", id_proof: "", paymentmethod: "", insurancename: "", insuranceno: "", insurancevalidity: "", insurancecardimage: "", mrnNo: "456878563", profile_pic: "")
//
//        let member1 = FamilyMembersList(name: "Mr. Mr. Johnsmith", dob: "18-08-1956", memberId: 0, pId: 0, releation: "Husband", title: "Mrs", nationalId: "", id_proof: "", paymentmethod: "", insurancename: "", insuranceno: "", insurancevalidity: "", insurancecardimage: "", mrnNo: "998878563", profile_pic: "")
//
//        let member2 = FamilyMembersList(name: "Mr. Johnathan", dob: "07-11-1985", memberId: 0, pId: 0, releation: "Son", title: "Mr", nationalId: "", id_proof: "", paymentmethod: "", insurancename: "", insuranceno: "", insurancevalidity: "", insurancecardimage: "", mrnNo: "678878563", profile_pic: "")

        
        let myself = FamilyMembersList(full_name: "Johnsmith", relation: "Husband", dob: "18-08-1956", mrn: "99884556", national_id: "5566225", id: "1")
        let member1 = FamilyMembersList(full_name: "Mrs. Natasha", relation: "Husband", dob: "18-08-1956", mrn: "99884556", national_id: "5566225", id: "1")
        let member2 = FamilyMembersList(full_name: "Mr. Johnathan", relation: "Husband", dob: "18-08-1956", mrn: "99884556", national_id: "5566225", id: "1")
        
        familyMemberData = [myself,member1,member2]
    }
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "vip")
        {
            Vipview()
        }
    }
    func Vipview()
    {
        bgView.backgroundColor = UIColor.black
        container.backgroundColor = UIColor.black
        headerView.backgroundColor = UIColor.black
        titleLabel.textColor = UIColor.white
        personalInfoHeadLabel.textColor = UIColor.white
        emailLabel.textColor = UIColor.white
        phoneLabel.textColor = UIColor.white
        nameLabel.textColor = UIColor.white
        passwordLabel.textColor = UIColor.white
        passwordHeadLabel.textColor = UIColor(named: "vip")
        familyMembersHeadLabel.textColor = UIColor(named: "vip")
        viewAllButton.setTitleColor(UIColor.white, for: .normal)
        mrnIDHeadLabel.textColor = UIColor(named: "vip")
        firstnameHeadLabel.textColor = UIColor(named:"vip")
        mobileHeadLabel.textColor = UIColor(named:"vip" )
        emailHeadLabel.textColor = UIColor(named:"vip")
    }
    func fetchFamilyMembers(){
        //viewModel.fetchFamilyMember()
        viewModel.fetchFamilySuccess = {
            self.familyMemberData = self.viewModel.familyMemberData ?? []
            DispatchQueue.main.async {
                self.collectionview.reloadData()
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
    override func viewWillAppear(_ animated: Bool) {
    }

    @IBAction func changeImageAction(_ sender: UIButton)
    {
        self.imagePicker.present(from: sender)
    }

    @IBAction func editProfileAction(_ sender: Any) {
        //saveButton.isHidden = false
        changePicButton.isHidden = false
        let storyboard = UIStoryboard(name: "Modified", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "EditPersonalInformationViewController") as! EditPersonalInformationViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    @IBAction func changePasswordAction(_ sender: Any)
    {
        //sendChangePasswordOTP()
        let storyboard = UIStoryboard(name: "Modified", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "OTPPopUpViewController") as! OTPPopUpViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    @IBAction func editFamilyAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Modified", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "FamilyMemberViewController") as! FamilyMemberViewController
        vc.userId = userId
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
//    @IBAction func saveAction(_ sender: Any) {
//        guard let firstName = firstName.text,let lastName = lastName.text,let email = email.text,let emiratesId = emiratesID.text,let mrn = mrnID.text,let dob = dob.text,let state = stateCity.text else {
//             return
//         }
//
//         if firstName == ""{
//             self.showAlert("Please enter first name")
//             return
//         }
//         if lastName == ""{
//             self.showAlert("Please enter last name")
//             return
//         }
//         if email == ""{
//             self.showAlert("Please enter email")
//             return
//         }
//
//        if dob == ""{
//            self.showAlert("Please select dob")
//            return
//        }
//
//        if state == ""{
//            self.showAlert("Please enter your state/city")
//            return
//        }
////         if emiratesId == ""{
////             self.showAlert("Please select doctor")
////             return
////         }
//         if mrn == ""{
//             self.showAlert("Please enter MRN ID")
//             return
//         }
//
//        let params = [
//        "dob": dob,
//        "emiratesId": emiratesId,
//        "firstName": firstName,
//        "lastName": lastName,
//        "mailAddress": email,
//        "mrnNo": mrn,
//        "state_city": state,
//        "userId": userId
//            ] as [String : Any]
//         updateProfile(params: params)
//    }
//
//    @objc func changePassword(){
//        if confirmTextfield.text?.count ?? 0 > 7{
//            if confirmTextfield.text == newTextfield.text{
//                submitNewPassword()
//            }else{
//                self.showAlert("Password mis match")
//            }
//        }else{
//            self.showAlert("Password must have minimum 8 characters")
//        }
//    }
    @objc func doneAction(){
        blurView.removeFromSuperview()
        passwordSuccess.removeFromSuperview()
    }
//    func fetchFamilyMembers(){
//        viewModel.fetchFamilyMember(userId: userId)
//
//    }
    func didSelect(image: String?) {
        let imgData = Data(base64Encoded: image!, options: .ignoreUnknownCharacters)
//        self.activityIndicator(self.view, startAnimate: true)
//        viewModel.updateProfileImage(userId: userId, params: ["profile_pic":image ?? ""])
//        viewModel.updateImageSuccess = {
            DispatchQueue.main.async {
                self.profileImage.image = UIImage(data: imgData!)
            }
//        }
    }
    func updateProfile(params:[String:Any]){
        self.activityIndicator(self.view, startAnimate: true)
        viewModel.updateProfile(params: params)
        viewModel.updateSuccess = {
            let realm = try! Realm()
//            let userData = realm.objects(LoginUserDataRealm.self)
            let profileDetails = realm.object(ofType: LoginUserDataRealm.self, forPrimaryKey: self.userId)
//            if let profileDetails = userData.first {
                try! realm.write {
//                    realm.create(LoginUserDataRealm.self, value: ["mrnNo":self.mrnID.text], update: .all)
//                    profileDetails?.dob = self.dob.text
//                    profileDetails?.emiratesId = self.emiratesID.text
//                    profileDetails?.firstName = self.firstName.text ?? ""
//                    profileDetails?.lastName = self.lastName.text ?? ""
//                    profileDetails?.mrnNo = self.mrnID.text
//                    profileDetails?.state_city = self.stateCity.text
//                    profileDetails?.mailAddress = self.email.text ?? ""
                }
//            }
            self.showAlert("Profile updated successfully")
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
    
    func sendChangePasswordOTP()
    {
        let params = [
            "mobileNo": "987456212",
            "userId": userId] as [String : Any]
        self.activityIndicator(self.view, startAnimate: true)
        viewModel.sendOTP(params: params)
        viewModel.otpSendSuccess = {
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let vc = storyboard.instantiateViewController(withIdentifier: "OTPPopUpViewController") as! OTPPopUpViewController
            vc.modalPresentationStyle = .overCurrentContext
            vc.delegate = self
            self.present(vc, animated: true)
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
            self.showAlert(self.viewModel.errorMessage ?? "")
        }
    }
    func verifyOTP(otp:String){
        let params = [
            "otp":otp,
            "userId": userId] as [String : Any]
        self.activityIndicator(self.view, startAnimate: true)
        viewModel.verifyOTP(params: params)
        viewModel.otpVerifySuccess = {
            //self.createBlurView()
            self.createChangePasswordView()
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
    func submitNewPassword(){
        let params = [
            "password": newTextfield.text!,
            "userId": userId] as [String : Any]
        self.activityIndicator(self.view, startAnimate: true)
        viewModel.setNewPassword(params: params)
        viewModel.passwordChangeSuccess = {
            self.changePasswordView.removeFromSuperview()
            self.createSuccessView()
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
    func getProfile(){
        self.activityIndicator(self.view, startAnimate: true)
        viewModel.getProfile()
        viewModel.getProfileDetailsSuccess =
        {
            let name = self.viewModel.userProfiledetails?.full_name
            let mail = self.viewModel.userProfiledetails?.mail_address
            let phone = self.viewModel.userProfiledetails?.mobile
            let mrnID = self.viewModel.userProfiledetails?.mrn
            
            self.nameLabel.text = name
            self.emailLabel.text = mail
            self.phoneLabel.text = phone
            self.MrnLabel.text = mrnID
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
            self.showAlert(self.viewModel.errorMessage ?? "Error in Loading details")
        }
    }
    
    
}



extension ProfileViewController:DatePickerDelegate,OTPPopUpDelegate{
    func getOTPtext(otp: String) {
        if otp.count == 6{
            self.dismiss(animated: true, completion: nil)
            verifyOTP(otp: otp)
        }
    }
    
    func selectedDate(date: String) {
       // dob.text = date
    }
    
    func cancelDateSelection() {
        
    }
    
    func setupUI(){
        container.createBorderForView(cornerRadius: 30, borderWidth: 0, borderColor: .clear)
        container.clipsToBounds = true
//        firstName.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
//        lastName.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
//        email.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
//        mobileNumber.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
//        emiratesID.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
//        mrnID.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
//        saveButton.createBorderForButton(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
//        dob.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
//        stateCity.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
//
//        dob.delegate = self
//        saveButton.isHidden = true
        changePicButton.isHidden = false
        profileImage.layer.cornerRadius = 29
        container.layer.borderColor = UIColor.lightGray.cgColor
        container.layer.borderWidth = 0.4
        container.layer.masksToBounds = false
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        container.layer.shadowOpacity = 0.2
        changePicBgView.layer.cornerRadius = 10
    }
    //Create Blur background
//    func createBlurView(){
//        blurView.translatesAutoresizingMaskIntoConstraints = false
//        blurView.backgroundColor = UIColor(red: 28.0/255.0, green: 29.0/255.0, blue: 48.0/255, alpha: 0.8)
//        //        blurView.alpha = 0.8
//        view.addSubview(blurView)
//        blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        blurView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        blurView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8).isActive = true
//        blurView.isUserInteractionEnabled = true
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(closePopUp))
//        blurView.addGestureRecognizer(gesture)
//    }
    @objc func closePopUp(){
        
    }
    
    //Password change Success POPUP view
    func createSuccessView(){
        //createBlurView()
        passwordSuccess.layer.cornerRadius = 30
        passwordSuccess.backgroundColor = UIColor(hexString: "#fbfbfb")
        view.addSubview(passwordSuccess)
        
        passwordSuccess.translatesAutoresizingMaskIntoConstraints = false
        passwordSuccess.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        passwordSuccess.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        passwordSuccess.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        let doneButton = UIButton()
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.backgroundColor = UIColor(hexString: Colors.buttonColor)
        doneButton.titleLabel?.font =  UIFont.systemFont(ofSize: 14, weight: .bold)
        doneButton.addTarget(self, action: #selector(doneAction), for: .touchUpInside)
        doneButton.layer.cornerRadius = 10
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        passwordSuccess.addSubview(doneButton)
        doneButton.leadingAnchor.constraint(equalTo: passwordSuccess.leadingAnchor,constant: 30).isActive = true
        doneButton.trailingAnchor.constraint(equalTo: passwordSuccess.trailingAnchor,constant: -30).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: passwordSuccess.bottomAnchor,constant: -20).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        let label = UILabel()
        label.text = "Password has been changed successfully"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = UIColor(hexString: "#35373a")
        label.textAlignment = .center
        //        label.backgroundColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        passwordSuccess.addSubview(label)
        label.leadingAnchor.constraint(equalTo: passwordSuccess.leadingAnchor,constant: 30).isActive = true
        label.trailingAnchor.constraint(equalTo: passwordSuccess.trailingAnchor,constant: -30).isActive = true
        label.bottomAnchor.constraint(equalTo: doneButton.topAnchor,constant: -40).isActive = true
        
        let successLabel = UILabel()
        successLabel.text = "Success"
        successLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
        successLabel.textAlignment = .center
        //        successLabel.backgroundColor = UIColor.gray
        successLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordSuccess.addSubview(successLabel)
        successLabel.leadingAnchor.constraint(equalTo: passwordSuccess.leadingAnchor,constant: 30).isActive = true
        successLabel.trailingAnchor.constraint(equalTo: passwordSuccess.trailingAnchor,constant: -30).isActive = true
        successLabel.bottomAnchor.constraint(equalTo: label.topAnchor,constant: -20).isActive = true
        
        let icon = UIImageView()
        //        successLabel.font = UIFont(
        icon.image = UIImage(named: "bookedSuccess")
        icon.translatesAutoresizingMaskIntoConstraints = false
        passwordSuccess.addSubview(icon)
        icon.backgroundColor = UIColor.white
        icon.widthAnchor.constraint(equalToConstant: 60).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 60).isActive = true
        icon.centerXAnchor.constraint(equalTo: passwordSuccess.centerXAnchor, constant: 0).isActive = true
        icon.bottomAnchor.constraint(equalTo: successLabel.topAnchor,constant: -20).isActive = true
        icon.topAnchor.constraint(equalTo: passwordSuccess.topAnchor,constant: 30).isActive = true
    }
    func addShowPasswordButton(textField:UITextField,imageName:String){
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -35, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(textField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        if textField == newTextfield{
            button.addTarget(self, action: #selector(showNewPasswordAction), for: .touchUpInside)
        }else{
            button.addTarget(self, action: #selector(showConfirmPasswordAction), for: .touchUpInside)
        }
        textField.rightView = button
        textField.rightViewMode = .always
        
    }
    @objc func showNewPasswordAction() {
        newTextfield.isSecureTextEntry = isShowNewPassord ? true : false
        isShowNewPassord = !isShowNewPassord
    }
    @objc func showConfirmPasswordAction() {
        confirmTextfield.isSecureTextEntry = isShowConfirmPassord ? true : false
        isShowConfirmPassord = !isShowConfirmPassord
    }
    
    
    //Password change Success POPUP view
    func createChangePasswordView(){
        //createBlurView()
        changePasswordView.layer.cornerRadius = 30
        changePasswordView.backgroundColor = UIColor.white
        view.addSubview(changePasswordView)
        changePasswordView.translatesAutoresizingMaskIntoConstraints = false
        changePasswordView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        changePasswordView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        changePasswordView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        let doneButton = UIButton()
        doneButton.setTitle("Submit", for: .normal)
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.backgroundColor = UIColor(hexString: "#777EDC")
        //doneButton.addTarget(self, action: #selector(changePassword), for: .touchUpInside)
        doneButton.layer.cornerRadius = 10
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        changePasswordView.addSubview(doneButton)
        doneButton.leadingAnchor.constraint(equalTo: changePasswordView.leadingAnchor,constant: 30).isActive = true
        doneButton.trailingAnchor.constraint(equalTo: changePasswordView.trailingAnchor,constant: -30).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: changePasswordView.bottomAnchor,constant: -20).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        confirmTextfield.isSecureTextEntry = true
        confirmTextfield.addPaddingAndBorder(to: confirmTextfield)
        confirmTextfield.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        confirmTextfield.backgroundColor = UIColor(hexString: "#F3F3F6")
        confirmTextfield.translatesAutoresizingMaskIntoConstraints = false
        confirmTextfield.textColor = UIColor(hexString: Colors.labelBlack)
        changePasswordView.addSubview(confirmTextfield)
        confirmTextfield.leadingAnchor.constraint(equalTo: changePasswordView.leadingAnchor,constant: 30).isActive = true
        confirmTextfield.trailingAnchor.constraint(equalTo: changePasswordView.trailingAnchor,constant: -30).isActive = true
        confirmTextfield.bottomAnchor.constraint(equalTo: doneButton.topAnchor,constant: -20).isActive = true
        confirmTextfield.heightAnchor.constraint(equalToConstant: 46).isActive = true
        addShowPasswordButton(textField: confirmTextfield, imageName: "visibilityOrEyeIcon")
        let confirmLabel = UILabel()
        confirmLabel.text = "Confirm Password"
        confirmLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        confirmLabel.translatesAutoresizingMaskIntoConstraints = false
        confirmLabel.textColor = UIColor.black
        changePasswordView.addSubview(confirmLabel)
        confirmLabel.leadingAnchor.constraint(equalTo: changePasswordView.leadingAnchor,constant: 30).isActive = true
        confirmLabel.trailingAnchor.constraint(equalTo: changePasswordView.trailingAnchor,constant: -30).isActive = true
        confirmLabel.bottomAnchor.constraint(equalTo: confirmTextfield.topAnchor,constant: -10).isActive = true
        
        newTextfield.addPaddingAndBorder(to: newTextfield)
        newTextfield.createBorderForTextfield(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        newTextfield.isSecureTextEntry = true
        newTextfield.backgroundColor = UIColor(hexString: "#F3F3F6")
        newTextfield.translatesAutoresizingMaskIntoConstraints = false
        newTextfield.textColor = UIColor(hexString: Colors.labelBlack)
        changePasswordView.addSubview(newTextfield)
        newTextfield.leadingAnchor.constraint(equalTo: changePasswordView.leadingAnchor,constant: 30).isActive = true
        newTextfield.trailingAnchor.constraint(equalTo: changePasswordView.trailingAnchor,constant: -30).isActive = true
        newTextfield.bottomAnchor.constraint(equalTo: confirmLabel.topAnchor,constant: -10).isActive = true
        newTextfield.heightAnchor.constraint(equalToConstant: 46).isActive = true
        addShowPasswordButton(textField: newTextfield, imageName: "visibilityOrEyeIcon")
        
        let newPasswordLabel = UILabel()
        newPasswordLabel.text = "New Password"
        newPasswordLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        newPasswordLabel.textColor = UIColor.black
        newPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        changePasswordView.addSubview(newPasswordLabel)
        newPasswordLabel.leadingAnchor.constraint(equalTo: changePasswordView.leadingAnchor,constant: 30).isActive = true
        newPasswordLabel.trailingAnchor.constraint(equalTo: changePasswordView.trailingAnchor,constant: -30).isActive = true
        newPasswordLabel.bottomAnchor.constraint(equalTo: newTextfield.topAnchor,constant: -10).isActive = true
        
        let line = UIView()
        //        successLabel.font = UIFont(
        line.translatesAutoresizingMaskIntoConstraints = false
        changePasswordView.addSubview(line)
        line.backgroundColor = UIColor.lightGray
        line.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        line.bottomAnchor.constraint(equalTo: newPasswordLabel.topAnchor,constant: -20).isActive = true
        line.leadingAnchor.constraint(equalTo: changePasswordView.leadingAnchor,constant: 15).isActive = true
        line.trailingAnchor.constraint(equalTo: changePasswordView.trailingAnchor,constant: -10).isActive = true
        //        icon.topAnchor.constraint(equalTo: passwordSuccess.topAnchor,constant: 30).isActive = true
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        titleLabel.text = "Change Password"
        //        successLabel.font = UIFont(
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor(hexString: Colors.labelBlack)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        changePasswordView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: changePasswordView.leadingAnchor,constant: 30).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: changePasswordView.trailingAnchor,constant: -30).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: line.topAnchor,constant: -10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: changePasswordView.topAnchor,constant: 15).isActive = true
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if textField == dob{
//            textField.resignFirstResponder()
//            let storyboard = UIStoryboard(name: "Main", bundle: .main)
//            let popup = storyboard.instantiateViewController(withIdentifier: "DatePickerViewController") as! DatePickerViewController
//            popup.isTimePicker = false
//            popup.modalPresentationStyle = .overCurrentContext
//            popup.delegate = self
//            present(popup, animated: true, completion: nil)
//        }
//    }
    
    //Password change Success POPUP view
    
    func addBottomBorder(view:UIView){
        let border = UIView()
        border.backgroundColor = UIColor(hexString: "#d8d8d8")
        border.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(border)
        border.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        border.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        border.trailingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        border.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        border.heightAnchor.constraint(equalToConstant: 2.0).isActive = true
    }
    
    
    @objc func textFieldDidChange(textField: UITextField){
        
        let text = textField.text
        
        if (text?.count)! >= 1{
            textField.viewWithTag(1)?.resignFirstResponder()
            textField.superview?.viewWithTag(4)?.becomeFirstResponder()
            
            //            switch textField.tag{
            //            case 1:
            //                textField.viewWithTag(1)?.resignFirstResponder()
            //                textField.viewWithTag(2)?.becomeFirstResponder()
            //            case 2:
            //                textField.viewWithTag(2)?.becomeFirstResponder()
            //            case 3:
            //                textField.viewWithTag(3)?.becomeFirstResponder()
            //            case 4:
            //                textField.viewWithTag(4)?.becomeFirstResponder()
            //            default:
            //                break
            //            }
        }else{
            
        }
    }
    
}


extension ProfileViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
       // return viewModel.familyMemberData?.count ?? 0
        return familyMemberData.count+2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FamilyCollectionViewCell", for: indexPath) as! FamilyCollectionViewCell
        let users = ["person1","person2","person3","person"]
        if indexPath.row == 4
        {
            cell.memberImage.image = UIImage(named: "add")
            cell.height.constant = 20
            cell.width.constant = 20
        }
        else
        {
            cell.memberImage.image = UIImage(named:users[indexPath.row])
            cell.memberImage.layer.cornerRadius = 15
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.row == 4)
        {
            let storyboard = UIStoryboard(name: "Modified", bundle: .main)
            let vc = storyboard.instantiateViewController(withIdentifier: "AddNewMemberViewController") as! AddNewMemberViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
    
}
