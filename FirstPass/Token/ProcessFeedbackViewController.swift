//
//  ProcessFeedbackViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 01/01/21.
//  Copyright © 2021 SkeinTechnologies. All rights reserved.
//

import UIKit

class ProcessFeedbackViewController: UIViewController {
    @IBOutlet weak var collectionViewQuestion2: UICollectionView!
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var  fblist = ["How was Welcome/Help desk service ?","How was Welcome/Help desk service ?","How was Welcome/Help desk service ?","How was Welcome/Help desk service ?"]

    var selectedfeedback1 = 11
    var selectedfeedback2 = 11
    var feedbackList = [ProcessFeedback]()
    var delegate:FeedbackClosedDelegate?
    var index = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("index from new token ----------> %d", self.index);
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionViewQuestion2.delegate = self
        collectionViewQuestion2.dataSource = self
        container.layer.cornerRadius = 25
        submitButton.layer.cornerRadius = 8
        //cancelButton.createBorderForButton(cornerRadius: 8, borderWidth: 1, borderColor: .black)
        tableview.register(UINib(nibName: "FeedbackTableViewCell", bundle: .main), forCellReuseIdentifier: "FeedbackTableViewCell")
        tableview.register(UINib(nibName: "FeedbackTextTableViewCell", bundle: .main), forCellReuseIdentifier: "FeedbackTextTableViewCell")
        
//        let feedback1 = ProcessFeedback(question: "How was you interaction with physician?", rating: 0, message: "")
//        let feedback2 = ProcessFeedback(question: "How was you interaction with Nurse?", rating: 0, message: "")
//        let feedback3 = ProcessFeedback(question: "Rate your care time", rating: 0, message: "")
//        let feedback4 = ProcessFeedback(question: "Rate your waiting time experience", rating: 0, message: "")
//        let feedback5 = ProcessFeedback(question: "Rate overall service experience", rating: 0, message: "")
//        let feedback6 = ProcessFeedback(question: "Addional Remarks", rating: 0, message: "")
        
        
        let feedback1 = ProcessFeedback(question: "Ease of registration and staff courteousness", rating: 0, message: "")
               let feedback2 = ProcessFeedback(question: "Ambience and general cleanliness of the facility", rating: 0, message: "")
               let feedback3 = ProcessFeedback(question: "Nurse’s courteousness and her interaction with you", rating: 0, message: "")
               let feedback4 = ProcessFeedback(question: "Waiting experience till you were attended by Nurse", rating: 0, message: "")
               let feedback5 = ProcessFeedback(question: "How was Welcome/Help desk service ?", rating: 0, message: "")
         let feedback6 = ProcessFeedback(question: "How was Welcome/Help desk service ?", rating: 0, message: "")
         let feedback7 = ProcessFeedback(question: "How was Welcome/Help desk service ?", rating: 0, message: "")
         let feedback8 = ProcessFeedback(question: "Wait time that was experienced during your lab visit", rating: 0, message: "")
         let feedback9 = ProcessFeedback(question: "Staff’s courteousness and efficiency in completing the lab visit", rating: 0, message: "")
         let feedback10 = ProcessFeedback(question: "The overall care provided throughout your visit today?", rating: 0, message: "")
             let feedback11 = ProcessFeedback(question: "The ease of navigation throughout our facility during your visit?", rating: 0, message: "")
             let feedback12 = ProcessFeedback(question: "The wait times that were experienced during your visit?", rating: 0, message: "")
             let feedback13 = ProcessFeedback(question: "The ability of our staff to address both your medical and non-medical concerns?", rating: 0, message: "")
             let feedbackfinal = ProcessFeedback(question: "How was Welcome/Help desk service ?", rating: 0, message: "")
        index = 2
        if(self.index == 0){
        feedbackList = [feedback1,feedback2,feedbackfinal]
        }
        else if(self.index == 1){
            feedbackList = [feedback3,feedback4,feedbackfinal]
        }else if(self.index == 2){
            feedbackList = [feedback5,feedback6,feedback7,feedbackfinal]
        }else if(self.index == 3){
            feedbackList = [feedback8,feedback9,feedbackfinal]
        }else if(self.index == 4){
            feedbackList = [feedback10,feedback11,feedback12,feedback13,feedbackfinal]
        }else{
            feedbackList = [feedback10,feedback11,feedback12,feedback13,feedbackfinal]

        }
    }
    
    @IBAction func closeAction(_ sender: Any) {
        //delegate?.feedbackWindowClosed(index: index)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func submitAction(_ sender: Any) {
        delegate?.feedbackWindowClosed(index: index)
    }
    
}
extension ProcessFeedbackViewController:UITableViewDelegate,UITableViewDataSource,GetRatingQuestionIndexDelegate{
    func getRatingIndex(rating: Int, index: Int) {
        feedbackList[index].feedbackRating = rating
        
        print(feedbackList)
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.tableview.scrollToRow(at: IndexPath(row: index + 1, section: 0), at: .top, animated: true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedbackList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 5{
            return 140
        }else{
            return 120
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        NSLog("index path %d --- Count  %d",indexPath.row,feedbackList.count)
        if indexPath.row != feedbackList.count - 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedbackTableViewCell", for: indexPath) as! FeedbackTableViewCell
            cell.feedback.text =  feedbackList[indexPath.row].feedbackQuestion
            cell.rating = feedbackList[indexPath.row].feedbackRating
            cell.collectionview.reloadData()
            cell.collectionview.tag = indexPath.row
            cell.questionIndexDelegate = self
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedbackTextTableViewCell", for: indexPath) as! FeedbackTextTableViewCell
            return cell
        }
    }
    
    
}
extension ProcessFeedbackViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "numberRatingCollectionViewCell", for: indexPath) as! numberRatingCollectionViewCell
        cell.ratingLabel.text = String(indexPath.row+1)
        cell.bgView.layer.borderWidth = 0.5
        cell.bgView.layer.borderColor = UIColor.gray.cgColor
        cell.bgView.backgroundColor = UIColor.white
        cell.ratingLabel.textColor = UIColor.black
        if collectionView == collectionview
        {
            if indexPath.row == selectedfeedback1
            {
            print(self.selectedfeedback1)
            cell.bgView.backgroundColor = UIColor.orange
            cell.ratingLabel.textColor = UIColor.white
            }
        }
        else
        {
            if indexPath.row == selectedfeedback2
            {
            print(self.selectedfeedback2)
            cell.bgView.backgroundColor = UIColor.orange
            cell.ratingLabel.textColor = UIColor.white
            }

        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 25, height: 25)
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedfeedback1 = indexPath.row
        print(self.selectedfeedback1)
        collectionview.reloadData()
    }
}
struct ProcessFeedback {
    var feedbackQuestion:String
    var feedbackRating:Int
    var feedbackMessage:String
    
    init(question:String,rating:Int,message:String) {
        self.feedbackQuestion = question
        self.feedbackRating = rating
        self.feedbackMessage = message
    }
}


protocol GetRatingQuestionIndexDelegate {
    func getRatingIndex(rating:Int,index:Int)
}

protocol FeedbackClosedDelegate {
    func feedbackWindowClosed(index:Int)
}
