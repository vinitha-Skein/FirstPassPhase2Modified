//
//  FoodandBeveragesViewController.swift
//  FirstPass
//
//  Created by Skeintech on 25/09/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

struct CartItemsData:Decodable
{
    let ItemName:String?
    let Price:Int?
    var Quantity:Int?
}

class FoodandBeveragesViewController: UIViewController
{
    
    @IBOutlet weak var cartQuantityLabel: UILabel!
    @IBOutlet weak var cartItemQuantityView: UIView!
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var cartBgView: UIView!
    @IBOutlet weak var Container: UIView!
    @IBOutlet weak var breakfastButton: Mybutton!
    @IBOutlet weak var midmealsButton: Mybutton!
    @IBOutlet weak var dinnerButton: Mybutton!
    @IBOutlet weak var tableview: UITableView!
    
    var cartQuantity = 0
    
    var addedCells = [String]()
    
    var ItemsArray = [CartItemsData]()
    
    var buttonBG = UIColor(red: 53/255, green: 35/255, blue: 100/255, alpha: 1)
    var unselectedText = UIColor(red: 74/255, green: 79/255, blue: 87/255, alpha: 1)
    
    let headerTitles = ["Snacks","Main Course","Beverages"]
    let foodItems = [["Lentil soup","Veg Soup","Mushroom Soup"],["Muttton Curry","Fish Fillet Sandwich"],["Apple Juice","Coffee"]]
    var foodImages = [["lentilsoup","vegsoup","mushroomsoup"],["mutton","sandwich"],["applejuice","coffee"]]
    let cost = [[120,120,120],[120,120],[50,20]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.register(UINib(nibName: "FoodandBeveragesTableViewCell", bundle: .main), forCellReuseIdentifier: "FoodandBeveragesTableViewCell")
        let nib = UINib(nibName: "ReportHeader", bundle: nil)
        tableview.register(nib, forHeaderFooterViewReuseIdentifier: "ReportHeader")
        tableview.delegate = self
        tableview.dataSource = self
        tableview.backgroundColor = UIColor.clear
        Container.layer.cornerRadius = 20
        Container.layer.masksToBounds = false
        Container.layer.shadowColor = UIColor.black.cgColor
        Container.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        Container.layer.shadowOpacity = 0.2
        
        cartBgView.layer.masksToBounds = false
        cartBgView.layer.shadowColor = UIColor.black.cgColor
        cartBgView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cartBgView.layer.shadowOpacity = 0.2
        
        cartBgView.layer.cornerRadius = 18
        cartView.layer.cornerRadius = 18
        cartItemQuantityView.layer.cornerRadius = cartItemQuantityView.frame.width/2
        self.cartItemQuantityView.isHidden = true
        
//        var item1 = CartItemsData(ItemName: "Coffee", Price: "Rs. 20", Quantity: 1)
//        ItemsArray.append(item1)
//        ItemsArray[0].Quantity = 5
//        ItemsArray.append(CartItemsData(ItemName: "Coffee", Price: "Rs, 30", Quantity: 1))
        // Do any additional setup after loading the view.
        
        
    }
    @IBAction func back_Clicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func cart_Clicked(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Modified", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        vc.ItemsArray = ItemsArray
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func dinner_Clicked(_ sender: Any)
    {
        
         breakfastButton.backgroundColor = .clear
         midmealsButton.backgroundColor = .clear

         dinnerButton.backgroundColor = buttonBG
         dinnerButton.setTitleColor(.white, for: .normal)
         breakfastButton.setTitleColor(unselectedText, for: .normal)
         midmealsButton.setTitleColor(unselectedText, for: .normal)
         tableview.reloadData()

    }
    
    @IBAction func breakfast_Clicked(_ sender: Any)
    {
        dinnerButton.backgroundColor = .clear
        midmealsButton.backgroundColor = .clear

        breakfastButton.backgroundColor = buttonBG
        breakfastButton.setTitleColor(.white, for: .normal)
        dinnerButton.setTitleColor(unselectedText, for: .normal)
        midmealsButton.setTitleColor(unselectedText, for: .normal)
        tableview.reloadData()
    }
    
    @IBAction func midmeals_Click(_ sender: Any)
    {
        breakfastButton.backgroundColor = .clear
        dinnerButton.backgroundColor = .clear

        midmealsButton.backgroundColor = buttonBG
        midmealsButton.setTitleColor(.white, for: .normal)
        breakfastButton.setTitleColor(unselectedText, for: .normal)
        dinnerButton.setTitleColor(unselectedText, for: .normal)
        tableview.reloadData()
    }
    @IBAction func requestWater_Clciked(_ sender: Any)
    {
        
     
    }
}
extension FoodandBeveragesViewController: UITableViewDelegate,UITableViewDataSource
{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return foodItems.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return foodItems[section].count
    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        guard let view = tableView.dequeueReusableHeaderFooterView(
//        withIdentifier: "FoodandBeveragesHeader")
//        as? FoodandBeveragesHeader
//        else
//        {
//            return nil
//        }
//        view.HeadLabel.text = headerTitles[section]
//        return view
//    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section < headerTitles.count
        {
            return headerTitles[section]
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodandBeveragesTableViewCell") as! FoodandBeveragesTableViewCell
        cell.TitleLabel.text = foodItems[indexPath.section][indexPath.row]
        cell.priceLabel.text = String(cost[indexPath.section][indexPath.row])
        cell.itemImage.image = UIImage(named: foodImages[indexPath.section][indexPath.row])
        cell.itemImage.layer.cornerRadius = 5
        cell.container.layer.cornerRadius = 8
        cell.quantityView.layer.borderWidth = 1
        cell.quantityView.layer.borderColor = UIColor.lightGray.cgColor
        cell.quantityView.layer.cornerRadius = 6
        var temp = String(indexPath.row)
        var temp2 = String(indexPath.section)
        cell.addButton.isHidden = false
        cell.addClicked =
        {
            self.addedCells.append(temp+temp2)
            addFunction()
        }
        func addFunction()
        {
            
            if addedCells.contains(temp+temp2)
            {
                print("Row \(indexPath.row) section: \(indexPath.section)")
                cell.addButton.isHidden = true
                cell.quantityView.isHidden = false
                self.cartQuantity += 1
                self.cartQuantityLabel.text = String(self.cartQuantity)
                self.cartItemQuantityView.isHidden = false
                self.ItemsArray.append(CartItemsData(ItemName: self.foodItems[indexPath.section][indexPath.row], Price: self.cost[indexPath.section][indexPath.row], Quantity: 1))
            }
        }
        if (addedCells.contains(temp+temp2))
        {
            cell.quantityView.isHidden = false
            cell.addButton.isHidden = true
        }
        cell.increaseClicked =
            {
                
            var quantity = Int(cell.quantityLabel.text!)
            if quantity! < 99 {
                cell.quantityLabel.text = String(quantity!+1)
                self.cartQuantity += 1
                self.cartQuantityLabel.text = String(self.cartQuantity)
                var index = self.ItemsArray.endIndex-1
                print(index)
                self.ItemsArray[index].Quantity = quantity!+1
                print(self.ItemsArray)
            }
            else{
                cell.quantityLabel.text = "99+"
            }
        }
        cell.DecreaseClicked = {
            var quantity = Int(cell.quantityLabel.text!)
            if quantity! > 1
            {
                    cell.quantityLabel.text = String(quantity!-1)
                    self.cartQuantity -= 1
                    self.cartQuantityLabel.text = String(self.cartQuantity)
                    self.cartQuantityLabel.text = String(self.cartQuantity)

                    var index = self.ItemsArray.endIndex-1
                print("index \(index) Array \(self.ItemsArray)" )
                    self.ItemsArray[index].Quantity = quantity!-1
                    print(self.ItemsArray)
            }
            else
            {
                cell.addButton.isHidden = false
                cell.quantityView.isHidden = true
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? UITableViewHeaderFooterView else {return}
        headerView.contentView.backgroundColor = UIColor.white
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 166
    }
}

