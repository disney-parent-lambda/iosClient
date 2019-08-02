//
//  User.swift
//  DisneyParent
//
//  Created by Nathan Hedgeman on 7/29/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

class User: Codable {
    
    var userid  : Int?
    var username: String
    var password: String
    

    

    init(username: String, password: String) {
        
        self.username = username
        self.password = password
        
    }
    
    
    
}


