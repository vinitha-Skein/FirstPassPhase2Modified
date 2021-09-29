//
//  AppointmentDetailsViewModel.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 27/11/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import Foundation
import RealmSwift
class AppointmentDetailsViewModel{
    var error:Error?{
        didSet{self.errorMessageAlert?()}
    }
    var errorMessage:String?
    var isLoading: Bool = false{
        didSet{self.loadingStatus?()}
    }
    var userName = String()
    var userId = Int()
    var pId = Int()
    var appointmentDate = String()
    var appointmentTime = String()

    
    //Closures for callback
    var cancelSuccess:(() -> ())?
    var loadingStatus:(() -> ())?
    var errorMessageAlert:(() -> ())?

    
    func getUserDetails(){
            let realm = try! Realm()
            let userData = realm.objects(LoginUserDataRealm.self)
            for list in userData{
                userId = list.userId
                userName = list.firstName
                pId = list.pId
    //            profileImage = list.profile_pic
    //            familyMembers = list.familyMemberDtoList
            }
    }
        
    //get all family members
    func cancelAppointment(appointmentId:Int){
        isLoading = true
        APIClient.cancelAppointment(appointmentId: appointmentId){ result in
            switch result {
            case .success(let responseData):
                self.isLoading = false
                if responseData.error ?? "" == ""{
                    switch responseData.statusCode!{
                    case 200..<300:
                        self.cancelSuccess?()
                    case 400..<500:
                        self.errorMessage = responseData.messages
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
}
