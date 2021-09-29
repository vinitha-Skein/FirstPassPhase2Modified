//
//  InsuranceModel.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 27/11/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import Foundation
struct InsuranceAdd:Codable {
    let messages:String?
    let status: Bool
    let statusCode: Int?
    let message:String?
    let error:String?
}
struct GetInsurance:Codable {
       let messages:String?
       let status: Bool
       let statusCode: Int?
    let message:String?
    let error:String?
    
    let insurancecardimage:String?
    let insurancename: String?
    let insuranceno: String?
    let insurancevalidity: String?
    let memberId:Int?
}
struct InsuranceEdit:Codable {
    let messages:String?
    let status: Bool
    let statusCode: Int?
    let message:String?
    let error:String?
}
struct InsuranceDelete:Codable {
    let messages:String?
    let status: Bool
    let statusCode: Int
    let id:Int?
    let message:String?
    let error:String?
}
