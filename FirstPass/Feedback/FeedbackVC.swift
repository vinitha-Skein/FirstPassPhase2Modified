//
//  FeedbackVC.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 03/11/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit
extension UIView {
    var safeAreaHeight: CGFloat {
        if #available(iOS 11, *) {
            return safeAreaLayoutGuide.layoutFrame.size.height
        }
        return bounds.height
    }
}
class FeedbackVC: UIViewController,FeedbackTypeDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    var totalViewHeight = CGFloat()
    var viewModel = FeedbackViewModel()
    var rating = Int()
    var userId = Int()
    var delegate:FeedbackDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = self.view.frame.height
        let window = UIApplication.shared.keyWindow
        let topPadding = window?.safeAreaInsets.top
        let bottomPadding = window?.safeAreaInsets.bottom
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        totalViewHeight = frame - (topPadding ?? 44)
        totalViewHeight = totalViewHeight - (bottomPadding ?? 34)
        container.createBorderForView(cornerRadius: 30, borderWidth: 0, borderColor: .clear)
        nextButton.createBorderForButton(cornerRadius: 8, borderWidth: 0, borderColor: .clear)

        tableview.register(UINib(nibName: "FeedbackTableViewCell", bundle: .main), forCellReuseIdentifier: "FeedbackTableViewCell")
        tableview.register(UINib(nibName: "FeedbackTextTableViewCell", bundle: .main), forCellReuseIdentifier: "FeedbackTextTableViewCell")
        containerHeight.constant = 220
        print(view.safeAreaHeight)
        viewModel.createFeedbackList()
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
    @IBAction func nextAction(_ sender: Any) {
        if viewModel.feedbackIndex < 8{
            if rating == 0{
                self.showAlert("Please select your rating")
                return
            }
            viewModel.delegate = self
            viewModel.updateFeedback(feedbackIndex: viewModel.feedbackIndex, rating: rating)
        }else if viewModel.feedbackIndex == 8{
            nextButton.setTitle("Submit", for: .normal)
            viewModel.updateFeedback(feedbackIndex: viewModel.feedbackIndex, rating: rating)
        }else{
            viewModel.submitFeedback(userId: userId)
        }
        viewModel.submitSuccess = {
            self.delegate?.feedbackAddStatus(status: true, message: "Thank you your feedback submitted")
        }
        viewModel.errorMessageAlert = {
            self.delegate?.feedbackAddStatus(status: false, message: self.viewModel.errorMessage ?? "error")
        }
    }
    func feedbackUpdate() {
        if self.totalViewHeight < self.containerHeight.constant + 107{
            self.containerHeight.constant = self.totalViewHeight -  50
        }else{
            self.containerHeight.constant = self.containerHeight.constant + 107
        }
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
        rating = 0
    }
    
    func feedbackAdd() {
        
    }
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}



extension FeedbackVC:UITableViewDelegate,UITableViewDataSource,GetUserRatingsDelegate{
    func getUserRating(rating: Int) {
        viewModel.feedbacks[viewModel.feedbackIndex].rating = rating
        self.rating = rating
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.feedbacks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 9{
            return 140
        }else{
            return 107
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row != 9{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedbackTableViewCell", for: indexPath) as! FeedbackTableViewCell
            cell.feedback.text =  viewModel.feedbacks[indexPath.row].type
            cell.rating = viewModel.feedbacks[indexPath.row].rating
            cell.collectionview.reloadData()
            cell.delegate = self
            //        if viewModel.feedbackIndex != indexPath.row{
            //            cell.collectionview.isUserInteractionEnabled = false
            //        }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedbackTextTableViewCell", for: indexPath) as! FeedbackTextTableViewCell
            return cell
        }
    }
    
    
}


protocol FeedbackTypeDelegate:class {
    func feedbackUpdate()
    func feedbackAdd()
}


protocol GetUserRatingsDelegate {
    func getUserRating(rating:Int)
}
