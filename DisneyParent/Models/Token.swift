//
//  Token.swift
//  DisneyParent
//
//  Created by Nathan Hedgeman on 7/29/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation
public struct Token: Codable {
    
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let scope: String
    
}

public var currentToken: Token?


