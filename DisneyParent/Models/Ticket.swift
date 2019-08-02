//
//  Ticket.swift
//  DisneyParent
//
//  Created by Nathan Hedgeman on 7/29/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

class Ticket: Codable {
    
    var userid: Int?
    var title: String
    var location: String
    var message: String?
    var isOpen: Bool = true
    var time: String
    var numberOfKids: String
    var accepted: Bool = false
    var username: String?

    
    
    init(title: String, location: String, time: String, numberOfKids: String ) {
        
        self.title = title
        self.location = location
        self.time = time
        self.numberOfKids = numberOfKids
        //added a message property to allow users to describe how to find them at the location
        //self.message = message
        
    }
}
