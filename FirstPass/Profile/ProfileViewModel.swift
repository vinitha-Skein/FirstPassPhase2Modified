
import Foundation
import RealmSwift
class ProfileViewModel
{
    //Properties
    var userProfileDetails = LoginUserDataRealm()
    
    var userProfileData:ProfileUpdate?{
        didSet{
            self.updateSuccess?()
        }
    }
    var userProfileImageData:ProfileImageUpdate?{
        didSet{
            self.updateImageSuccess?()
        }
    }
    var familyMemberData:[FamilyMembersList]?{
        didSet{
            self.fetchFamilySuccess?()
        }
    }
    var sendOTPData:SendPasswordChangeOTP?{
        didSet{
            self.otpSendSuccess?()
        }
    }
    var verifyOTPData:VerifyPasswordChangeOTP?{
        didSet{
            self.otpVerifySuccess?()
        }
    }
    var setPasswordData:SetNewPassword?{
        didSet{
            self.passwordChangeSuccess?()
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
    var updateSuccess:(() -> ())?
    var updateImageSuccess:(() -> ())?
    var loadingStatus:(() -> ())?
    var errorMessageAlert:(() -> ())?
    var otpSendSuccess:(() -> ())?
    var otpVerifySuccess:(() -> ())?
    var passwordChangeSuccess:(() -> ())?
    var fetchUserProfileSuccess:(() -> ())?
    var fetchFamilySuccess:(() -> ())?
    
    
    func getUserProfileData()
    {
        let realm = try! Realm()
        let userData = realm.objects(LoginUserDataRealm.self)
        for list in userData{
            userProfileDetails = list
        }
        let queue = DispatchQueue(label: "queue")
        queue.asyncAfter(deadline: .now() + 0.2) {
            self.fetchUserProfileSuccess?()
        }
    }
    
    //get all family members
    func fetchFamilyMember(userId:Int)
    {
        isLoading = true
        APIClient.getFamilyMembers(userId: userId){ result in
            switch result {
            case .success(let responseData):
                self.isLoading = false
                if responseData.error ?? "" == ""{
                    switch responseData.statusCode!{
                    case 200..<300:
                        if responseData.status
                        {
                            self.familyMemberData = responseData.familyMembers
                        }
                    case 400..<500:
                        self.errorMessage = responseData.message
                    default:
                        print("Unknown Error")
                    }
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
    //get all family members
    func updateProfile(params:[String:Any]){
        isLoading = true
        APIClient.updateProfile(params:params){ result in
            switch result {
            case .success(let responseData):
                self.isLoading = false
                if responseData.error ?? "" == ""{
                    switch responseData.statusCode!{
                    case 200..<300:
                        if responseData.status{
                            self.userProfileData = responseData
                        }
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
    
    //get all family members
    func updateProfileImage(userId:Int,params:[String:Any]){
        isLoading = true
        APIClient.updateProfileImage(userId: 9, params: params){ result in
            switch result {
            case .success(let responseData):
                self.isLoading = false
                if responseData.error ?? "" == ""{
                    switch responseData.statusCode!{
                    case 200..<300:
                        if responseData.status{
                            self.userProfileImageData = responseData
                        }
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
    //Remove family member
    func sendOTP(params:[String:Any]){
        isLoading = true
        APIClient.sendOTP(params: params){ result in
            switch result {
            case .success(let responseData):
                self.isLoading = false
                if responseData.error ?? "" == ""{
                    switch responseData.statusCode!{
                    case 200..<300:
                        if responseData.status{
                            self.sendOTPData = responseData
                        }else{
                           self.errorMessage = responseData.messages
                        }
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
                self.errorMessage = error.localizedDescription
                self.error = error
                self.isLoading = false
            }
        }
    }
    
    //Remove family member
    func verifyOTP(params:[String:Any]){
        isLoading = true
        APIClient.verifyOTP(params: params){ result in
            switch result {
            case .success(let responseData):
                self.isLoading = false
                if responseData.error ?? "" == ""{
                    switch responseData.statusCode!{
                    case 200..<300:
                        if responseData.status{
                            self.verifyOTPData = responseData
                        }else{
                           self.errorMessage = responseData.messages
                        }
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
                self.isLoading = false
                self.errorMessage = error.localizedDescription
                self.error = error
            }
        }
    }
    
    //Remove family member
    func setNewPassword(params:[String:Any]){
        isLoading = true
        APIClient.setNewPassword(params: params){ result in
            switch result {
            case .success(let responseData):
                self.isLoading = false
                if responseData.error ?? "" == ""{
                    switch responseData.statusCode!{
                    case 200..<300:
                        if responseData.status{
                            self.setPasswordData = responseData
                        }else{
                           self.errorMessage = responseData.messages
                        }
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
