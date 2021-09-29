//
//  OtpViewModel.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 03/11/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import Foundation
class OTPViewModel {
    //Properties
    private var otpData:OTPData?{
        didSet{
            self.otpVerifySuccess?()
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
    var otpVerifySuccess:(() -> ())?
    var loadingStatus:(() -> ())?
    var errorMessageAlert:(() -> ())?
    
    
    //verify New user
    func verifyOTP(params:Dictionary<String,Any>){
        isLoading = true
        APIClient.verifyRegistrationOTP(params: params){ result in
            switch result {
            case .success(let responseData):
                self.isLoading = false
                if responseData.error ?? "" == ""{
                    switch responseData.statusCode!{
                    case 200..<300:
                        if responseData.status{
                            self.otpData = responseData
                        }else{
                            self.errorMessage = responseData.message
                            self.errorMessageAlert?()
                        }
                    case 400..<500:
                        self.errorMessage = responseData.message
                        self.errorMessageAlert?()
                    default:
                        print("Unknown Error")
                    }
                }else{
                    self.errorMessage = responseData.message
                    self.errorMessageAlert?()
                }
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                self.error = error
                self.isLoading = false
            }
        }
    }
}
