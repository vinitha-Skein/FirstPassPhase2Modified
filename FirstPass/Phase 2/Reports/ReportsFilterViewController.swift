//
//  ReportsFilterViewController.swift
//  FirstPass
//
//  Created by Skeintech on 17/06/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class ReportsFilterViewController: UIViewController {
    
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var closeButton: UIButton!
    
    
    
    @IBOutlet var applyButton: UIButton!
    @IBOutlet var clearallButton: UIButton!
    @IBOutlet weak var Container: UIView!
    @IBOutlet weak var popupContainer: UIView!
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var byTypeButton: UIButton!
    @IBOutlet weak var byMonthButton: UIButton!
    var Months = ["January","February","March","April","May","June","July","August","September","October","November","December"]
    var Types = ["CBP Test","Blood Test","Diabetes Test","Urinal Test"]
    var checkBoxSelected = true
    var byType = true
    var clearallClicked = false
    var buttonBG = UIColor(red: 53/255, green: 35/255, blue: 100/255, alpha: 1)
    var buttonBGNotSelected = UIColor(red: 114/255, green: 118/255, blue: 124/255, alpha: 0.1)
    var buttontextColor = UIColor(red: 74/255, green: 79/255, blue: 87/255, alpha: 1)
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.isOpaque = false
        collectionview.delegate = self
        collectionview.dataSource = self
        byTypeButton.layer.cornerRadius = 5
        byMonthButton.layer.cornerRadius = 5
        collectionViewHeight.constant = 150
        byMonthButton.layer.borderWidth = 1
        byMonthButton.layer.borderColor = buttontextColor.cgColor
        
        Container.layer.cornerRadius = 30
        popupContainer.layer.cornerRadius = 30
