//
//  AddMemberModel.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 04/11/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import Foundation
struct AddFamilyMember:Decodable {
    let message: String?
    let messages: String?
    let status: Bool?
    let statusCode: Int?
    let error:String?
}
struct AddedMember:Decodable {
    let name: String?
    let dob: Int?
    let releation:String?
}

struct FamilyMemberList{
    var members:[String]
    init(members:[String]) {
        self.members = members
    }
}


// Updated Family Member API Response
struct UpdateMember:Decodable {
    let message:String?
    let messages: String?
    let status: Bool?
    let statusCode: Int
    let error:String?
//    let data:UpdatedFamilyMmber?
}
struct UpdatedFamilyMmber:Decodable {
    let name: String?
    let dob: Int?
    let memberId: Int?
    let pId: Int?
    let releation:String?
}
