//
//  InstitutionSchedule.swift
//  Muz Hub
//
//  Created by Aqib Shehri on 2/7/18.
//  Copyright © 2018 Aqib Shehri. All rights reserved.
//

import Foundation

class InstitutionSchedule {
    
    private var _id: String = ""
    private var _schedule: NSDictionary
    
    init(id: String, schedule: NSDictionary) {
        self._id = id
        self._schedule = schedule
    }
    
    var id : String {
        return _id
    }
    
    var schedule: NSDictionary {
        return _schedule
    }
    
}
