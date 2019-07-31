//
//  TicketController.swift
//  DisneyParent
//
//  Created by Nathan Hedgeman on 7/29/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

class TicketController {
    
    var token: Token?
    
    var tickets: [Ticket] = []
    
    static let baseURL = URL(string: "https://disneyparents.herokuapp.com")!
}


//MARK: Network and Data Functions
extension TicketController {
    
    //Creates the ticket and sends it to the API
    func createTicket(with name: String, location: String, time: Date, numberOfKids: Int, message: String, completion: @escaping (Result<[Ticket], NetworkError>) -> Void) {
        
        guard let token = self.token else { completion(.failure(.noAuthorization)); return }
        
        let ticket = Ticket(name: name, location: location, time: time, numberOfKids: numberOfKids, message: message)
        
        let createTicketURL = TicketController.baseURL.appendingPathComponent("ticket")
        
        var request = URLRequest(url: createTicketURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.addValue("Bearer \(token.token)", forHTTPHeaderField: "Authorization")
        
        let jsonEncoder = JSONEncoder()
        
        do {
            
            let jsonData = try jsonEncoder.encode(ticket)
            request.httpBody = jsonData
            
        } catch {
            
            NSLog("Error encoding ticket: \(NSError())")
            completion(.failure(.noEncode))
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                
                completion(.failure(.badAuthorization))
                return
            }
            
            if let _ = error {
                
                completion(.failure(.otherError))
                return
                
            }
            
            self.tickets.append(ticket)
            completion(.success(self.tickets))
            }.resume()
    }
    
    func fetchAllTickets(completion: @escaping (Result<[Ticket], NetworkError>) -> Void) {
        
        guard let token = self.token else { completion(.failure(.noAuthorization)); return }
        
        let allTicketsURL = TicketController.baseURL.appendingPathComponent("tickets")
        
        var request = URLRequest(url: allTicketsURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.addValue("Bearer \(token.token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                
                NSLog("Getting 401 error!")
                completion(.failure(.badAuthorization))
                return
                
            }
            
            if let _ = error {
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else { completion(.failure(.badData)); return }
            
            let decoder = JSONDecoder()
            
            do {
                
                let networkTickets = try decoder.decode([Ticket].self, from: data)
                self.tickets = networkTickets
                completion(.success(self.tickets))
                
            } catch {
                
                NSLog("Error decoding ticket: \(error)")
                completion(.failure(.noDecode))
                return
                
            }
            }.resume()
    }
}
