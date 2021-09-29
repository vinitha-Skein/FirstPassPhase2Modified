//
//  CartViewController.swift
//  FirstPass
//
//  Created by Skeintech on 28/09/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class CartViewController: UIViewController
{

    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var itemCountLabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    var ItemsArray = [CartItemsData]()
    var totalPrice = 0
    var cartQuantity = Int()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.register(UINib(nibName: "CartTableViewCell", bundle: .main), forCellReuseIdentifier: "CartTableViewCell")
        tableview.delegate = self
        tableview.dataSource = self
//        ItemsArray = UserDefaults.standard.object(forKey: "cartItems") as! [CartItemsData]
        // Do any additional setup after loading the view.
        itemCountLabel.text = String(ItemsArray.count)
    }
    
    @IBAction func placeOrder_Clicked(_ sender: Any)
    {
        
    }
    
    @IBAction func back_Clicked(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
}
extension CartViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "CartTableViewCell") as! CartTableViewCell
        cell.ItemNameLabel.text = ItemsArray[indexPath.row].ItemName
        cell.PriceLabel.text = String(ItemsArray[indexPath.row].Price!)
        cell.quantityLabel.text = String(ItemsArray[indexPath.row].Quantity!)
        cell.container.layer.cornerRadius = 8
        self.totalPrice += (ItemsArray[indexPath.row].Price!) * (ItemsArray[indexPath.row].Quantity!)
        self.totalPriceLabel.text = String(totalPrice)
        
        cell.increaseClicked = {
            
                var quantity = Int(cell.quantityLabel.text!)
                cell.quantityLabel.text = String(quantity!+1)
                var currentQuantity = Int(cell.quantityLabel.text!)
                self.totalPrice += self.ItemsArray[indexPath.row].Price!
                self.totalPriceLabel.text = String(self.totalPrice)
        }
        cell.DecreaseClicked = {
            var itemQuantity = Int(cell.quantityLabel.text!)
            
            if itemQuantity! > 1 {
                var quantity = Int(cell.quantityLabel.text!)
                cell.quantityLabel.text = String(quantity!-1)
                var currentQuantity = Int(cell.quantityLabel.text!)
                self.totalPrice -= self.ItemsArray[indexPath.row].Price!
                self.totalPriceLabel.text = String(self.totalPrice)
            }
            else
            {
                self.totalPrice -= self.ItemsArray[indexPath.row].Price!
                self.totalPriceLabel.text = String(self.totalPrice)
                self.ItemsArray.remove(at: indexPath.row)
                self.tableview.reloadData()
            }
            
        }
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
