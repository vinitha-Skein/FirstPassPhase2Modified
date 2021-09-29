//
//  RegistrationModel.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 02/11/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import Foundation

struct RegisterNewUser:Decodable {
    let message: String?
    let status: Bool
    let statusCode: Int?
    let error:String?
    let data:RegisteredUserData?
    let OTP: Int?
    let user_id:Int?
}

struct RegisteredUserData:Decodable
{
    let firstName: String?
    let lastName: String?
    let mailAddress: String?
    let phone_no: String?
    let user_id:Int?
}

