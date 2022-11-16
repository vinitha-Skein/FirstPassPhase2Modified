//
//  AddAppointmentModel.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 06/11/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import Foundation
struct GetLocation:Decodable {
    let message:String?
    let error:String?
    let messages: String?
    let status: Bool
    let statusCode: Int?
    let locations:[LocationData]?
}
struct LocationData:Decodable {
    let locationAddress:String?
    let locationId: Int?
    let locationIdentfier:String?
    let locationNameAr: String?
    let locationNameEn: String?
}


struct GetBranch:Decodable {
    let message:String?
    let error:String?
    let messages: String?
    let status: Bool
    let statusCode: Int?
    let locations:[BranchData]?
}
struct BranchData:Decodable {
    let branchId: Int?
    let branchNameAr:String?
    let branchNameEn:String?
    let branchType:BranchType?
}
struct BranchType:Decodable {
    let branchTypeId:Int?
}



struct GetServices:Decodable {
    let messages: String?
    let status: Bool?
    let statusCode: Int?
    let message:String?
    let error:String?
    let services:[ServiceData]?
}

struct ServiceData:Decodable {
    let branchId: Int?
    let serviceId:Int?
    let serviceNameAr:String?
    let serviceNameEn:String?
}


struct GetDoctors:Decodable {
//    let messages: String?
//    let status: Bool?
//    let statusCode: Int?
//    let message:String?
//    let error:String?
    let doctors:[DoctorData]?
}

struct DoctorData:Decodable {
    let drId: Int?
    let isActive:Int?
    let doctorName:String?
    let userName:String?
}

struct CreateAppointment:Decodable{
    let status: Bool?
    let statusCode: Int?
    let messages: String?
    let message:String?
    let error:String?
    let appointment:CreatedAppointmentData?
}

struct CreatedAppointmentData:Decodable {
    let pId: Int?
    let messages: String?
    let mrnNo: String?
    let patientName:String?
    let doctorName: String?
    let departmentName: String?
    let serviceName:String?
    let appointmentTime:String?
    let serviceBookedId: Int?
    let status:String?
    let message:String?
    let error:String?
    let date:String?
}
