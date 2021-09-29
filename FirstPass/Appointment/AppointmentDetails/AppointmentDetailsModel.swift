//
//  AppointmentDetailsModel.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 27/11/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import Foundation

struct CancelAppointment:Codable {
    let messages:String?
    let status: Bool
    let statusCode: Int?
    let message:String?
    let error:String?
}
