//
//  PasswordViewModel.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 03/11/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import Foundation

class PasswordViewModel {
    //Properties
    private var passwordData:PasswordData?{
        didSet{
            self.passwordSetSuccess?()
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
    var passwordSetSuccess:(() -> ())?
    var loadingStatus:(() -> ())?
    var errorMessageAlert:(() -> ())?
    
    
    //set new password
    func setPassword(params:Dictionary<String,Any>){
        isLoading = true
        APIClient.setPassword(params: params){ result in
            switch result {
            case .success(let responseData):
                self.isLoading = false
                if responseData.error ?? "" == ""{
                    switch responseData.statusCode ?? 200
                    {
                    case 200..<300:
                        if responseData.status
                        {
                            self.passwordData = responseData
                        }
                        else
                        {
                            self.errorMessage = responseData.message
                            self.errorMessageAlert?()
                            print(responseData)
                        }
                    case 400..<500:
                        self.errorMessage = responseData.message
                        self.errorMessageAlert?()
                    default:
                        print("Unknown Error")
                    }
                }else{
                    
                }
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                self.error = error
                self.isLoading = false
            }
        }
    }
}
