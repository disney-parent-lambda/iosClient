//
//  Ticket.swift
//  DisneyParent
//
//  Created by Nathan Hedgeman on 7/29/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

class Ticket {
    
    let id: UUID
    let name: String
    let location: String
    let time: Date
    let numberOfKids: Int
    let message: String
    
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
