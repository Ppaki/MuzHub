//
//  User.swift
//  Muz Hub
//
//  Created by Aqib Shehri on 10/30/17.
//  Copyright © 2017 Aqib Shehri. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import MapKit

class User {
    
    private var _name: String = ""
    private var _email: String = ""
    private var _uid: String = ""
    private var _url: String! = ""
    private var _provider: String = ""
    private var _favInstitutions: Array<String>!
    private var _institutions = [Institution]()
    
    init(name: String, email: String, uid: String, provider: String, favInstitutions: Array<String>) {
        self._name = name
        self._email = email
        self._uid = uid
        self._url = "user/\(uid)"
        self._provider = provider
        self._favInstitutions = favInstitutions
    }
    
    var name: String {
        return self._name
    }
    
    var uid: String {
        return self._uid
    }
    
    var email: String {
        return self._email
    }
    
    var provider: String {
        return self._provider
    }
    
    var favInstitutions: Array<String> {
        return _favInstitutions
    }
    
    var url: String {
        return _url
    }
    
    var institutions: [Institution] {
        return self._institutions
    }
    
    func loadFavorite(complete: @escaping DownloadCompleted, atRow: Int) {
        var institute: Institution!
        let ref = Database.database().reference()
        let key = _favInstitutions[atRow]
        
        ref.child("institution").child(key).observeSingleEvent(of: .value) { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let name = value?["name"] as? String ?? ""
            let info = value?["info"] as? String ?? ""
            let locationString = value?["location"] as! NSDictionary
            let latitude = locationString["latitude"] as! CLLocationDegrees
            let longtitude = locationString["longitude"] as! CLLocationDegrees
            let location = CLLocation(latitude: latitude, longitude: longtitude)
            let schedule = value?["schedule"] as! NSDictionary
            
            institute = Institution(id: key, name: name, location: location, schedule: schedule, info: info)
            self._institutions.append(institute)
            complete()
        }
    }
}
