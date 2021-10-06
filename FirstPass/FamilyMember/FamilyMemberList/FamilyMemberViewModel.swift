//
//  FamilyMemberViewModel.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 04/11/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import Foundation
import RealmSwift
class FamilyMemberViewModel{
    //Properties
    var familyMemberData:[FamilyMembersList]?{
        didSet{
            self.dataFetchSuccess?()
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
    var dataFetchSuccess:(() -> ())?
    var loadingStatus:(() -> ())?
    var errorMessageAlert:(() -> ())?
    var deleteSuccess:(() -> ())?

    
    var userId:Int?
        func getUserDetails(){
            let realm = try! Realm()
            let userData = realm.objects(LoginUserDataRealm.self)
            for list in userData{
                userId = list.userId
            }
        }
    //get all family members
    func fetchFamilyMember(){
        isLoading = true
        APIClient.getFamilyMembers(){ result in
            switch result {
            case .success(let responseData):
                self.isLoading = false
                if responseData.status ?? false
                {
                    
                    self.familyMemberData = responseData.members
                }
                else
                {
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
    
        //Remove family member
//    func removeFamilyMember(userId:Int,memberId:Int){
//            isLoading = true
//            APIClient.deleteFamilyMember(userId: userId, memberId: memberId){ result in
//                switch result {
//                case .success(let responseData):
//                    self.isLoading = false
//                    if responseData.status ?? false{
//                        self.deleteSuccess?()
//                    }else{
//                        self.errorMessage = responseData.messages
//                        self.errorMessageAlert?()
//                    }
//                case .failure(let error):
//                    self.errorMessage = error.localizedDescription
//                    print(error.localizedDescription)
//                    self.error = error
//                    self.isLoading = false
//                }
//            }
//        }
}
