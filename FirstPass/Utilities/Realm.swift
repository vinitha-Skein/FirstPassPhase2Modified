//
//  Realm.swift
//  Trivia
//
//  Created by SkeinTechnologies on 05/10/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import Foundation
import RealmSwift

//@objcMembers class LoginDataRealm:Object,Decodable{
//   dynamic var status:Bool = false
//   dynamic var statusCode:Int = 0
//   dynamic var messages:String = ""
//    var data = RealmSwift.List<LoginUserDataRealm>()
//    enum CodingKeys: String, CodingKey {
//        case status
//        case statusCode
//        case messages
//        case data
//    }
//
//    required init(from decoder: Decoder) throws
//    {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        status = try container.decode(Bool.self, forKey: .status)
//        statusCode = try container.decode(Int.self, forKey: .statusCode)
//        messages = try container.decode(String.self, forKey: .messages)
//        let datas = try container.decode(LoginUserDataRealm.self, forKey: .data)
//        data.append(datas)
//        super.init()
//    }
//
////    override static func primaryKey() -> String?
////    {
////        return "memberId"
////    }
//
//    required init()
//    {
//        super.init()
//    }
//}

class Mrn:Decodable {
    var mrnNo:String?
}
@objcMembers class LoginUserDataRealm:Object,Decodable {
    dynamic var firstName: String = ""
    dynamic var lastName: String = ""
    dynamic var mailAddress: String = ""
    dynamic var mobileNo: String = ""
    dynamic var userId:Int = 0
    dynamic var pId:Int = 0
    dynamic var state_city:String?

    dynamic var emiratesId:String?
    dynamic var mrnNo: String? = ""
    dynamic var dob:String?
    dynamic var profile_pic:String?
    
    //    dynamic var profile_pic:String = ""
    //    let familyMemberDtoList = RealmSwift.List<FamilyMemberDtoRealm>()
    
//    enum CodingKeys: String, CodingKey {
//        case firstName
//        case lastName
//        case mailAddress
//        case mobileNo
//        case userId
//        case pId
//        case emiratesId
//        case mrnNo
//        case state_city
//        case dob
//        case profile_pic
//    }
    
//    required init(from decoder: Decoder) throws
//    {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        firstName = try container.decode(String.self, forKey: .firstName)
//        lastName = try container.decode(String.self, forKey: .lastName)
//        mailAddress = try container.decode(String.self, forKey: .mailAddress)
//        mobileNo = try container.decode(String.self, forKey: .mobileNo)
//        userId = try container.decode(Int.self, forKey: .userId)
//        pId = try container.decode(Int.self, forKey: .pId)
//
//        mrnNo = try container.decode(String?.self, forKey: .mrnNo)
//        state_city = try container.decode(String?.self, forKey: .state_city)
////        emiratesId = try container.decode(String?.self, forKey: .emiratesId)
////        dateOfBirth = try container.decode(String.self, forKey: .dob)
////        profile_pic = try container.decode(String?.self, forKey: .profile_pic)
//
//
//
//        //        let familyMemberDto = try container.decode([FamilyMemberDtoRealm].self, forKey: .familyMemberDto)
//        //        familyMemberDtoList.append(objectsIn: familyMemberDto)
//
//        super.init()
//    }
    
    override static func primaryKey() -> String?
    {
        return "userId"
    }
    
    required override init()
    {
        super.init()
    }
}

//@objcMembers class FamilyMemberDtoRealm:Object,Decodable{
//    dynamic var dob:String = ""
//    dynamic var memberId:Int = 0
//    dynamic var name:String = ""
//    dynamic var pId: Int = 0
//    dynamic var releation:String = ""
//
////    enum CodingKeys: String, CodingKey {
////        case dob
////        case memberId
////        case name
////        case pId
////        case releation
////    }
////
////    required init(from decoder: Decoder) throws
////    {
////        let container = try decoder.container(keyedBy: CodingKeys.self)
////
////        dob = try container.decode(String.self, forKey: .dob)
////        memberId = try container.decode(Int.self, forKey: .memberId)
////        name = try container.decode(String.self, forKey: .name)
////        releation = try container.decode(String.self, forKey: .releation)
////        pId = try container.decode(Int.self, forKey: .pId)
////        super.init()
////    }
//
//    override static func primaryKey() -> String?
//    {
//        return "memberId"
//    }
//
//    required init()
//    {
//        super.init()
//    }
//}
