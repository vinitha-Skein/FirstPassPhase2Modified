//
//  ProcessFeedbackViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 01/01/21.
//  Copyright © 2021 SkeinTechnologies. All rights reserved.
//

import UIKit

class ProcessFeedbackViewController: UIViewController {
    
    @IBOutlet var tabletoBottomView: NSLayoutConstraint!
    @IBOutlet var tableviewHeight: NSLayoutConstraint!
    @IBOutlet var tabletoView: NSLayoutConstraint!
    
    @IBOutlet weak var feedbackView4: UIView!
    @IBOutlet weak var feedbackView3: UIView!
    
    @IBOutlet weak var collectionViewQuestion2: UICollectionView!
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    var viewModel = FeedbackViewModel()
    
    var  fblist = ["How was Welcome/Help desk service ?","How was Welcome/Help desk service ?","How was Welcome/Help desk service ?","How was Welcome/Help desk service ?"]
    var feedbackBgColors = ["#DE3541","#DE3541","#F0852F","#F0852F","#FFC534","#FFC534","#78BF30","#78BF30","#15B530","#15B530"]
    var selectedfeedback1 = 11
    var selectedfeedback2 = 11
    var feedbacks = [Int]()
    var feedbackList = [ProcessFeedback]()
    var delegate:FeedbackClosedDelegate?
    var index = 1
    var appointmentData:ActiveAppointmentData?
    
    override func viewDidLoad()
    {
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
        
        
        if index == 0
        {
            feedbackView4.isHidden = true
            feedbackView3.isHidden = true
            tabletoView.isActive = false
            tabletoBottomView.constant = 0
            tableviewHeight.constant = 350
        }
        //cancelButton.createBorderForButton(cornerRadius: 8, borderWidth: 1, borderColor: .black)
        tableview.register(UINib(nibName: "FeedbackTableViewCell", bundle: .main), forCellReuseIdentifier: "FeedbackTableViewCell")
        tableview.register(UINib(nibName: "FeedbackTextTableViewCell", bundle: .main), forCellReuseIdentifier: "FeedbackTextTableViewCell")
        

        
        
        let feedback1 = ProcessFeedback(question: "How do you rate Doctors efforts in listening and understanding your concerns", rating: 0, message: "")
        let feedback2 = ProcessFeedback(question: "Rate the Doctors ability to share information about the treatment that was offered", rating: 0, message: "")
        let feedback3 = ProcessFeedback(question: "How do you rate Nurse’s Courteousness and her interaction with you", rating: 0, message: "")
        let feedback4 = ProcessFeedback(question: "How Was your Waiting Experience till you were attended by the Nurse", rating: 0, message: "")
        let finalfeedback = ProcessFeedback(question: "", rating: 0, message: "")
                
        
        
        if(self.index == 1)
        {
            feedbackList = [feedback1,feedback2,]
        }
        else if(self.index == 0)
        {
            feedbackList = [feedback3,feedback4,finalfeedback]
        }
    }
    
