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
    private var _street: String = ""
    private var _city: String = ""
    private var _state: String = ""
    private var _zipcode: String = ""
    private var _uid: String = ""
    private var _provider: String = ""
    private var _type: String = ""
    private var _favInstitutions: Array<String>!
    private var _institutions = [Institution]()
    
    init(name: String, email: String, uid: String, street: String, city: String, state: String, zipcode: String, provider: String, type: String, favInstitutions: Array<String>) {
        self._name = name
        self._email = email
        self._street = street
        self._city = city
        self._state = state
        self._zipcode = zipcode
        self._uid = uid
        self._provider = provider
        self._type = type
        self._favInstitutions = favInstitutions
    }
    
    var name: String {
        return self._name
    }
    
    var street: String {
        return self._street
    }
    
    var city: String {
        return self._city
    }
    
    var state: String {
        return self._state
    }
    
    var zipcode: String {
        return self._zipcode
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
    
    var type: String {
        return _type
    }
    
    var favInstitutions: Array<String> {
        return _favInstitutions
    }
    
    var institutions: [Institution] {
        return self._institutions
    }
}
