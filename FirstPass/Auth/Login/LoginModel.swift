//
//  LoginModel.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 02/11/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import Foundation

struct LoginUser:Codable {
    let messages: String?
    let status: Bool
    let statusCode: Int?
    let message:String?
    let error:String?
    let data:LoginUserData?
}

struct LoginUserData:Codable {
    let firstName: String?
    let lastName: String?
    let mailAddress: String?
    let mobileNo: String?
    let userId:Int?
    let pId:Int?
    let emiratesId:String?
    let mrnNO:String?
    let state_city:String?
    let dob:String?
    let profile_pic:String?
    let familyMemberDto:[FamilyMemberDto]?
    
    enum CodingKeys:String,CodingKey {
        case firstName
        case lastName
        case mailAddress
        case mobileNo
        case userId
        case pId
        case emiratesId
        case mrnNO = "mrnNo"
        case state_city
        case dob
        case profile_pic
        case familyMemberDto
    }
}

struct FamilyMemberDto:Codable{
    let dob:String?
    let memberId:Int?
    let name:String?
    let profile_pic:String?
    let emiratesId:String?
    let pId: Int?
    let releation:String?
    let state_city:String?
    let mrnNO:String?

}

