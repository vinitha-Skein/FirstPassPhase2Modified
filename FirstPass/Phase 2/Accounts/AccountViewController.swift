//
//  AccountViewController.swift
//  FirstPass
//
//  Created by Skeintech on 08/06/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet var notificationButton: UIButton!
    @IBOutlet var scannerButton: UIButton!
    @IBOutlet var bgView: UIView!
    @IBOutlet var container: UIView!
    @IBOutlet weak var bottomMenuView: Tabbar!
    @IBOutlet weak var collectionview: UICollectionView!
    var categories = ["My Profile","My Appointments","Book Appointment","Payments","Reports","Indoor Map","Contact","About Hospital","Location Search","BMI Calculator","Chat with Us","Doctor Lookup","Special Offers","Logout"]
    var logoImages = ["accountpic","appointments","book","payments","reports","map","Contact","abouthospital","locationsearch","bms","chat","doctorlookup","specialofferoffer","logout"]
    var vipImages = ["Group 6910","Group 6911","Group 6912","Group 6913","Group 6914","Group 6915","contact","about-hospital","location-search","bmi-calculater","Group 6916","doctor-lookup","special-offers","Group 6917"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionview.delegate = self
        collectionview.dataSource = self
        bottomMenuView.delegate = self
        
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool)
    {
        if UserDefaults.standard.bool(forKey: "vip")
        {
            bgView.backgroundColor = UIColor.black
            container.backgroundColor = UIColor.black
            collectionview.backgroundColor = UIColor.black
            notificationButton.setImage(UIImage(named: "notificationvip"), for: .normal)
            scannerButton.setImage(UIImage(named: "vipscanner"), for: .normal)
        }
    }
    @IBAction func notification_Clicked(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Modified", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AlertNotificationViewController") as! AlertNotificationViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func Scanner_Clicked(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Modified", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ScannerViewController") as! ScannerViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    

}
extension AccountViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AccountCollectionViewCell", for: indexPath) as! AccountCollectionViewCell
        
        if UserDefaults.standard.bool(forKey: "vip")
        {
            print("vip entered")
            cell.categoryLabel.text = categories[indexPath.row]
            cell.logoImage.image = UIImage(named: vipImages[indexPath.row])
            cell.bgView.layer.cornerRadius = 15
            cell.container.layer.cornerRadius = 20
            cell.container.layer.borderWidth = 0.2
            cell.container.layer.borderColor = UIColor.lightGray.cgColor
            cell.container.layer.masksToBounds = false
            cell.container.layer.shadowColor = UIColor.lightGray.cgColor
            cell.container.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            cell.container.layer.shadowOpacity = 0.2
            cell.container.backgroundColor = UIColor(named: "vip")
            cell.bgView.isHidden = true
            cell.imageHeight.constant = 48
            cell.imageWidth.constant = 48
        }
        else
        {
            cell.categoryLabel.text = categories[indexPath.row]
            cell.logoImage.image = UIImage(named: logoImages[indexPath.row])
            cell.bgView.layer.cornerRadius = 15
            cell.container.layer.cornerRadius = 20
            cell.container.layer.borderWidth = 0.2
            cell.container.layer.borderColor = UIColor.lightGray.cgColor
            cell.container.layer.masksToBounds = false
            cell.container.layer.shadowColor = UIColor.lightGray.cgColor
            cell.container.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            cell.container.layer.shadowOpacity = 0.2
        }
        
        
        

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionview.frame.width/2)-16
        
        return  CGSize(width: 156, height: 146)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if (indexPath.row == 0)
        {
            let storyboard = UIStoryboard(name: "Modified", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
        if (indexPath.row == 1)
        {
            let storyboard = UIStoryboard(name: "phase2", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MyAppointmentsViewController") as! MyAppointmentsViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
        if (indexPath.row == 2)
        {
            let storyboard = UIStoryboard(name: "Modified", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "BookAppointmentViewController") as! BookAppointmentViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
        
        if (indexPath.row == 3)
        {
            let storyboard = UIStoryboard(name: "phase2", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PaymentOptionsViewController") as! PaymentOptionsViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
        if (indexPath.row == 4)
        {
            let storyboard = UIStoryboard(name: "Modified", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ReportsViewController") as! ReportsViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
        if (indexPath.row == 5)
        {
            let storyboard = UIStoryboard(name: "Modified", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "IndoorMapViewController") as! IndoorMapViewController
            vc.modalPresentationStyle = .fullScreen

            present(vc, animated: true, completion: nil)
        }
        if (indexPath.row == 6)
        {
            let storyboard = UIStoryboard(name: "Modified", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ContactsViewController") as! ContactsViewController
            vc.modalPresentationStyle = .fullScreen

            present(vc, animated: true, completion: nil)
        }
        if (indexPath.row == 7)
        {
            let storyboard = UIStoryboard(name: "phase2", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "AboutHospitalViewController") as! AboutHospitalViewController
            vc.modalPresentationStyle = .fullScreen

            present(vc, animated: true, completion: nil)
        }
        if (indexPath.row == 8)
        {
//            let storyboard = UIStoryboard(name: "Modified", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "ProcessFeedbackViewController") as! ProcessFeedbackViewController
//            UserDefaults.standard.set(false, forKey: "isLoggedIn")
//            vc.modalPresentationStyle = .fullScreen
//            present(vc, animated: true, completion: nil)

            let latitude = "25.284903"
            let longitude = "55.321512"
            if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
                 UIApplication.shared.open(URL(string:"comgooglemaps://?center=\(latitude),\(longitude)&zoom=14&views=traffic&q=\(latitude),\(longitude)")!, options: [:], completionHandler: nil)
             } else {
                 UIApplication.shared.open(URL(string: "http://maps.google.com/maps?q=loc:\(latitude),\(longitude)&zoom=14&views=traffic&q=\(latitude),\(longitude)")!, options: [:], completionHandler: nil)
             }
        }
        if (indexPath.row == 9)
        {
            let storyboard = UIStoryboard(name: "Modified", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "BMICalculatorViewController") as! BMICalculatorViewController
            vc.modalPresentationStyle = .fullScreen

            present(vc, animated: true, completion: nil)
        }
        if (indexPath.row == 10)
        {
//            let storyboard = UIStoryboard(name: "phase2", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "ChatwithusViewController") as! ChatwithusViewController
//            UserDefaults.standard.set(false, forKey: "isLoggedIn")
//            vc.modalPresentationStyle = .fullScreen
//
//            present(vc, animated: true, completion: nil)
            openWhatsapp()
        }
        if (indexPath.row == 11)
        {
            let storyboard = UIStoryboard(name: "Modified", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "DoctorLookupViewController") as!  DoctorLookupViewController
            vc.modalPresentationStyle = .fullScreen

            present(vc, animated: true, completion: nil)
        }
        if (indexPath.row == 12)
        {
            let storyboard = UIStoryboard(name: "phase2", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SpecialOffersViewController") as! SpecialOffersViewController
            vc.modalPresentationStyle = .fullScreen

            present(vc, animated: true, completion: nil)
        }
        if (indexPath.row == 13)
        {
            
            
            let alert = UIAlertController(title: "Firstpass", message: "Are you sure to Logout?", preferredStyle: UIAlertController.Style.alert)

                alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { action in
                
                let storyboard = UIStoryboard(name: "Modified", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                UserDefaults.standard.set(false, forKey: "isLoggedIn")
                vc.modalPresentationStyle = .fullScreen

                    self.present(vc, animated: true, completion: nil)

            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
       
       
       
        
        
     
//        if (indexPath.row == 1)
//        {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "SwapTestPopup") as! SwapTestPopup
//            vc.modalPresentationStyle = .fullScreen
//            present(vc, animated: true, completion: nil)
//        }

        
    }
}
extension AccountViewController:BottomViewDelegate
{
    func AccountsClicked()
    {
        
    }
    
    func AppointmentsClicked() {
        let storyboard = UIStoryboard(name: "phase2", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func VideCallClicked() {
        
    }
    
    func openWhatsapp(){
        if let url = URL(string: "https://api.whatsapp.com/send/?phone=971507729048&text&app_absent=0") {
                if UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }
    }
}
