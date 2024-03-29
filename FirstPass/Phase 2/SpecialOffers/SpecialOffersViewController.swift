//
//  SpecialOffersViewController.swift
//  FirstPass
//
//  Created by MacOS on 12/10/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class SpecialOffersViewController: UIViewController
{

    @IBOutlet var backButton: UIButton!
    @IBOutlet var packagesLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bgView: UIView!
    @IBOutlet var collectionview: UICollectionView!
    let offerHeadings = ["CHRONIC OBSTRUCTIVE PULMONARY DISEASE (COPD) SCREENING","PRE-DIABETES & DIABETES SCREENING PACKAGES","It is a long established fact that a reader will be distracted "]
    let offerdescriptions = ["Our Doctors are highly trained and specialise in Chronic Obstructive Pulmonary Disease (COPD) treatment and management.","Diabetes is a lifelong condition which if not managed, causes serious health problems","It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout."]
    let offerImages = ["specialoffer1","specialoffer2","specialoffer3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionview.collectionViewLayout = CardsCollectionViewLayout()
        collectionview.isPagingEnabled = true
        collectionview.showsHorizontalScrollIndicator = false
        collectionview.dataSource = self
        collectionview.delegate = self
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
        backButton.setImage(UIImage(named: "vipback"), for: .normal)
        titleLabel.textColor = .white
        packagesLabel.textColor = .white
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
extension SpecialOffersViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offerdescriptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "SpecialOffersCollectionViewCell", for: indexPath) as! SpecialOffersCollectionViewCell
        
        if UserDefaults.standard.bool(forKey: "vip")
        {
            cell.Container.backgroundColor = UIColor(hex: "#222629")
        }
        
        cell.headingLabel.text = offerHeadings[indexPath.row]
        cell.descriptionLabel.text = offerdescriptions[indexPath.row]
        cell.offerImage.image = UIImage(named: offerImages[indexPath.row])
        cell.offerImage.layer.cornerRadius = 5
        cell.Container.layer.cornerRadius = 28
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionview.frame.width, height: collectionview.frame.height)
    }
}
