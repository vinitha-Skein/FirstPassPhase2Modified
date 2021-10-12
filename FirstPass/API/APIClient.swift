//
//  APIClient.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 07/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import Foundation
import Alamofire
class APIClient {
    @discardableResult
        private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (AFResult<T>)->Void) -> DataRequest {
            return AF.request(route)
                .responseDecodable (decoder: decoder){ (response: AFDataResponse<T>) in
                    print(response.result)
                    if let contentType = response.response?.allHeaderFields["Authorization"] as? String {
                        UserDefaults.standard.set(contentType, forKey: "Authorization")
                    }
                    completion(response.result)
            }
        }

    
    //User Auth
    static func registerUser(params:[String:Any],completion:@escaping(AFResult<RegisterNewUser>)->Void){
        performRequest(route: APIRouter.registerUser(params: params),completion: completion)
    }
    static func loginUser(params:[String:Any],completion:@escaping(AFResult<LoginUser>)->Void){
        performRequest(route: APIRouter.loginUser(params: params),completion: completion)
    }
    static func verifyRegistrationOTP(params:[String:Any],completion:@escaping(AFResult<OTPData>)->Void){
        performRequest(route: APIRouter.verifyRegistrationOTP(params: params),completion: completion)
    }
    static func setPassword(params:[String:Any],completion:@escaping(AFResult<PasswordData>)->Void){
        performRequest(route: APIRouter.setPassword(params: params),completion: completion)
    }
    
    //Family Member
    static func getFamilyMembers(completion:@escaping(AFResult<FamilyMember>)->Void){
        performRequest(route: APIRouter.getFamilyMembers,completion: completion)
    }
    static func addFamilyMember(params:[String:Any],completion:@escaping(AFResult<AddFamilyMember>)->Void){
        performRequest(route: APIRouter.addFamilyMember(params: params),completion: completion)
    }
    static func editFamilyMember(userId:Int,params:[String:Any],completion:@escaping(AFResult<UpdateMember>)->Void){
        performRequest(route: APIRouter.editFamilyMember(userId: userId, params: params),completion: completion)
    }
//    static func deleteFamilyMember(userId:Int,memberId:Int,completion:@escaping(AFResult<DeleteFamilyMember>)->Void){
//        performRequest(route: APIRouter.deleteFamilyMember(userId: userId, memberId: memberId),completion: completion)
//    }
    
    //Profile
    static func
        updateProfile(params:[String:Any],completion:@escaping(AFResult<ProfileUpdate>)->Void){
        performRequest(route: APIRouter.updateProfile(params: params),completion: completion)
    }
    static func
        getProfile(completion:@escaping(AFResult<profileDetails>)->Void){
        performRequest(route: APIRouter.getProfile,completion: completion)
    }
    static func sendOTP(params:[String:Any],completion:@escaping(AFResult<SendPasswordChangeOTP>)->Void){
        performRequest(route: APIRouter.sendOTP(params: params),completion: completion)
    }
    static func verifyOTP(params:[String:Any],completion:@escaping(AFResult<VerifyPasswordChangeOTP>)->Void){
        performRequest(route: APIRouter.verifyOTP(params: params),completion: completion)
    }
    static func setNewPassword(params:[String:Any],completion:@escaping(AFResult<SetNewPassword>)->Void){
        performRequest(route: APIRouter.setNewPassword(params: params),completion: completion)
    }
    static func updateProfileImage(userId:Int,params:[String:Any],completion:@escaping(AFResult<ProfileImageUpdate>)->Void){
        performRequest(route: APIRouter.updateProfileImage(userId: userId, params: params),completion: completion)
    }
    
    //Appointment
    static func getAllLocation(completion:@escaping(AFResult<GetLocation>)->Void){
        performRequest(route: APIRouter.getAllLocations,completion: completion)
    }
    static func getAllBranches(locationID:Int,completion:@escaping(AFResult<GetBranch>)->Void){
        performRequest(route: APIRouter.getAllBranches(locationID: locationID),completion: completion)
    }
    static func getAllServices(branchID:Int,completion:@escaping(AFResult<GetServices>)->Void){
        performRequest(route: APIRouter.getAllServices(branchID: branchID),completion: completion)
    }
    static func getDoctors(userId:Int,locationID:Int,serviceID:Int,completion:@escaping(AFResult<GetDoctors>)->Void){
        performRequest(route: APIRouter.getDoctors(userId: userId, locationID: locationID, serviceID: serviceID),completion: completion)
    }
    static func createAppointment(params:[String:Any],completion:@escaping(AFResult<CreateAppointment>)->Void){
        performRequest(route: APIRouter.createAppointment(params: params),completion: completion)
    }
    static func cancelAppointment(appointmentId:Int,completion:@escaping(AFResult<SendPasswordChangeOTP>)->Void){
        performRequest(route: APIRouter.cancelAppointment(appointmentId: appointmentId),completion: completion)
    }
    static func getActiveAppointments(completion:@escaping(AFResult<GetActiveAppointments>)->Void){
        performRequest(route: APIRouter.getActiveAppointment,completion: completion)
    }
    static func getAllAppointments(userId:Int,page:Int,completion:@escaping(AFResult<GetActiveAppointments>)->Void){
        performRequest(route: APIRouter.getAllAppointment(userId: userId, page: page),completion: completion)
    }
    static func checkInAppointment(params:[String:Any],completion:@escaping(AFResult<SetNewPassword>)->Void){
        performRequest(route: APIRouter.checkInAppointment(params:params),completion: completion)
    }
    static func QRcheckInAppointment(params:[String:Any],completion:@escaping(AFResult<SetNewPassword>)->Void){
        performRequest(route: APIRouter.QRcheckInAppointment(params:params),completion: completion)
    }
    static func AppointmentJourney(appointmentId:Int,completion:@escaping(AFResult<SendPasswordChangeOTP>)->Void){
        performRequest(route: APIRouter.appointmentJourney(appointmentId: appointmentId),completion: completion)
    }
    
    //Feedback
    static func submitFeedback(params:[String:Any],completion:@escaping(AFResult<FeedbackSubmitData>)->Void){
        performRequest(route: APIRouter.submitFeedback(params: params),completion: completion)
    }
    static func getFeedback(params:[String:Any],completion:@escaping(AFResult<ProfileUpdate>)->Void){
        performRequest(route: APIRouter.submitFeedback(params: params),completion: completion)
    }
    
    //Payment
    static func savePaymentDetails(params:[String:Any],completion:@escaping(AFResult<FeedbackSubmitData>)->Void){
        performRequest(route: APIRouter.savePaymentDetails(params: params),completion: completion)
    }
    
    //Insurance
    static func addInsurance(params:[String:Any],completion:@escaping(AFResult<InsuranceAdd>)->Void){
        performRequest(route: APIRouter.addInsurance(params: params),completion: completion)
    }
    static func editInsurance(params:[String:Any],completion:@escaping(AFResult<InsuranceEdit>)->Void){
        performRequest(route: APIRouter.editInsurance(params: params),completion: completion)
    }
    static func getInsurance(memberId:Int,completion:@escaping(AFResult<GetInsurance>)->Void){
        performRequest(route: APIRouter.getInsurance(memberId: memberId),completion: completion)
    }
    static func deleteInsurance(memberId:Int,completion:@escaping(AFResult<InsuranceDelete>)->Void){
        performRequest(route: APIRouter.deleteInsurance(memberId: memberId),completion: completion)
    }
}

