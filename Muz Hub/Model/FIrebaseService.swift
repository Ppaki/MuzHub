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
            let fav = value?["favorite"] as? NSDictionary
            let favArray = fav?.allKeys as! Array<String>
            let provider = value?["provider"] as? String ?? ""
            let email = Auth.auth().currentUser?.email
            self._user = User(name: name, email: email!, uid: uid, provider: provider, favInstitutions: favArray)
        }
    }
    
    var user: User {
        return _user
    }
}
