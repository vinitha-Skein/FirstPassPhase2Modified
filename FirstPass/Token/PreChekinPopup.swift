//
//  PreChekinPopup.swift
//  Popup
//
//  Created by SkeinTechnologies on 31/12/20.
//

import UIKit

class PreChekinPopup: UIViewController {
    
    @IBOutlet weak var sectionView2: UIView!
    @IBOutlet weak var sectionView3: UIView!
    @IBOutlet weak var carParkingYesView: UIView!
    @IBOutlet weak var specialAssistanceyesView: UIView!
    @IBOutlet weak var specialAssistanceNoView: UIView!
    @IBOutlet weak var vipserviceYesView: UIView!
    @IBOutlet weak var concergePreferenceYesView: UIView!
    @IBOutlet weak var concergePreferenceNoView: UIView!
    
    @IBOutlet weak var vipservicesNoView: UIView!
    @IBOutlet weak var carParkingNoView: UIView!
    
    
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var carParkingYesLabel: UILabel!
    @IBOutlet weak var parkingNoLabel: UILabel!
    @IBOutlet weak var specialAssistanceYesLabel: UILabel!
    
    @IBOutlet weak var specialAssistanceNoLabel: UILabel!
    
    @IBOutlet weak var conciergeArabic: UILabel!
    @IBOutlet weak var conciergeEnglish: UILabel!
    @IBOutlet weak var conciergeFemale: UILabel!
    @IBOutlet weak var conciergeMale: UILabel!
    @IBOutlet weak var vipNoLabel: UILabel!
    @IBOutlet weak var vipYesLabel: UILabel!
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var carPlate: UIView!
    
    
    @IBOutlet weak var caarparking: NSLayoutConstraint!
    
    @IBOutlet weak var vipService: NSLayoutConstraint!
    
    @IBOutlet weak var carparkingView: UIView!
    @IBOutlet weak var convergePreference: UIView!
    @IBOutlet weak var convergeLanguage: UIView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var parkingYes: UIImageView!
    @IBOutlet weak var parkingNo: UIImageView!
    @IBOutlet weak var specialAssistanceYes: UIImageView!
    @IBOutlet weak var specialAssistanceNo: UIImageView!
    @IBOutlet weak var vipServiceYes: UIImageView!
    @IBOutlet weak var vipServiceNo: UIImageView!
    @IBOutlet weak var conciergeMaleImg: UIImageView!
    
    @IBOutlet weak var conciergeArabicImg: UIImageView!
    @IBOutlet weak var conciergeFemaleImg: UIImageView!
    @IBOutlet weak var conciergeEnglishImg: UIImageView!
    @IBOutlet weak var vipPreServiceYes: UIImageView!
     @IBOutlet weak var vipPreServiceNo: UIImageView!
    
    @IBOutlet weak var vipLanServiceYes: UIImageView!
     @IBOutlet weak var vipLanServiceNo: UIImageView!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    var highlightedcolor = UIColor(red: 54/255, green: 59/255, blue: 68/255, alpha: 1)
    var defaultColor = UIColor(red: 114/255, green: 118/255, blue: 128/255, alpha: 1)
    var buttonColor = UIColor(red: 233/255, green: 134/255, blue: 0/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } 
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        scrollView.layer.cornerRadius = 25
        container.layer.cornerRadius = 25
        container.layer.borderWidth = 0.4
        container.layer.borderColor = UIColor.gray.cgColor
        container.layer.masksToBounds = false
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        container.layer.shadowOpacity = 0.2
        submitButton.layer.cornerRadius = 8
        
