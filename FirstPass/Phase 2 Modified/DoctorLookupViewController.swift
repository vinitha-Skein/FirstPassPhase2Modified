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
    
    let names = ["Dr. Ali Razzak","Dr. Hena Kalam","Dr. Hasan Alogaily","Dr. Eleanor Mccarthy"]
    var department = ["Family Medicine","OBGYN","Family Medicine","Family Medicine"]
    var doctorImages = ["doctor1","doctor2","person2","person3","person4"]
    var doctorLinks = ["https://kingscollegehospitaldubai.com/dr/ali-razzak/","https://kingscollegehospitaldubai.com/dr/hena-firoza-kalam/","https://kingscollegehospitaldubai.com/dr/hasan-alogaily/","https://kingscollegehospitaldubai.com/dr/eleanor-mccarthy/"]
    
    @IBOutlet weak var PopUpView: UIView!
    
    @IBOutlet weak var doctorName: UILabel!
    
    @IBOutlet weak var doctorDetailsTextview: UITextView!
    var seletedDoctor = ""
    var selectedDepartment = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        doctorDetailsTextview.delegate = self
        
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
        PopUpView.isHidden = true
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
    
    @IBAction func closePopUpPressed(_ sender: Any) {
        PopUpView.isHidden = true
    }
    
    @IBAction func bookAppointmentPressed(_ sender: Any) {
        PopUpView.isHidden = true
        let storyboard = UIStoryboard(name: "Modified", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BookAppointmentViewController") as! BookAppointmentViewController
        vc.isfrom = "DoctorLookup"
        vc.doctorName = seletedDoctor
        vc.department_doctor = selectedDepartment
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
extension DoctorLookupViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "DoctorsLookupTableViewCell") as! DoctorsLookupTableViewCell
        cell.doctorImage.layer.cornerRadius = cell.doctorImage.frame.size.width/2
    
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
        
        cell.nameLabel.text = names[indexPath.row]
        cell.departmentLabel.text = department[indexPath.row]
        cell.doctorImage.image = UIImage(named: doctorImages[indexPath.row])
        doctorDetailsTextview.text = "See details on: \(doctorLinks[indexPath.row])"
        cell.container.layer.cornerRadius = 10
               
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        doctorName.text = "Doctor Name : \(names[indexPath.row])\n\n Specialist : \(department[indexPath.row])"
//        selectedDepartment = department[indexPath.row]
//        seletedDoctor = names[indexPath.row]
//        let linkUrl = doctorLinks[indexPath.row]
//        doctorDetailsTextview.hyperLink(originalText: "To Find out more details Click here", hyperLink: "Click here" , urlString: linkUrl)
//        PopUpView.isHidden = false
        
        let storyboard = UIStoryboard(name: "Modified", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DoctorDetailsViewController") as! DoctorDetailsViewController
        vc.index = indexPath.row
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
}

extension DoctorLookupViewController:UITextViewDelegate{
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
//        if (URL.absoluteString == linkUrl) {
            UIApplication.shared.open(URL) { (Bool) in

            }
//        }
        return false
    }
}


extension UITextView {


func hyperLink(originalText: String, hyperLink: String, urlString: String) {

    let style = NSMutableParagraphStyle()
    style.alignment = .left

    let attributedOriginalText = NSMutableAttributedString(string: originalText)
    let linkRange = attributedOriginalText.mutableString.range(of: hyperLink)
    let fullRange = NSMakeRange(0, attributedOriginalText.length)
    attributedOriginalText.addAttribute(NSAttributedString.Key.link, value: urlString, range: linkRange)
    attributedOriginalText.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: fullRange)
    attributedOriginalText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(hexString:"#363B44"), range: fullRange)
    attributedOriginalText.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 15), range: fullRange)

    self.linkTextAttributes = [
        kCTForegroundColorAttributeName: UIColor.blue,
        kCTUnderlineStyleAttributeName: NSUnderlineStyle.single.rawValue,
        ] as [NSAttributedString.Key : Any]

    self.attributedText = attributedOriginalText
}
    
}
