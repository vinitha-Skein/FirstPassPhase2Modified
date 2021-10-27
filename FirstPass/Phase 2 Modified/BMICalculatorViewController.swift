//
//  BMICalculatorViewController.swift
//  FirstPass
//
//  Created by Skeintech on 22/09/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class BMICalculatorViewController: UIViewController {

    
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var calculateButton: Mybutton!
    @IBOutlet var cancelButton: Mybutton!
    @IBOutlet var bgView: UIView!
    
    
    @IBOutlet weak var weighttext: UITextField!
    @IBOutlet weak var height2text: UITextField!
    @IBOutlet weak var Container: UIView!
    @IBOutlet weak var weightLabelView: UIView!
    @IBOutlet weak var height2LabelView: UIView!
    @IBOutlet weak var height1Labelview: UIView!
    @IBOutlet weak var weightViewLabel: UILabel!
    @IBOutlet weak var heightview2Label: UILabel!
    @IBOutlet weak var heightviewLabel: UILabel!
    @IBOutlet weak var metricButton: Mybutton!
    @IBOutlet weak var imperialButton: Mybutton!
    
    @IBOutlet weak var height1Text: UITextField!
    @IBOutlet weak var Heightview1Width: NSLayoutConstraint!
    @IBOutlet weak var WeightView: UIView!
    @IBOutlet weak var HeightView2: UIView!
    @IBOutlet weak var HeightView1: UIView!
    var buttonBG = UIColor(red: 53/255, green: 35/255, blue: 100/255, alpha: 1)
    var unselectedText = UIColor(red: 74/255, green: 79/255, blue: 87/255, alpha: 1)
    var imperialSelected = true
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupUI()

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
        titleLabel.textColor = .white
        calculateButton.backgroundColor = UIColor(named: "vip")
        calculateButton.setTitleColor(UIColor.white, for: .normal)
        cancelButton.backgroundColor = .clear
        cancelButton.setTitleColor(UIColor(named: "vip"), for: .normal)
        cancelButton.borderColor = UIColor(named: "vip")!
        Container.backgroundColor = UIColor(hex: "#222629")
        heightLabel.textColor = UIColor(named: "vip")
        weightLabel.textColor = UIColor(named: "vip")
        heightviewLabel.textColor = .white
        heightview2Label.textColor = .white
        weightViewLabel.textColor = .white
        backButton.setImage(UIImage(named: "vipback"), for: .normal)
        
        metricButton.backgroundColor = .clear
       imperialButton.backgroundColor = UIColor(named: "vip")
        imperialButton.setTitleColor(.white, for: .normal)
        metricButton.setTitleColor(unselectedText, for: .normal)
    }
    @IBAction func calculate_Clicked(_ sender: Any)
    {
        if height1Text.text == ""
        {
            showAlert("Enter the Height")
        }
        if weighttext.text == ""
        {
            showAlert("Enter the Weight")
        }
        if imperialSelected
        {
            if height2text.text == ""
            {
                showAlert("Enter the Height")
            }
            
        }
    }
    @IBAction func cancel_Clicked(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func back_Clicked(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func imperial_Clicked(_ sender: Any)
    {
        if UserDefaults.standard.bool(forKey: "vip")
        {
            
             metricButton.backgroundColor = .clear
            imperialButton.backgroundColor = UIColor(named: "vip")
             imperialButton.setTitleColor(.white, for: .normal)
             metricButton.setTitleColor(unselectedText, for: .normal)
        }
        else
        {
            
             metricButton.backgroundColor = .clear
             imperialButton.backgroundColor = buttonBG
             imperialButton.setTitleColor(.white, for: .normal)
             metricButton.setTitleColor(unselectedText, for: .normal)
        }
        
        Heightview1Width = MyConstraint.changeMultiplier(Heightview1Width, multiplier: 0.45)
        HeightView2.isHidden = false
        heightviewLabel.text = "ft"
        weightViewLabel.text = "lbs"
        imperialSelected = true
        height1Text.text = ""
        height2text.text = ""
        weighttext.text = ""
        
    }
    @IBAction func metric_Clicked(_ sender: Any)
    {
        
        if UserDefaults.standard.bool(forKey: "vip")
        {
            imperialButton.backgroundColor = .clear
            metricButton.backgroundColor = UIColor(named: "vip")
            metricButton.setTitleColor(.white, for: .normal)
            imperialButton.setTitleColor(unselectedText, for: .normal)
        }
        else
        {
            imperialButton.backgroundColor = .clear
            metricButton.backgroundColor = buttonBG
            metricButton.setTitleColor(.white, for: .normal)
            imperialButton.setTitleColor(unselectedText, for: .normal)

        }
        
        
       metricButton.createBorderForButton(cornerRadius: 4, borderWidth: 1, borderColor: .clear)
        imperialButton.createBorderForButton(cornerRadius: 4, borderWidth: 0, borderColor: .lightGray)
        
        Heightview1Width = MyConstraint.changeMultiplier(Heightview1Width, multiplier: 1)
        HeightView2.isHidden = true
        heightviewLabel.text = "cm"
        weightViewLabel.text = "kg"
        imperialSelected = false
        height1Text.text = ""
        height2text.text = ""
        weighttext.text = ""
    }
    func SetupUI()
    {
        WeightView.layer.cornerRadius = 5
        HeightView1.layer.cornerRadius = 5
        HeightView2.layer.cornerRadius = 5
        height1Labelview.layer.cornerRadius = 5
        height1Labelview.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
        height2LabelView.layer.cornerRadius = 5
        height2LabelView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
        weightLabelView.layer.cornerRadius = 5
        weightLabelView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
        
        Container.layer.cornerRadius = 20
//        Container.layer.borderColor = UIColor.gray.cgColor
//        Container.layer.borderWidth = 0.4
        Container.layer.masksToBounds = false
        Container.layer.shadowColor = UIColor.black.cgColor
        Container.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        Container.layer.shadowOpacity = 0.2
    }
}
extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}
struct MyConstraint {
  static func changeMultiplier(_ constraint: NSLayoutConstraint, multiplier: CGFloat) -> NSLayoutConstraint {
    let newConstraint = NSLayoutConstraint(
      item: constraint.firstItem,
      attribute: constraint.firstAttribute,
      relatedBy: constraint.relation,
      toItem: constraint.secondItem,
      attribute: constraint.secondAttribute,
      multiplier: multiplier,
      constant: constraint.constant)

    newConstraint.priority = constraint.priority

    NSLayoutConstraint.deactivate([constraint])
    NSLayoutConstraint.activate([newConstraint])

    return newConstraint
  }
}