        cancelButton.createBorderForButton(cornerRadius: 8, borderWidth: 1, borderColor: buttonColor)
        carParkingYesLabel.textColor = highlightedcolor
        parkingNoLabel.textColor = defaultColor
        specialAssistanceYesLabel.textColor = highlightedcolor
        specialAssistanceNoLabel.textColor = defaultColor
        vipYesLabel.textColor = highlightedcolor
        vipNoLabel.textColor = defaultColor
        conciergeMale.textColor = highlightedcolor
        conciergeFemale.textColor = defaultColor
        conciergeEnglish.textColor = highlightedcolor
        conciergeArabic.textColor = defaultColor
        
        
        if UserDefaults.standard.bool(forKey: "vip")
        {
            vipView()
        }
        // Do any additional setup after loading the view.
    }
    
    
    func vipView()
    {
        
        convergeLanguage.backgroundColor = UIColor.black
        convergePreference.backgroundColor = UIColor.black
        sectionView2.backgroundColor = UIColor.black
        sectionView3.backgroundColor = UIColor.black
        carparkingView.backgroundColor = UIColor.black
        carPlate.backgroundColor = UIColor.black
    }
    @IBAction func radioButtonYes(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            parkingYes.image = UIImage(named: "radioSelected")
            parkingNo.image = UIImage(named: "radioDeselected")
            carPlate.isHidden=false;
            caarparking.constant=200;
            carParkingYesLabel.textColor = highlightedcolor
            parkingNoLabel.textColor = defaultColor
            
        case 2:
            specialAssistanceYes.image = UIImage(named: "radioSelected")
            specialAssistanceNo.image = UIImage(named: "radioDeselected")
            specialAssistanceYesLabel.textColor = highlightedcolor
            specialAssistanceNoLabel.textColor = defaultColor
        case 3:
            vipServiceYes.image = UIImage(named: "radioSelected")
            vipServiceNo.image = UIImage(named: "radioDeselected")
            vipYesLabel.textColor = highlightedcolor
            vipNoLabel.textColor = defaultColor
            convergePreference.isHidden=false;
            convergeLanguage.isHidden=false;
            vipService.constant = 270;
        case 4:
            conciergeMaleImg.image = UIImage(named: "radioSelected")
            conciergeFemaleImg.image = UIImage(named: "radioDeselected")
            conciergeMale.textColor = highlightedcolor
            conciergeFemale.textColor = defaultColor
        default:
            conciergeEnglishImg.image = UIImage(named: "radioSelected")
            conciergeArabicImg.image = UIImage(named: "radioDeselected")
            conciergeEnglish.textColor = highlightedcolor
            conciergeArabic.textColor = defaultColor
        }
    }
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func radioButtonNo(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            parkingYes.image = UIImage(named: "radioDeselected")
            parkingNo.image = UIImage(named: "radioSelected")
             carPlate.isHidden=true;
             caarparking.constant=110;
            carParkingYesLabel.textColor = defaultColor
            parkingNoLabel.textColor = highlightedcolor
        case 2:
            specialAssistanceYes.image = UIImage(named: "radioDeselected")
            specialAssistanceNo.image = UIImage(named: "radioSelected")
            specialAssistanceYesLabel.textColor = defaultColor
            specialAssistanceNoLabel.textColor = highlightedcolor
        case 3:
            vipServiceYes.image = UIImage(named: "radioDeselected")
            vipServiceNo.image = UIImage(named: "radioSelected")
            vipYesLabel.textColor = defaultColor
            vipNoLabel.textColor = highlightedcolor
            convergePreference.isHidden=true;
            convergeLanguage.isHidden=true;
            vipService.constant = 110;
        case 4:
            conciergeMaleImg.image = UIImage(named: "radioDeselected")
            conciergeFemaleImg.image = UIImage(named: "radioSelected")
            conciergeMale.textColor = defaultColor
            conciergeFemale.textColor = highlightedcolor
        default :
            conciergeEnglishImg.image = UIImage(named: "radioDeselected")
            conciergeArabicImg.image = UIImage(named: "radioSelected")
            conciergeEnglish.textColor = defaultColor
            conciergeArabic.textColor = highlightedcolor


        }

    }
    @IBAction func submitAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
