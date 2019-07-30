//
//  User.swift
//  DisneyParent
//
//  Created by Nathan Hedgeman on 7/29/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

class User {
    
    let username: String
    let password: String
    let auth:     String
    
    init(username: String, password: String, auth: String) {
        
        self.username = username
        self.password = password
        self.auth     = auth
        
    }
    
}
