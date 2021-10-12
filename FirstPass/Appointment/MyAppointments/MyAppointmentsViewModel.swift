//
//  MyAppointmentsViewModel.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 06/11/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import Foundation
import Alamofire
class MyAppointmentsViewModel {
    //Properties
    var allAppointments:GetActiveAppointments?{
        didSet{
            self.fetchAllSuccess?()
        }
    }
    var activeAppointments:GetActiveAppointments?{
        didSet{
            self.fetchActiveSuccess?()
        }
    }
    
    var error:Error?{
        didSet{self.errorMessageAlert?()}
    }
    var errorMessage:String?
    
    var isLoading: Bool = false{
        didSet{self.loadingStatus?()}
    }
    
    //Closures for callback
    var fetchAllSuccess:(() -> ())?
    var fetchActiveSuccess:(() -> ())?
    var loadingStatus:(() -> ())?
    var errorMessageAlert:(() -> ())?
    
    
    //Fetch Active Appointments
    func fetchUpcomingAppointments(userId:Int){
        isLoading = true
        APIClient.getActiveAppointments(){ result in
            switch result {
            case .success(let responseData):
                self.isLoading = false
                if responseData.error ?? "" == ""{
                    switch responseData.statusCode!{
                    case 200..<300:
                        if responseData.status ?? false{
                            self.activeAppointments = responseData
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
    
    //fetch All Appointments
    func fetchAllAppointments(){
        isLoading = true
    APIClient.getActiveAppointments(){ result in
        switch result {
        case .success(let responseData):
            self.isLoading = false
            if responseData.error ?? "" == ""{
                if responseData.status ?? false{
                    self.allAppointments = responseData
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
}