    @IBAction func closeAction(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "phase2", bundle: .main)
//        let vc = storyboard.instantiateViewController(withIdentifier: "AppointmentDetailsViewController") as! AppointmentDetailsViewController
//        vc.modalPresentationStyle = .fullScreen
//
//        vc.appointmentData = self.appointmentData
//
//        self.view.window!.layer.add(self.rightToLeftTransition(), forKey: kCATransition)
//        self.present(vc, animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func submitAction(_ sender: Any)
    {
       // delegate?.feedbackWindowClosed(index: index)
//        let params1 = ["category":"registration",
//                      "trans_id":"20211007083339308",
//                      "feedback":[
//            {
//            "question":"Please rate your experience with your registration desk",
//            "answer":"5"
//        },
//            {
//            "question":"Please rate ease of registration procees",
//            "answer":"5"
//        ] as [String : Any]
       print ("Feedback Rating: \(feedbackList[0].feedbackRating)")
        
        var users = [["question":feedbackList[0].feedbackQuestion,"answer":feedbackList[0].feedbackRating],["question":feedbackList[1].feedbackQuestion,"answer":feedbackList[1].feedbackRating]]
        
        if index == 1
        {
            users.append(["question":"How likely are you to recommend the Doctor to your friends and family","answer": "\(selectedfeedback1+1)"])
            users.append(["question":"How likely are you to recommend the facility to your friends and family","answer": "\(selectedfeedback2+1)"])
        }
        let category = index == 0 ? "Vitals" : "Doctor Consultation"
        
        let params = ["category":category,
                      "trans_id":"\(self.appointmentData?.trans_id ?? "20211007083339308")","feedback":users] as [String : Any]
        

        viewModel.submitFeedback(params: params)
        print(params)
        viewModel.submitSuccess =
        {
            self.view.makeToast("Thank you for you Feedback!")
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (_) in
                self.dismiss(animated: true, completion: nil)
            }
            
        }

    }
    
}
extension ProcessFeedbackViewController:UITableViewDelegate,UITableViewDataSource,GetRatingQuestionIndexDelegate{
    func getRatingIndex(rating: Int, index: Int) {
        feedbackList[index].feedbackRating = rating
        
        print(feedbackList)
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//            self.tableview.scrollToRow(at: IndexPath(row: index + 1, section: 0), at: .top, animated: true)
//        }
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
       // NSLog("index path %d --- Count  %d",indexPath.row,feedbackList.count)
                
        if (index == 0)
        {
            if indexPath.row != feedbackList.count - 1
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FeedbackTableViewCell", for: indexPath) as! FeedbackTableViewCell
                cell.feedback.text =  feedbackList[indexPath.row].feedbackQuestion
                cell.rating = feedbackList[indexPath.row].feedbackRating
                cell.collectionview.reloadData()
                cell.collectionview.tag = indexPath.row
                cell.questionIndexDelegate = self
                return cell
            }
            else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FeedbackTextTableViewCell", for: indexPath) as! FeedbackTextTableViewCell
                return cell
            }
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedbackTableViewCell", for: indexPath) as! FeedbackTableViewCell
            cell.feedback.text =  feedbackList[indexPath.row].feedbackQuestion
            cell.rating = feedbackList[indexPath.row].feedbackRating
            cell.collectionview.reloadData()
            cell.collectionview.tag = indexPath.row
            cell.questionIndexDelegate = self
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
        cell.bgView.layer.cornerRadius = 3
        cell.bgView.layer.borderColor = UIColor.gray.cgColor
        cell.bgView.backgroundColor = UIColor(hex: feedbackBgColors[indexPath.row])
        cell.ratingLabel.textColor = UIColor.white
        if collectionView == collectionview
        {
            if indexPath.row == selectedfeedback1
            {
            print(self.selectedfeedback1)
            cell.bgView.backgroundColor = UIColor(named: "BG")
            cell.ratingLabel.textColor = UIColor.white
            }
        }
        else
        {
            if indexPath.row == selectedfeedback2
            {
            print(self.selectedfeedback2)
            cell.bgView.backgroundColor = UIColor(named: "BG")
            cell.ratingLabel.textColor = UIColor.white
            }

        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width-110)/10, height: 25)
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionview
        {
            self.selectedfeedback1 = indexPath.row
            print(self.selectedfeedback1)
            collectionview.reloadData()
        }
        else
        {
            self.selectedfeedback2 = indexPath.row
            print(self.selectedfeedback1)
            collectionViewQuestion2.reloadData()
        }
        
    }
    
    
    func  updateJourney(Status:String){
        let journey = JourneyDetails(tokenNo: appointmentData?.token_no, currentStatus: "1", CompletedStatus: [], currentJourneyUpdate: Status,appointmentStatus: "CHECKIN")
        let key = "JOURNEY" + (appointmentData?.trans_id)!
        do {
            let data = try PropertyListEncoder().encode(journey)
            UserDefaults.standard.set(data, forKey: key)
        } catch let error {
            debugPrint(error)
        }
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
