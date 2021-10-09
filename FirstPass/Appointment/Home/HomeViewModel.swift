//
//  HomeViewModel.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 06/11/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import Foundation
import RealmSwift
class HomeViewModel {
    //Properties
    var appointmentData:GetActiveAppointments?{
        didSet{
            self.fetchSuccess?()
        }
    }
    var familyMemberData:[FamilyMembersList]?{
        didSet{
            self.fetchFamilySuccess?()
        }
    }

//    var familyMembers = List<FamilyMemberDtoRealm>()

    var error:Error?{
        didSet{self.errorMessageAlert?()}
    }
    var userId:Int?
    var errorMessage:String?
    var profileImage:String?
    var isLoading: Bool = false{
        didSet{self.loadingStatus?()}
    }
    
    //Closures for callback
    var fetchSuccess:(() -> ())?
    var fetchFamilySuccess:(() -> ())?
    var loadingStatus:(() -> ())?
    var errorMessageAlert:(() -> ())?

    
    func getUserDetails(){
        let realm = try! Realm()
        let userData = realm.objects(LoginUserDataRealm.self)
        for list in userData{
            userId = list.userId
//            profileImage = list.profile_pic
//            familyMembers = list.familyMemberDtoList
            self.fetchFamilySuccess?()
        }
    }
    //Login user
    func fetchUpcomingAppointments(){
        isLoading = true
        APIClient.getActiveAppointments(){ result in
            switch result {
            case .success(let responseData):
                self.isLoading = false
                if responseData.error ?? "" == ""{
                    if responseData.status ?? false{
                        self.appointmentData = responseData
                    }else{
                        self.errorMessage = responseData.message
                        self.errorMessageAlert?()
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
    
    func createCheckin(params:Dictionary<String,Any>){
        isLoading = true
        
        APIClient.checkInAppointment(params:params){ result in
            switch result {
            case .success(let responseData):
                self.isLoading = false
                if responseData.error ?? "" == ""{
                    if responseData.status ?? false{
                        self.fetchSuccess?()
                    }else{
                        self.errorMessage = responseData.messages
                        self.errorMessageAlert?()
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
    
    
        //get all family members
//        func fetchFamilyMember(userId:Int)
//        {
//            isLoading = true
//            APIClient.getFamilyMembers(userId: userId){ result in
//                switch result {
//                case .success(let responseData):
//                    self.isLoading = false
//                    if responseData.error ?? "" == ""{
//                        switch responseData.statusCode!{
//                        case 200..<300:
//                        self.familyMemberData = responseData.familyMembers
//                        self.fetchFamilySuccess?()
//                        case 400..<500:
//                            self.errorMessage = responseData.message
//                        default:
//                            print("Unknown Error")
//                        }
//                    }else{
//                        self.errorMessage = responseData.message
//                        self.errorMessageAlert?()
//                    }
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    self.error = error
//                    self.isLoading = false
//                    self.errorMessage = error.localizedDescription
//                }
//            }
//        }
}