//        popupContainer.layer.masksToBounds = false
//        popupContainer.layer.shadowColor = UIColor.black.cgColor
//        popupContainer.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        popupContainer.layer.shadowOpacity = 0.2
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
        popupContainer.backgroundColor = UIColor(named: "vip")
        titleLabel.textColor = UIColor(hex: "#503E00")
        clearallButton.setTitleColor(UIColor(hex: "#503E00"), for: .normal)
        applyButton.setTitleColor(UIColor(hex: "#503E00"), for: .normal)
       
        byTypeButton.backgroundColor = UIColor(hex: "#503E00")
        byTypeButton.setTitleColor(UIColor.white, for: .normal)
        byMonthButton.layer.backgroundColor = UIColor.clear.cgColor
        byMonthButton.setTitleColor(UIColor(hex: "#503E00"), for: .normal)
        byMonthButton.layer.borderWidth = 1
        byMonthButton.layer.borderColor = UIColor(hex: "#503E00").cgColor
    }
    @IBAction func backClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func clearAllClicked(_ sender: Any)
    {
        clearallClicked = true
        collectionview.reloadData()
    }
    @IBAction func applyClicked(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func byTypeClicked(_ sender: Any)
    {
        if let layout = collectionview.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
        if UserDefaults.standard.bool(forKey: "vip")
        {
            byType = true
            collectionViewHeight.constant = 150
            collectionview.reloadData()
            byTypeButton.backgroundColor = UIColor(hex: "#503E00")
            byTypeButton.setTitleColor(UIColor.white, for: .normal)
            byMonthButton.layer.backgroundColor = UIColor.clear.cgColor
            byMonthButton.setTitleColor(UIColor(hex: "#503E00"), for: .normal)
            byMonthButton.layer.borderWidth = 1
            byMonthButton.layer.borderColor = UIColor(hex: "#503E00").cgColor
        }
        else
        {
            byType = true
            collectionViewHeight.constant = 150
            collectionview.reloadData()
            byTypeButton.layer.backgroundColor = buttonBG.cgColor
            byTypeButton.setTitleColor(UIColor.white, for: .normal)
            byMonthButton.layer.backgroundColor = buttonBGNotSelected.cgColor
            byMonthButton.setTitleColor(buttontextColor, for: .normal)
            byMonthButton.layer.borderWidth = 1
            byMonthButton.layer.borderColor = buttontextColor.cgColor
        }
        
        
        

    }
    @IBAction func byMonthClicked(_ sender: Any)
    {
        if let layout = collectionview.collectionViewLayout as? UICollectionViewFlowLayout
        {
        layout.scrollDirection = .horizontal
        }
        
        if UserDefaults.standard.bool(forKey: "vip")
        {
            byType = false
            collectionViewHeight.constant = 200
            collectionview.reloadData()
            
            byMonthButton.backgroundColor = UIColor(hex: "#503E00")
            byMonthButton.setTitleColor(UIColor.white, for: .normal)
            byTypeButton.backgroundColor = UIColor.clear
            byTypeButton.setTitleColor(UIColor(hex: "#503E00"), for: .normal)
            byTypeButton.layer.borderWidth = 1
            byTypeButton.layer.borderColor = UIColor(hex: "#503E00").cgColor
        }
        
        else
        {
            byType = false
            collectionViewHeight.constant = 200
            collectionview.reloadData()
            
            byMonthButton.layer.backgroundColor = buttonBG.cgColor
            byMonthButton.setTitleColor(UIColor.white, for: .normal)
            byTypeButton.layer.backgroundColor = buttonBGNotSelected.cgColor
            byTypeButton.setTitleColor(buttontextColor, for: .normal)
            byTypeButton.layer.borderWidth = 1
            byTypeButton.layer.borderColor = buttontextColor.cgColor
        }
        
        
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
extension ReportsFilterViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if (byType)
        {
            return Types.count

        }
        else
        {
           return Months.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "FiltersCollectionViewCell", for: indexPath) as! FiltersCollectionViewCell
        
        if UserDefaults.standard.bool(forKey: "vip")
        {
            cell.catgoryLabel.textColor = UIColor(hex: "#503E00")
            cell.checkButton.setImage(UIImage(named: "vipunselected"), for: .normal)
        }
        else
        {
            cell.catgoryLabel.textColor = UIColor.black
            cell.checkButton.setImage(UIImage(named: "checkboxDeselected"), for: .normal)
        }
        
        if (byType)
        {
            cell.catgoryLabel.text = Types[indexPath.row]
        }
        else
        {
            cell.catgoryLabel.text = Months[indexPath.row]
        }
        cell.checkButtonPressed =
        {
            if UserDefaults.standard.bool(forKey: "vip")
            {
                if(self.checkBoxSelected == true)
                {
                    cell.checkButton.setImage(UIImage(named: "vipselected"), for: .normal)
                    self.checkBoxSelected = false
                }
                else
                {
                    cell.checkButton.setImage(UIImage(named: "vipunselected"), for: .normal)
                    self.checkBoxSelected = true
                    self.clearallClicked = false
                }
            }
            else
            {
                if(self.checkBoxSelected == true)
                {
                    cell.checkButton.setImage(UIImage(named: "checkboxDeselected"), for: .normal)
                    self.checkBoxSelected = false
                }
                else
                {
                    cell.checkButton.setImage(UIImage(named: "checkboxSelected"), for: .normal)
                    self.checkBoxSelected = true
                    self.clearallClicked = false
                }
            }
            
            
        }
        if (clearallClicked)
        {
            if UserDefaults.standard.bool(forKey: "vip")
            {
                cell.checkButton.setImage(UIImage(named: "vipunselected"), for: .normal)

            }
            else
            {
               cell.checkButton.setImage(UIImage(named: "checkboxDeselected"), for: .normal)
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if (byType)
        {
            let width = collectionview.frame.width
            return CGSize(width: width, height: 30)
        }
        else
        {
            let width = collectionview.frame.width/2
            return CGSize(width: width, height: 30)
        }
        
        
    }
    
}
