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
    let appointments:[ActiveAppointmentData]?
    let taotalPages:Int?
}

struct ActiveAppointmentData:Decodable {
    let doctor_name : String?
    let appt_status : String?
    let trans_id : String?
    let appointment_time : String?
    let patient_name : String?
    let service : String?
    let department : String?
    let token_no : String?
    let token_status : String?
    let room : String?
}
