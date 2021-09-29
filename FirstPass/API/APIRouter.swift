//
//  APIRouter.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 07/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter : URLRequestConvertible {
    //Auth
    case registerUser(params:[String:Any])
    case loginUser(params:[String:Any])
    case verifyRegistrationOTP(params:[String:Any])
    case setPassword(params:[String:Any])
    //Family Member
    case getFamilyMembers(userId:Int)
    case addFamilyMember(userId:Int,params:[String:Any])
    case editFamilyMember(userId:Int,params:[String:Any])
    case deleteFamilyMember(userId:Int,memberId:Int)
    //Profile
    case updateProfile(params:[String:Any])
    case sendOTP(params:[String:Any])
    case verifyOTP(params:[String:Any])
    case setNewPassword(params:[String:Any])
    case updateProfileImage(userId:Int,params:[String:Any])
    //Appointment
    case getAllLocations
    case getAllBranches(locationID:Int)
    case getAllServices(branchID:Int)
    case getDoctors(userId:Int,locationID:Int,serviceID:Int)
    case createAppointment(params:[String:Any])
    case cancelAppointment(appointmentId:Int)
    case getActiveAppointment(userId:Int)
    case getAllAppointment(userId:Int,page:Int)
    case checkInAppointment(userId:Int,bookedId:Int)
    //Feedback
    case submitFeedback(params:[String:Any])
    case getFeedback
    //Payment
    case savePaymentDetails(params:[String:Any])
    //Insurance
    case addInsurance(params:[String:Any])
    case editInsurance(params:[String:Any])
    case getInsurance(memberId:Int)
    case deleteInsurance(memberId:Int)



    // MARK: - HTTPMethod
    private var method : HTTPMethod{
        switch self{
        case .registerUser,.loginUser,.verifyRegistrationOTP,.updateProfile,.sendOTP,.verifyOTP,.setNewPassword,.addFamilyMember,.createAppointment,.submitFeedback,.savePaymentDetails,.updateProfileImage,.addInsurance:
            return .post
        case .editFamilyMember,.editInsurance:
            return .put
        case .deleteFamilyMember,.deleteInsurance:
            return .delete
        case .setPassword:
            return .patch
        default:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .registerUser:
            return "user"
        case .loginUser:
            return "auth/login"
        case .verifyRegistrationOTP:
            return "auth/otp/verify"
        case .setPassword:
            return "user"
        case .getFamilyMembers(let userId):
            return "familymember/\(userId)/all"
        case .addFamilyMember(let userId,_):
            return "familymember/create/\(userId)"
        case .editFamilyMember(let userId,_):
            return "familymember/update/\(userId)"
        case .deleteFamilyMember(let userId, let memberId):
            return "familymember/\(userId)/delete/\(memberId)"
        case .updateProfile:
            return "user/update"
        case .sendOTP:
            return "user/send-otp"
        case .verifyOTP:
            return "user/verify-otp"
        case .setNewPassword:
            return "user"
        case .createAppointment:
            return "appointment/create"
        case .cancelAppointment(let appointmentId):
            return "appointment/\(appointmentId)/cancel-appointment"
        case .getActiveAppointment(let userId):
            return "appointment/\(userId)/active-appointments"
        case .getAllAppointment(let userId,let page):
            return "/appointment/9/all/appointments?active=true&index=1&offset=10"
        case .checkInAppointment(let userId, let bookedId):
            return "/appointment/\(userId)/checkin/\(bookedId)"
        case .submitFeedback:
            return "feedback/save-feedback"
        case .getFeedback:
            return "feedback/save-feedback"
        case .savePaymentDetails:
            return "payment/savepaymentdetails"
        case .getAllLocations:
            return "location/getAllLocations"
        case .getAllBranches(let locationID):
            return "location/\(locationID)/getAllBrancesByLocId"
        case .getAllServices(let branchID):
            return "location/\(branchID)}/getAllServicesByBranchId"
        case .getDoctors(let userId,let locationID,let serviceID):
            return "user/\(userId)/resources/\(locationID)/\(serviceID)"
        case .updateProfileImage(let userId,_):
            return "user/\(userId)/profile-pic/upload"
        case .addInsurance:
            return "insurance/create"
        case .editInsurance:
                return "insurance/update"
        case .getInsurance(let memberId):
                return "insurance/\(memberId)/getInsuranceByMemberId"
        case .deleteInsurance(let memberId):
                return "insurance/\(memberId)/delete"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .registerUser(let params):
            return params
        case .loginUser(let params):
            return params
        case .verifyRegistrationOTP(let params):
            return params
        case .setPassword(let params):
            return params
        case .getFamilyMembers:
            return nil
        case .addFamilyMember(_,let params):
            return params
        case .editFamilyMember(_,let params):
            return params
        case .deleteFamilyMember:
            return nil
        case .updateProfile(let params):
            return params
        case .sendOTP(let params):
            return params
        case .verifyOTP(let params):
            return params
        case .setNewPassword(let params):
            return params
        case .createAppointment(let params):
            return params
        case .cancelAppointment:
            return nil
        case .getActiveAppointment:
            return nil
        case .getAllAppointment:
            return nil
        case .checkInAppointment:
            return nil
        case .submitFeedback(let params):
            return params
        case .getFeedback:
            return nil
        case .savePaymentDetails(let params):
            return params
        case .getAllLocations:
            return nil
        case .getAllBranches:
            return nil
        case .getAllServices:
            return nil
        case .getDoctors:
            return nil
        case .updateProfileImage(_, let params):
            return params
        case .addInsurance(let params):
            return params
        case .editInsurance(let params):
            return params
        case .getInsurance:
            return nil
        case .deleteInsurance:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try DataService.developmentBaseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = 20
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        switch path {
        case "auth/register":
        break//"No auth token needed
        case "auth/login":
        break//"No auth token needed
        case "auth/otp/verify":
        break//"No auth token needed
        case "auth/password/save":
        break//"No auth token needed
        default:
            urlRequest.setValue(UserDefaults.standard.string(forKey: "Authorization"), forHTTPHeaderField: "Authorization")

//            if let authData = KeyChain.load(key: "Authorization") {
//                let authToken = authData.to(type: String.self)
//            }
        }
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }
}
