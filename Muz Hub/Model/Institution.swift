//
//  Institution.swift
//  Muz Hub
//
//  Created by Aqib Shehri on 10/30/17.
//  Copyright © 2017 Aqib Shehri. All rights reserved.
//

import Foundation
import CoreLocation

class Institution {
    
    private var _id: String = ""
    private var _name: String = ""
    private var _info: String = ""
    private var _location: CLLocation!
    private var _street: String = ""
    private var _city: String = ""
    private var _state: String = ""
    private var _zip: String = ""
    private var _country: String = ""
    
    var id: String {
        return self._id
    }
    
    var name: String {
        return self._name
    }
    
    var info: String {
        return self._info
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
    
    var zip: String {
        return self._zip
    }
    
    var country: String {
        return self._country
    }
    
    init(id: String, name: String, info: String) {
        self._id = id
        self._name = name
        self._info = info
    }
    
    func updateAddress(location: CLLocation) {
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
            
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            // Street number and road
            if let locationName = placeMark.name as NSString? {
                self._street += "\(locationName)"
            }
            // City
            if let city = placeMark.locality as NSString? {
                self._city = city as String
            }
            // State
            if let state = placeMark.administrativeArea as NSString? {
                self._state = state as String
            }
            // Zip code
            if let zip = placeMark.postalCode as NSString? {
                self._zip = zip as String
            }
            // Country
            if let country = placeMark.country as NSString? {
                self._country = country as String
            }
        }
    }
}
