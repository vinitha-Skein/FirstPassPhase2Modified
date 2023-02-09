//
//  DoctorDetailsViewController.swift
//  FirstPass
//
//  Created by MacOS on 24/11/22.
//  Copyright © 2022 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class DoctorDetailsViewController: UIViewController {

    let names = ["Dr. Ali Razzak","Dr. Hena Kalam","Dr. Hasan Alogaily","Dr. Eleanor Mccarthy"]
    var department = ["Family Medicine","OBGYN","Family Medicine","Family Medicine"]
    let studies = ["MBBS, BSc, MRCGP","MD, MBBS","MBBS, MRCGP","MBCHB, MRCGP, DFSRH"]
    let yearQualified = ["2006","1999","2014","2005"]
    let specialInteret = ["• Men’s Health and Wellness\n• Acute (sudden onset) and Urgent Medical Conditions in all ages - illnesses such as Fever, Infections, Colds/Flu, Migraines/Headaches and Back Pain\n• Chronic Disease Management including High Blood Pressure, Thyroid Disorders, Diabetes, High Cholesterol, Asthma and COPD\n• Sexually Transmitted Infections\n• Depression, Anxiety and related Mental Health Conditions\n• Vaccinations\n• General Paediatrics\n• Executive Health Screening and Wellness Packages for Men and Women\n• Cosmetic Injectables – Botox and Fillers\n• Treatment of Skin Disorders – condition such as Acne, Eczema, Psoriasis, Skin and Nail Infections, Rashes, Warts, Cryotherapy of skin lesions","Women's health, Pregnancy and Deliveries, Gynaecology Minimal access Surgeries, Psycho-sexual health, Contraception, Women's Health.","Health Promotion, Wellness & Lifestyle advice for the whole family\nUrgent Medical Conditions, including Fever, Cough, Acute Ear & Throat Pain/Infections, Acute rashes, Headaches, Urological Infections\nMusculoskeletal Conditions, Injuries & Joint Pains\nChronic Disease Management, including Asthma, Hypertension, Diabetes, Cholesterol and Thyroid Disorders\nDepression & Anxiety\nGeneral Paediatrics\nAssessment and Management of Skin Conditions, including Eczema & Seborrheic Dermatitis, Psoriasis, Urticaria, Skin & Nail Infections, Rosacea","• Treating the whole family\n• Acute medical problems\n• Chronic Disease Management such as Diabetes, Hypertension, Hypothyroidism, Asthma\n• Women's health\n• Mental health"]
    let languages = ["English, Arabic","English, Urdu, Hindi"," English, Arabic","English"]
    var doctorImages = ["doctor1","doctor2","person2","person3","person4"]
    var index = 0
    
    @IBOutlet weak var doctorSpecialistLabel: UILabel!
    @IBOutlet weak var doctorImageview: MyImageView!
    
    @IBOutlet weak var doctorNameLabel: UILabel!
    
    @IBOutlet weak var degreeLabel: UILabel!
    
    @IBOutlet weak var yearQuailifiedLabel: UILabel!
    
    @IBOutlet weak var languageSpoken: UILabel!
    
    @IBOutlet weak var specialInterestLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doctorImageview.image = UIImage(named: doctorImages[index])
        doctorNameLabel.text = names[index]
        degreeLabel.text = studies[index]
        doctorSpecialistLabel.text = department[index]
        yearQuailifiedLabel.text = yearQualified[index]
        languageSpoken.text = languages[index]
        specialInterestLabel.text = specialInteret[index]
       
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func bookappintmetPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Modified", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BookAppointmentViewController") as! BookAppointmentViewController
        vc.isfrom = "DoctorLookup"
        vc.doctorName = names[index]
        vc.department_doctor = department[index]
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
