//
//  AddMemberViewModel.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 04/11/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import Foundation
import  RealmSwift
import Alamofire
class AddMemberViewModel{
    //Properties
    var addedMemberData:AddFamilyMember?{
        didSet{
            self.addMemberSuccess?()
        }
    }
    var editedMemberData:UpdateMember?{
        didSet{
            self.editMemberSuccess?()
        }
    }
    var error:Error?{
        didSet{self.errorMessageAlert?()}
    }
    var errorMessage:String?
    
    var isLoading: Bool = false{
        didSet{self.loadingStatus?()}
    }
    var familyMemberList = FamilyMemberList(members: ["Father","Mother","Brother","Sister","Wife","Son","Daughter"])
    
    //Closures for callback
    var addMemberSuccess:(() -> ())?
    var loadingStatus:(() -> ())?
    var errorMessageAlert:(() -> ())?
    var editMemberSuccess:(() -> ())?

    
    var userId:Int?
        func getUserDetails(){
            let realm = try! Realm()
            let userData = realm.objects(LoginUserDataRealm.self)
            for list in userData{
                userId = list.userId
            }
        }
    //add New family member
    func addFamilyMember(params:[String:Any]){
        isLoading = true
        APIClient.addFamilyMember(params: params){ result in
            switch result {
            case .success(let responseData):
                self.isLoading = false
                
                    if responseData.status ?? false
                    {
                        self.addedMemberData = responseData
                    }
                    else
                    {
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
    
    //update family member
    func editFamilyMember(userId:Int,params:[String:Any]){
        isLoading = true
        APIClient.editFamilyMember(userId: userId, params: params){ result in
            switch result {
            case .success(let responseData):
                self.isLoading = false
//                switch responseData.statusCode {
//                case 200..<300:
//                    if responseData.status ?? false{
//                        self.editedMemberData = responseData.self
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
}
