//
//  FeedbackViewModel.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 09/11/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import Foundation
class FeedbackViewModel{
    var error:Error?{
        didSet{self.errorMessageAlert?()}
    }
    var errorMessage:String?
    
    var isLoading: Bool = false{
        didSet{self.loadingStatus?()}
    }
    var feedbackTypes = ["How was Welcome/Help desk service ?","Assistance service","Token Navigation service at the facility","Nurse care","Doctor care","Lab & report services","Pharmacist","Appointment Booking","Feedback (in words)"]
    var feedbackIndex:Int = 0
    var feedbacks = [Feedbacks]()
    
    //Closures for callback
    var submitSuccess:(() -> ())?
    var loadingStatus:(() -> ())?
    var errorMessageAlert:(() -> ())?
    var delegate:FeedbackTypeDelegate?
    
    func createFeedbackList(){
        feedbacks.append(Feedbacks(rating: 0, type: feedbackTypes[0]))
    }
    func addNextFeedback(){
        feedbacks.append(Feedbacks(rating: 0, type: feedbackTypes[feedbackIndex]))
        self.feedbackIndex = feedbackIndex + 1
    }
    func updateFeedback(feedbackIndex:Int,rating:Int){
        feedbacks[feedbackIndex].rating = rating
        self.feedbackIndex = feedbackIndex
        delegate?.feedbackUpdate()
        addNextFeedback()
    }
    
//    func submitFeedback(userId:Int){
//        let params = FeedbackData(userId: userId, feedback: feedbacks)
//    }
    
    func submitFeedback(params:Dictionary<String,Any>){
        APIClient.submitFeedback(params: params){ result in
               switch result {
               case .success(let responseData):
                   self.isLoading = false
                   
                if responseData.status!{
                        self.submitSuccess?()
                       }else{
                           self.errorMessage = responseData.message
                           self.errorMessageAlert?()
                       }
               case .failure(let error):
                   print(error.localizedDescription)
                   self.errorMessage = error.localizedDescription
                print(self.errorMessage)
                   self.error = error
                   self.isLoading = false
               }
           }
       }
}



