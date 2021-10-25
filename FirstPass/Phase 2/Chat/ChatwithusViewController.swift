//
//  ChatwithusViewController.swift
//  FirstPass
//
//  Created by Skeintech on 21/06/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class ChatwithusViewController: UIViewController
{
    
    @IBOutlet var backButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var container: UIView!
    @IBOutlet var messageTextfeild: UITextField!
    @IBOutlet var buttonView: UIView!
    @IBOutlet weak var chatTableView: UITableView!
    var recieverBG = UIColor(red: 254/255, green: 243/255, blue: 223/255, alpha: 1)
    var BG = UIColor(red: 204/255, green: 192/255, blue: 255/255, alpha: 0.2)
    
    var chatSend = ["Hai. I have an issue","Hi","How can i help you with?","How do i book appointment?","Hai. I have an issue","Hi","How can i help you with?","How do i book appointment?","How can i help you with?","Hai. I have an issue","Hai"]
    //var chatReccieved = ["Hi","How can i help you with?","Hi","How can i help you with?","Hi"]
    override func viewDidLoad()
    {
        super.viewDidLoad()
        chatTableView.delegate = self
        chatTableView.dataSource = self
        buttonView.layer.cornerRadius = buttonView.frame.width/2
        updateTableContentInset()
        container.backgroundColor = BG
        //chatTableView.backgroundColor = BG
        messageTextfeild.layer.cornerRadius = 8
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
        container.backgroundColor = UIColor.black
        titleLabel.textColor = UIColor.white
        buttonView.backgroundColor = UIColor(named: "vip")
        backButton.setImage(UIImage(named: "vipback"), for: .normal)
    }
    @IBAction func back_clicked(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func Send_Clicked(_ sender: Any)
    {
        if (messageTextfeild.text == "")
        {
            showAlert("Please Enter the Message")
        }
        else
        {
            chatSend.append(messageTextfeild.text ?? "")
            messageTextfeild.text = nil
            chatTableView.reloadData()
                DispatchQueue.main.async
                {
                    let index = IndexPath(row: self.chatSend.count-1, section: 0)
                    self.chatTableView.scrollToRow(at: index, at: .bottom, animated: true)
                }
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
    func updateTableContentInset() {
        let numRows = self.chatTableView.numberOfRows(inSection: 0)
        var contentInsetTop = self.chatTableView.bounds.size.height
        for i in 0..<numRows {
            let rowRect = self.chatTableView.rectForRow(at: IndexPath(item: i, section: 0))
            contentInsetTop -= rowRect.size.height
            if contentInsetTop <= 0 {
                contentInsetTop = 0
                break
            }
        }
        self.chatTableView.contentInset = UIEdgeInsets(top: contentInsetTop,left: 0,bottom: 0,right: 0)
    }

}
extension ChatwithusViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        chatSend.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatwithusTableViewCell") as! ChatwithusTableViewCell
        
        
        
        cell.chatLabel.text = chatSend[indexPath.row]
        cell.chatViewLeading.isActive = true
        cell.chatViewLeading.isActive = false
        cell.chatView.layer.cornerRadius = 8
        if UserDefaults.standard.bool(forKey: "vip")
        {
            cell.cellContainer.backgroundColor = .clear
        }
        else
        {
            cell.cellContainer.backgroundColor = BG
        }
       

        cell.chatView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner]
        cell.chatView.backgroundColor = UIColor.white
        if  (indexPath.row == 1)
        {
            cell.chatViewTrailing.isActive = false
            cell.chatViewLeading.isActive = true
            cell.chatView.layer.cornerRadius = 8
            cell.chatView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
            if UserDefaults.standard.bool(forKey: "vip")
            {
                cell.chatView.backgroundColor = UIColor(named: "vip")
            }
            else
            {
                cell.chatView.backgroundColor = recieverBG
            }
        }
        else if (indexPath.row == 2)
        {
            cell.chatView.layer.cornerRadius = 8
            cell.chatViewTrailing.isActive = false
            cell.chatViewLeading.isActive = true
           
            cell.chatView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
            if UserDefaults.standard.bool(forKey: "vip")
            {
                cell.chatView.backgroundColor = UIColor(named: "vip")
            }
            else
            {
                cell.chatView.backgroundColor = recieverBG
            }
        }
        else if (indexPath.row == 5)
        {
            cell.chatView.layer.cornerRadius = 8
            cell.chatViewTrailing.isActive = false
            cell.chatViewLeading.isActive = true
            cell.chatView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
            if UserDefaults.standard.bool(forKey: "vip")
            {
                cell.chatView.backgroundColor = UIColor(named: "vip")
            }
            else
            {
                cell.chatView.backgroundColor = recieverBG
            }
        }
        else if (indexPath.row == 6)
        {
            cell.chatView.layer.cornerRadius = 8
            cell.chatViewTrailing.isActive = false
            cell.chatViewLeading.isActive = true
            cell.chatView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
            if UserDefaults.standard.bool(forKey: "vip")
            {
                cell.chatView.backgroundColor = UIColor(named: "vip")
            }
            else
            {
                cell.chatView.backgroundColor = recieverBG
            }
        }
        else if (indexPath.row == 8)
        {
            cell.chatView.layer.cornerRadius = 8
            cell.chatViewTrailing.isActive = false
            cell.chatViewLeading.isActive = true
            cell.chatView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
            if UserDefaults.standard.bool(forKey: "vip")
            {
                cell.chatView.backgroundColor = UIColor(named: "vip")
            }
            else
            {
                cell.chatView.backgroundColor = recieverBG
            }
        }
        else if (indexPath.row == 10)
        {
            cell.chatView.layer.cornerRadius = 8
            cell.chatViewTrailing.isActive = false
            cell.chatViewLeading.isActive = true
            cell.chatView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
            if UserDefaults.standard.bool(forKey: "vip")
            {
                cell.chatView.backgroundColor = UIColor(named: "vip")
            }
            else
            {
                cell.chatView.backgroundColor = recieverBG
            }
        }

            
       // else
       // {
            //cell.chatViewTrailing.isActive = true
           // cell.chatViewTrailling.isActive = false
         //   cell.chatView.backgroundColor = UIColor.yellow
       // }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
