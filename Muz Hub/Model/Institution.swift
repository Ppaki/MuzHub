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
    private var _url: String = ""
    private var _name: String = ""
    private var _location: CLLocation!
    private var _schedule: NSDictionary
    private var _info: String = ""
    private var _street: String = ""
    private var _city: String = ""
    private var _state: String = ""
    private var _zip: String = ""
    private var _country: String = ""
    
    var id: String {
        return self._id
    }
    
    var url: String {
        return _url
    }
    
    var name: String {
        return self._name
    }
    
    var location: CLLocation {
        return self._location
    }
    
    var schedule: NSDictionary {
        return self._schedule
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
    
    init(id: String, name: String, location: CLLocation, schedule: NSDictionary, info: String) {
        self._id = id
        self._url = "intitute\(id)"
        self._name = name
        self._location = location
        self._schedule = schedule
        self._info = info
        
        updateAddress()
    }
    
    func updateAddress() {
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(self._location) { (placemarks, error) in
            
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            
            // Location name
            if let locationName = placeMark.name as NSString? {
                self._street += "\(locationName)"
            }
            /*/ Street address
            if let street = placeMark.thoroughfare as NSString? {
                self._street += " \(street)"
            }*/
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
