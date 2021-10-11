//
//  ProfileModel.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 05/11/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import Foundation
struct ProfileUpdate:Decodable {
   // let messages: String?
    let status: Bool
   // let statusCode: Int?
    let message:String?
  // let error:String?
//    let data:ProfileUpdatedData?
}
struct ProfileImageUpdate:Decodable {
    let messages: String?
    let status: Bool
    let statusCode: Int?
    let message:String?
    let error:String?
//    let data:ProfileUpdatedData?
}
struct ProfileUpdatedData:Decodable {
    let firstName: String?
    let lastName: String?
    let mailAddress: String?
    let mobileNo: String?
    let userId: Int?
}
struct SendPasswordChangeOTP:Decodable {
    let messages: String?
    let status: Bool
    let statusCode: Int?
    let message:String?
    let error:String?
}
struct VerifyPasswordChangeOTP:Decodable {
    let messages: String?
    let status: Bool
    let statusCode: Int?
    let message:String?
    let error:String?
}
struct SetNewPassword:Decodable {
    let messages: String?
    let status: Bool
    let statusCode: Int?
    let message:String?
    let error:String?
}
struct profileDetails:Decodable {
    let status: Bool
    let message, full_name, mobile, mail_address: String
}
