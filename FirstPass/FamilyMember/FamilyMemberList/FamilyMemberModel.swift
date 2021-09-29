//
//  FamilyMemberModel.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 04/11/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import Foundation
struct FamilyMember:Codable {
    let messages: String?
    let status: Bool
    let statusCode: Int?
    let message:String?
    let error:String?
    let familyMembers:[FamilyMembersList]?
}
struct FamilyMembersList:Codable {
    let name: String?
    let dob: String?
    let memberId: Int?
    let pId: Int?
    let releation:String?
    let title: String?
    let nationalId: String?
    let id_proof:String?
    let paymentmethod: String?
    let insurancename: String?
    let insuranceno: String?
    let insurancevalidity: String?
    let insurancecardimage: String?
    let mrnNo: String?
    let profile_pic: String?

}

struct DeleteFamilyMember:Decodable {
    let id: Int?
    let messages: String?
    let status: Bool?
    let statusCode: Int?
    let releation:String?
    let message:String?
    let error:String?
}
