//
//  PaymentOptionsViewController.swift
//  FirstPass
//
//  Created by Skeintech on 22/06/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class PaymentOptionsViewController: UIViewController {

    @IBOutlet var bgView: UIView!
    @IBOutlet var morebankButton: UIButton!
    @IBOutlet var netbankingTitleLabel: UILabel!
    @IBOutlet var addUpiButton: UIButton!
    @IBOutlet var addnewUpiLabel: UILabel!
    @IBOutlet var phonepeupiLabel: UILabel!
    @IBOutlet var googlepayLabel: UILabel!
    @IBOutlet var upiTitleLabel: UILabel!
    @IBOutlet var walletTitleLabel: UILabel!
    @IBOutlet var phonepeLinkButton: UIButton!
    @IBOutlet var freechargeLinkButton: UIButton!
    @IBOutlet var paytmLinkButton: UIButton!
    @IBOutlet var phonepeLabel: UILabel!
    @IBOutlet var freechargeLabel: UILabel!
    @IBOutlet var PaytmLabel: UILabel!
    @IBOutlet var cardTitleLabel: UILabel!
    @IBOutlet var addCardButton: UIButton!
    @IBOutlet var addnewCardDescriptionLabel: UILabel!
    @IBOutlet var addNewCardLabel: UILabel!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var backButton: UIButton!
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var container: UIView!
    @IBOutlet var view4: UIView!
    @IBOutlet var view3: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var view1: UIView!
    @IBOutlet var netBankingCollectionView: UICollectionView!
    @IBOutlet var cardsTableView: UITableView!
    
    var logos = ["hdfc","icici","axis","Kotak"]
    override func viewDidLoad() {
        super.viewDidLoad()
        netBankingCollectionView.delegate = self
        netBankingCollectionView.dataSource = self
        cardsTableView.delegate = self
        cardsTableView.dataSource = self
        // Do any additional setup after loading the view.
        cardsTableView.register(UINib(nibName: "CardsTableViewCell", bundle: .main), forCellReuseIdentifier: "CardsTableViewCell")
        stackView.layer.cornerRadius = 28
        scrollView.layer.cornerRadius = 28
        view1.layer.cornerRadius = 10
        view2.layer.cornerRadius = 10
        view3.layer.cornerRadius = 10
        view4.layer.cornerRadius = 10
        container.layer.borderWidth = 0.2
        
        container.layer.borderColor = UIColor.lightGray.cgColor
        container.layer.cornerRadius = 28
        container.layer.masksToBounds = false
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        container.layer.shadowOpacity = 0.2
    }
    override func viewDidAppear(_ animated: Bool)
    {
        if UserDefaults.standard.bool(forKey: "vip")
        {
            vipview()
        }
        
    }
    func vipview()
    {
        bgView.backgroundColor = UIColor.black
        container.backgroundColor = UIColor(hex: "#222629")
        titleLabel.textColor = UIColor.white
        backButton.setImage(UIImage(named: "vipback"), for: .normal)
        cardTitleLabel.textColor = UIColor(named: "vip")
        addNewCardLabel.textColor = UIColor(named: "vip")
        addnewCardDescriptionLabel.textColor = UIColor(named: "vip")
        walletTitleLabel.textColor = UIColor(named: "vip")
        PaytmLabel.textColor = UIColor(named: "vip")
        freechargeLabel.textColor = UIColor(named: "vip")
        phonepeLabel.textColor = UIColor(named: "vip")
        paytmLinkButton.setTitleColor(UIColor(named: "vip"), for: .normal)
        freechargeLinkButton.setTitleColor(UIColor(named: "vip"), for: .normal)
        phonepeLinkButton.setTitleColor(UIColor(named: "vip"), for: .normal)
        upiTitleLabel.textColor = UIColor(named: "vip")
        googlepayLabel.textColor = UIColor(named: "vip")
        phonepeupiLabel.textColor = UIColor(named: "vip")
        netbankingTitleLabel.textColor = UIColor(named: "vip")
        morebankButton.setTitleColor(UIColor(named: "vip"), for: .normal)
    }
    
    @IBAction func back_clicked(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
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
extension PaymentOptionsViewController: UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NetBankingCollectionViewCell", for: indexPath) as! NetBankingCollectionViewCell
       
        cell.logoImage.image = UIImage(named: logos[indexPath.row])
        return cell
    }
    
    
}
extension PaymentOptionsViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardsTableViewCell") as! CardsTableViewCell
        if UserDefaults.standard.bool(forKey: "vip")
        {
            cell.cardnumberLabel.textColor = UIColor(named: "vip")
        }
        else
        {
            cell.cardnumberLabel.textColor = UIColor.black

        }
        
        return cell
    }
    
    
}
