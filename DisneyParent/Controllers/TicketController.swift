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
    
    var allTickets: [Ticket] = []
    
    var myTickets: [Ticket] = []
    
    static let baseURL = URL(string: "https://disneyparents.herokuapp.com")!
}


//MARK: Network and Data Functions
extension TicketController {
    
    //Creates the ticket and sends it to the API
    func createTicket(with title: String, location: String, time: String, numberOfKids: String, completion: @escaping (Result<[Ticket], NetworkError>) -> Void) {
        
        //guard let token = self.token else { completion(.failure(.noAuthorization)); return }
        
        let ticket = Ticket(title: title, location: location, time: time, numberOfKids: numberOfKids)
        
        let createTicketURL = TicketController.baseURL.appendingPathComponent("json")
        
        var request = URLRequest(url: createTicketURL)
        request.httpMethod = HTTPMethod.post.rawValue
        //request.addValue("Bearer \(token.token)", forHTTPHeaderField: "Authorization")
        
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
            
            self.myTickets.append(ticket)
            completion(.success(self.myTickets))
            }.resume()
    }
    
    
    
    func put(ticketArray: [Ticket], completion: @escaping (Result<[Ticket], NetworkError>) -> Void) {
        
        //guard let token = self.token else { completion(.failure(.noAuthorization)); return }
        
        let putURL = TicketController.baseURL.appendingPathComponent("json")
        
        var request = URLRequest(url: putURL)
        request.httpMethod = HTTPMethod.put.rawValue
        //request.addValue("Bearer \(token.token)", forHTTPHeaderField: "Authorization")
        
        let jsonEncoder = JSONEncoder()
        
        do {
            
            let jsonData = try jsonEncoder.encode(ticketArray)
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
            
            completion(.success(ticketArray))
            }.resume()
    }
    
    
    func updateTicket(ticket: Ticket, title: String, location: String, time: String, children: String) {
        
        ticket.title = title
        ticket.location = location
        ticket.time = time
        ticket.numberOfKids = children
        
        
        put(ticketArray: self.myTickets) {_ in}
    }
    
    
    func toggleAcceptTicket(ticket: Ticket) {
        
        ticket.accepted = !ticket.accepted
        
        put(ticketArray: self.allTickets) {_ in}
    }
    
    
    func fetchAllTickets(completion: @escaping (Result<[Ticket], NetworkError>) -> Void) {
        
        let allTicketsURL = TicketController.baseURL.appendingPathComponent("json")
        
        var request = URLRequest(url: allTicketsURL)
        request.httpMethod = HTTPMethod.get.rawValue
        //request.addValue("Bearer \(token.token)", forHTTPHeaderField: "Authorization")
        
        //Backup
        if let path = Bundle.main.path(forResource: "tickets", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                allTickets = try JSONDecoder().decode([Ticket].self, from: data)
                
                //                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let _ = jsonResult["ticket"] as? [Any] {
                //                    // do stuff
                //                }
                completion(.success(self.allTickets))
            } catch {
                NSLog("Error decoding tickets: \(error)")
                completion(.failure(.noDecode))
                return
            }
        }
            //MARK: Network call for getting all tickets
            //        URLSession.shared.dataTask(with: request) { (data, response, error) in
            //
            //            if let response = response as? HTTPURLResponse,
            //                response.statusCode == 401 {
            //
            //                NSLog("Getting 401 error!")
            //                completion(.failure(.badAuthorization))
            //                return
            //
            //            }
            //
            //            if let _ = error {
            //                completion(.failure(.otherError))
            //                return
            //            }
            //
            //            guard let data = data else { completion(.failure(.badData)); return }
            //
            //            let decoder = JSONDecoder()
            //
            //            do {
            //
            //                let networkTickets = try decoder.decode([Ticket].self, from: data)
            //                self.allTickets = networkTickets
            //                completion(.success(self.allTickets))
            //
            //            } catch {
            //
            //                NSLog("Error decoding ticket: \(error)")
            //                completion(.failure(.noDecode))
            //                return
            //
            //            }
            //            }.resume()
        
        }
    
    func fetchMyTickets(completion: @escaping (Result<[Ticket], NetworkError>) -> Void) {
        
        let myTicketsURL = TicketController.baseURL.appendingPathComponent("json")
        
        var request = URLRequest(url: myTicketsURL)
        request.httpMethod = HTTPMethod.get.rawValue
        //request.addValue("Bearer \(token.token)", forHTTPHeaderField: "Authorization")
        
        //Backup
        if let path = Bundle.main.path(forResource: "myTickets", ofType: "json") {
            do {
                
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                myTickets = try JSONDecoder().decode([Ticket].self, from: data)
                
                completion(.success(self.myTickets))
            } catch {
                NSLog("Error decoding tickets: \(error)")
                completion(.failure(.noDecode))
                return
            }
        }
        //MARK: Network call for getting all tickets
        //        URLSession.shared.dataTask(with: request) { (data, response, error) in
        //
        //            if let response = response as? HTTPURLResponse,
        //                response.statusCode == 401 {
        //
        //                NSLog("Getting 401 error!")
        //                completion(.failure(.badAuthorization))
        //                return
        //
        //            }
        //
        //            if let _ = error {
        //                completion(.failure(.otherError))
        //                return
        //            }
        //
        //            guard let data = data else { completion(.failure(.badData)); return }
        //
        //            let decoder = JSONDecoder()
        //
        //            do {
        //
        //                let networkTickets = try decoder.decode([Ticket].self, from: data)
        //                self.myTickets = networkTickets
        //                completion(.success(self.myTickets))
        //
        //            } catch {
        //
        //                NSLog("Error decoding ticket: \(error)")
        //                completion(.failure(.noDecode))
        //                return
        //
        //            }
        //            }.resume()
        
    }
}
