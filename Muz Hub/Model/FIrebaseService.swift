//
//  FirebaseService.swift
//  Muz Hub
//
//  Created by Aqib Shehri on 11/16/17.
//  Copyright © 2017 Aqib Shehri. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class FirebaseService {
    
    static var MS = FirebaseService()
    private var _user: User!
    
    func getUser() {
        let ref = Database.database().reference()
        let uid = (Auth.auth().currentUser?.uid)!
        
        ref.child("user").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let name = value?["name"] as? String ?? ""
            let type = value?["type"] as? String ?? ""
            
            let fav = value?["favorite"] as? NSDictionary
            let favArray = fav?.allKeys as! Array<String>
            
            let provider = value?["provider"] as? String ?? ""
            let email = Auth.auth().currentUser?.email
            
            let street = value?["street"] as? String ?? ""
            let city = value?["city"] as? String ?? ""
            let state = value?["state"] as? String ?? ""
            let zipcode = value?["zipcode"] as? String ?? ""
            
            self._user = User(name: name, email: email!, uid: uid, street: street, city: city, state: state, zipcode: zipcode, provider: provider, type: type, favInstitutions: favArray)
        }
    }
    
    func saveUser(userData: [String : Any]) {
        
        let ref = Database.database().reference()
        let uid = (Auth.auth().currentUser?.uid)!
        let childUpdate = ["/user/\(uid)" : userData]
        
        ref.updateChildValues(childUpdate)
    }
    
    var user: User {
        return _user
    }
}
