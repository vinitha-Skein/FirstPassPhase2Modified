//
//  LoginViewModel.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 02/11/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire
class LoginViewModel {
    //Properties
    private var loginUserData:String?{
        didSet{
            self.loginSuccess?()
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
    var loginSuccess:(() -> ())?
    var loadingStatus:(() -> ())?
    var errorMessageAlert:(() -> ())?
    
    
    //Login user
    func loginUser(params:Dictionary<String,Any>){
        isLoading = true
        APIClient.loginUser(params: params){ result in
            switch result {
            case .success(let responseData):
                self.isLoading = false
                if responseData.status != nil
                {
                        if responseData.status{
                            if responseData.access_token != nil
                            {
                                    self.loginUserData = responseData.access_token

                                
//                                let jsonData = try! JSONEncoder().encode(responseData.data)
//                                let decoder = JSONDecoder()
//
//                                do {
//                                    let userData = try decoder.decode(LoginUserDataRealm.self, from: jsonData)
//                                    let realm = try Realm()
//                                    try realm.write {
//                                        realm.add(userData)
//                                        print(realm.objects(LoginUserDataRealm.self))
//
//                                    }
//                                }
//                                catch {
//                                    print(error.localizedDescription)
//                                }
                            }
                            else
                            {
                                self.errorMessage = responseData.message
                                self.errorMessageAlert?()
                            }
                        }else{
                            self.errorMessage = responseData.message
                            self.errorMessageAlert?()
                        }
                    
                    }
                else{
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.errorMessage = error.localizedDescription
                self.error = error
                self.isLoading = false
            }
        }
        
        
        //        let headers: HTTPHeaders = [.contentType("application/json"),.accept("application/json")]
        //        AF.request("http://202.65.159.118:8094/firstpass-app/auth/login", method: .post, parameters:params,headers: headers).responseJSON(completionHandler: {response in
        //            switch response.result{
        //            case .success(let responseData):
        //                print(responseData)
        //            case .failure(let error):
        //                print(error)
        //            }
        //        })
    }
}
