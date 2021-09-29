//
//  RegistrationViewModel.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 02/11/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import Foundation
class RegisterUserViewModel
{
    //Properties
    var registeredData:RegisteredUserData?{
        didSet{
            self.registerSuccess?()
        }
    }
    var registerNewUser:RegisterNewUser?{
        didSet{
            self.registereply?()
        }
    }
    var error:Error?{
        didSet{self.errorMessageAlert?()}
    }
    var errorMessage:String?
    
    var isLoading: Bool = false{
        didSet{self.loadingStatus?()}
    }
    var otp:Int?{
        didSet{self.otpvalue?()}
    }
    //Closures for callback
    var registerSuccess:(() -> ())?
    var loadingStatus:(() -> ())?
    var errorMessageAlert:(() -> ())?
    var otpvalue:(() -> ())?
    var registereply:(() -> ())?

    
    //Register New user
    func registerUser(params:Dictionary<String,Any>){
        isLoading = true
        APIClient.registerUser(params: params){ result in
            switch result {
            case .success(let responseData):
                self.isLoading = false
                if responseData.error ?? "" == ""{
                    switch responseData.statusCode!{
                    case 200..<300:
                        if responseData.status{
                            self.otp = responseData.OTP!
                            print(responseData.OTP!)
                            print(self.otpvalue)
                            self.registerNewUser = responseData
                            self.registeredData = responseData.data
                        }else{
                            //self.errorMessage = responseData.message
                            self.errorMessageAlert?()
                        }
                    case 400..<500:
                        //self.errorMessage = responseData.message
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
}
