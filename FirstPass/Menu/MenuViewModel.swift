//
//  ProfileViewModel.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 05/11/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import Foundation
import RealmSwift
class MenuViewModel{
    //Properties
    var menuItems = [MenuItems]()
    
    //Closures for callback
    var removeUserDataSuccess:(() -> ())?
    
    func getMenuItems(){
        menuItems = [MenuItems(name: "Profile", image: "profile"),
                     MenuItems(name: "Alerts and Notifications", image: "notification"),
                     MenuItems(name: "Family members", image: "familyMembers"),
                     MenuItems(name: "Appointment details", image: "appointmentDetails"),
                     MenuItems(name: "Payment", image: "payment"),
                     MenuItems(name: "Reports", image: "reports"),
                     MenuItems(name: "Indoor map", image: "reports"),
                     MenuItems(name: "Chat with us", image: "chat"),
                     MenuItems(name: "Book Appointments", image: "appointmentDetails")
                     ]
    }
    func removeUserData(){
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
//            let queue = DispatchQueue(label: "queue")
//            queue.asyncAfter(deadline: .now() + 0.2) {
//                
//            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.removeUserDataSuccess?()
            }
        }
    }
    
}
