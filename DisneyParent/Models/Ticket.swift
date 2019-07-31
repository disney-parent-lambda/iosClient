//
//  Ticket.swift
//  DisneyParent
//
//  Created by Nathan Hedgeman on 7/29/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

class Ticket: Codable {
    
    var id: UUID
    var name: String
    var location: String
    var time: Date
    var numberOfKids: Int
    var message: String
    
    init(id: UUID = UUID(), name: String, location: String, time: Date, numberOfKids: Int, message: String ) {
        
        self.id = id
        self.name = name
        self.location = location
        self.time = time
        self.numberOfKids = numberOfKids
        //added a message property to allow users to describe how to find them at the location
        self.message = message
        
    }
}
