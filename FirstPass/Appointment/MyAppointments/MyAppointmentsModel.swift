//
//  MyAppointmentsModel.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 06/11/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import Foundation
struct GetActiveAppointments:Decodable{
    let message:String?
    let error:String?
    let status: Bool?
    let statusCode: Int?
    let messages: String?
    let appointmentDetails:[ActiveAppointmentData]?
    let taotalPages:Int?
}

struct ActiveAppointmentData:Decodable {
    let pId: Int?
    let mrnNo: String?
    let patientName:String?
    let doctorName: String?
    let departmentName: String?
    let serviceName:String?
    let appointmentTime:String?
    let serviceBookedId: Int?
    let status:String?
}
