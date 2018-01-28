//
//  Post.swift
//  Muz Hub
//
//  Created by Aqib Shehri on 10/30/17.
//  Copyright © 2017 Aqib Shehri. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Post {
    
    private var _id: String = ""
    private var _url: String = ""
    private var _timestamp: String = ""
    private var _post: String = ""
    private var _likes: Int = 0
    private var _instituteID: String = ""
    
    init(id: String, timestamp: String, post: String, likes: Int, instituteID: String) {
        self._id = id
        self._url = "post\(id)"
        self._timestamp = timestamp
        self._post = post
        self._likes = likes
        self._instituteID = instituteID
    }
    
    var id: String {
        return _id
    }
    
    var url: String {
        return _url
    }
    
    var timestamp: String{
        return _timestamp
    }
    
    var post: String {
        return _post
    }
    
    var likes: Int {
        return _likes
    }
    
    var instituteID: String {
        return _instituteID
    }
    
    
}
