//
//  AddAppointmentViewModel.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 06/11/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
class AddAppointmentViewModel {
    //Properties
    var locationData:GetLocation?{
        didSet{
            self.locationFetchSuccess?()
        }
    }
    var familyMemberData:[FamilyMembersList]?{
        didSet{
            self.memberFetchSuccess?()
        }
    }
    var branchData:GetBranch?{
        didSet{
            self.branchFetchSuccess?()
        }
    }
    var serviceData:GetServices?{
        didSet{
            self.serviceFetchSuccess?()
        }
    }
    var doctorData:GetDoctors?{
        didSet{
            self.doctorFetchSuccess?()
        }
    }
    var createdAppointmentData:CreatedAppointmentData?{
        didSet{
            self.appointmentAddSuccess?()
        }
    }
    var error:Error?{
        didSet{
            self.errorMessageAlert?()
        }
    }
    var errorMessage:String?
    
    var isLoading: Bool = false{
        didSet{self.loadingStatus?()}
    }
    
    //Closures for callback]
    var memberFetchSuccess:(() -> ())?
    var locationFetchSuccess:(() -> ())?
    var branchFetchSuccess:(() -> ())?
    var serviceFetchSuccess:(() -> ())?
    var doctorFetchSuccess:(() -> ())?
    var appointmentAddSuccess:(() -> ())?
    var loadingStatus:(() -> ())?
    var errorMessageAlert:(() -> ())?
    
    
    //Login user
    func createAppointment(params:Dictionary<String,Any>){
        isLoading = true
        APIClient.createAppointment(params: params){ result in
            switch result {
            case .success(let responseData):
                self.isLoading = false
                if responseData.error ?? "" == ""{
                    switch responseData.statusCode!{
                    case 200..<300:
                        if responseData.status ?? false{
                            self.createdAppointmentData = responseData.appointment
                        }else{
                            self.errorMessage = responseData.messages
                            self.errorMessageAlert?()
                        }
                    case 400..<500:
                        self.errorMessage = responseData.messages
                        self.errorMessageAlert?()
                    default:
                        print("Unknown Error")
                    }
                }else{
                    self.errorMessage = responseData.message
                    self.errorMessageAlert?()
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.errorMessage = error.localizedDescription
                self.error = error
                self.isLoading = false
            }
        }
    }
    
    //Get Location
    func getAllLocation(){
        isLoading = true
        APIClient.getAllLocation{ result in
            switch result {
            case .success(let responseData):
                self.isLoading = false
                if responseData.error ?? "" == ""{
                    switch responseData.statusCode!{
                    case 200..<300:
                        if responseData.status{
                            self.locationData = responseData.self
                        }else{
                            self.errorMessage = responseData.messages
                            self.errorMessageAlert?()
                        }
                    case 400..<500:
                        self.errorMessage = responseData.messages
                        self.errorMessageAlert?()
                    default:
                        print("Unknown Error")
                    }

                }else{
                    self.errorMessage = responseData.message
                    self.errorMessageAlert?()
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.errorMessage = error.localizedDescription
                self.error = error
                self.isLoading = false
            }
        }
    }
    
    //Get Branches
    func getAllBranches(locationID:Int){
        isLoading = true
        APIClient.getAllBranches(locationID: locationID){ result in
            switch result {
            case .success(let responseData):
                self.isLoading = false
                if responseData.error ?? "" == ""{
                    switch responseData.statusCode!{
                    case 200..<300:
                        if responseData.status{
                            self.branchData = responseData
                        }else{
                            self.errorMessage = responseData.messages
                            self.errorMessageAlert?()
                        }
                    case 400..<500:
                        self.errorMessage = responseData.messages
                        self.errorMessageAlert?()
                    default:
                        print("Unknown Error")
                    }

                }else{
                    self.errorMessage = responseData.message
                    self.errorMessageAlert?()
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.errorMessage = error.localizedDescription
                self.error = error
                self.isLoading = false
            }
        }
    }
    
    func getAllServices(branchID:Int){
        let headers: HTTPHeaders = [
            .authorization(UserDefaults.standard.string(forKey: "Authorization") ?? ""),
                   .accept("application/json")
               ]
//        AF.request("http://202.65.159.118:8094/firstpass-app/location/421/getAllServicesByBranchId", method: .get, headers: headers).responseJSON(completionHandler: {response in
//            print(response)
//        })
        AF.request("\(DataService.developmentBaseURL)location/\(branchID)/getAllServicesByBranchId", method: .get, headers: headers).responseDecodable {(response: DataResponse<GetServices,AFError>) in
            print(response)
            switch response.result {
            case .success(let responseData):
                self.isLoading = false
                if responseData.error ?? "" == ""{
                    switch responseData.statusCode!{
                    case 200..<300:
                        if responseData.statusCode == 200{
                            self.serviceData = responseData
                        }else{
                            self.errorMessage = responseData.messages
                            self.errorMessageAlert?()
                        }
                    case 400..<500:
                        self.errorMessage = responseData.messages
                        self.errorMessageAlert?()
                    default:
                        print("Unknown Error")
                    }
                }else{
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.errorMessage = error.localizedDescription
                self.error = error
                self.isLoading = false
            }
        }
    }
    
    //Get Location
    func getAllDoctors(userId:Int,locationID:Int,serviceID:Int){
        isLoading = true
        APIClient.getDoctors(userId: userId, locationID: locationID, serviceID: serviceID){ result in
            switch result {
            case .success(let responseData):
                self.isLoading = false
//                switch responseData.statusCode {
//                case 200..<300:
//                    if responseData.status{
                        self.doctorData = responseData.self
//                    }else{
//                        self.errorMessage = responseData.messages
//                        self.errorMessageAlert?()
//                    }
//                case 400..<500:
//                    self.errorMessage = responseData.messages
//                    self.errorMessageAlert?()
//                default:
//                    print("Unknown Error")
//                }
            case .failure(let error):
                print(error.localizedDescription)
                self.errorMessage = error.localizedDescription
                self.error = error
                self.isLoading = false
            }
        }
    }
    var userId:Int?
    var userPId:Int?
    var userName:String?
        func getUserDetails(){
            let realm = try! Realm()
            let userData = realm.objects(LoginUserDataRealm.self)
            for list in userData{
                userId = list.userId
                userPId = list.pId
                userName = "\(list.firstName) \(list.lastName)"
    //            profileImage = list.profile_pic
    //            familyMembers = list.familyMemberDtoList
            }
        }
    
    func fetchFamilyMember(userId:Int){
        isLoading = true
        APIClient.getFamilyMembers(userId: userId){ result in
            switch result {
            case .success(let responseData):
                self.isLoading = false
                if responseData.error ?? "" == ""{
                    switch responseData.statusCode!{
                    case 200..<300:
                    self.familyMemberData = responseData.familyMembers
                    self.memberFetchSuccess?()
                    case 400..<500:
                        self.errorMessage = responseData.message
                    default:
                        print("Unknown Error")
                    }
                }else{
                    self.errorMessage = responseData.message
                    self.errorMessageAlert?()
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.error = error
                self.isLoading = false
                self.errorMessage = error.localizedDescription
            }
        }
    }
    //Get get all Services
//    func getAllServices(branchID:Int){
//        isLoading = true
//        APIClient.getAllServices(branchID: branchID){ result in
//            switch result {
//            case .success(let responseData):
//                self.isLoading = false
//                switch responseData.statusCode {
//                case 200..<300:
//                    if responseData.statusCode == 200{
//                        self.serviceData = responseData
//                    }else{
//                        self.errorMessage = responseData.messages
//                        self.errorMessageAlert?()
//                    }
//                case 400..<500:
//                    self.errorMessage = responseData.messages
//                    self.errorMessageAlert?()
//                default:
//                    print("Unknown Error")
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//                self.errorMessage = error.localizedDescription
//                self.error = error
//                self.isLoading = false
//            }
//        }
//    }
}
