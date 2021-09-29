//
//  FeedbackModel.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 09/11/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import Foundation
class FeedbackData:Codable{
    var userId:Int
    var feedBacks:[Feedbacks]
    init(userId:Int,feedback:[Feedbacks]) {
        self.userId = userId
        self.feedBacks = feedback
    }
}
struct Feedbacks:Codable{
    var rating:Int
    var type:String
    init(rating:Int,type:String) {
        self.rating = rating
        self.type = type
    }
}


struct FeedbackSubmitData:Codable {
    let messages: String
    let status: Bool
    let statusCode: Int
}
