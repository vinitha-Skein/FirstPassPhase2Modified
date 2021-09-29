//
//  OnBoardViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 17/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit
import UICircularProgressRing

class OnBoardViewController: UIViewController {

    @IBOutlet weak var indicator1: UIView!
    @IBOutlet weak var indicator2: UIView!
    @IBOutlet weak var indicator3: UIView!
    @IBOutlet weak var nextButton: UIButton!
//    @IBOutlet weak var nextButtonWidth: NSLayoutConstraint!
//    @IBOutlet weak var bgTransparent: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var titleDescription: UILabel!

    @IBOutlet weak var circularProgress: UICircularProgressRing!
    
    var backgrounds = [UIImage(named: "background1"),UIImage(named: "background2"),UIImage(named: "background3")]
    var bgTransparents = [UIImage(named: "bg1Transparent"),UIImage(named: "bg2Transparent"),UIImage(named: "bg3Transparent")]
    var titleList = ["Worry less.","Get appointment.","Consult a Doctor."]
    var titleDesc = ["Etiam sem tortor, efficitur eu pharetra ut, et massa. Nam posuere tempus nis.","Etiam sem tortor, efficitur eu pharetra ut, et massa. Nam posuere tempus nis.","Etiam sem tortor, efficitur eu pharetra ut, et massa. Nam posuere tempus nis."]
    var index = 0
    var selectedColor = UIColor(red: 233.0/255.0, green: 134.0/255.0, blue: 0.0/155.0, alpha: 1.0)
    var unSelectedColor = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/155.0, alpha: 1.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    @IBAction func nextAction(_ sender: Any) {
        index += 1
        switch index {
        case 1:
            indicator1.backgroundColor = selectedColor
            indicator2.backgroundColor = selectedColor
            indicator3.backgroundColor = unSelectedColor
            backgroundImage.image = backgrounds[index]
            titleText.text = titleList[index]
            titleDescription.text = titleDesc[index]
            circularProgress.value = 60
            
        case 2:
            
            indicator1.backgroundColor = selectedColor
            indicator2.backgroundColor = selectedColor
            indicator3.backgroundColor = selectedColor
            backgroundImage.image = backgrounds[index]
            titleText.text = titleList[index]
            titleDescription.text = titleDesc[index]
            circularProgress.value = 100
            
        case 3:
            UserDefaults.standard.set(true, forKey: "OnboardFinished")
            let storyboard = UIStoryboard(name: "Modified", bundle: .main)
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            vc.modalPresentationStyle = .fullScreen
            view.window!.layer.add(rightToLeftTransition(), forKey: kCATransition)
            present(vc, animated: true)
        default:
            break
        }
    }
    
    
    func setupUI(){
        indicator1.createBorderForView(cornerRadius: 3, borderWidth: 0, borderColor: .clear)
        indicator2.createBorderForView(cornerRadius: 3, borderWidth: 0, borderColor: .clear)
        indicator3.createBorderForView(cornerRadius: 3, borderWidth: 0, borderColor: .clear)
        nextButton.createBorderForButton(cornerRadius: 10, borderWidth: 0, borderColor: .clear)
        indicator1.backgroundColor = selectedColor
        indicator2.backgroundColor = unSelectedColor
        indicator3.backgroundColor = unSelectedColor
    }
}
