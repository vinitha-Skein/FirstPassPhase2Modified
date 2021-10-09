

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


struct FeedbackSubmitData:Codable
{
    let status : Bool?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
    }
}
