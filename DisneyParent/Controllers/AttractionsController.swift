//
//  ActtractionsController.swift
//  PracticeDisneyParent
//
//  Created by Nathan Hedgeman on 7/31/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

class AttractionController {
    
    var token: Token?
    
    var allAttactions: [Attraction] = []
    
    //Functions
    func fetchAllAttractions(completion: @escaping (Result<[Attraction], NetworkError>) -> Void) {
        
        //guard let token = self.token else { completion(.failure(.noAuthorization)); return }
        
        let allAttractionsURL = TicketController.baseURL.appendingPathComponent("json")
        
        var request = URLRequest(url: allAttractionsURL)
        request.httpMethod = HTTPMethod.get.rawValue
        //request.addValue("Bearer \(token.token)", forHTTPHeaderField: "Authorization")
        
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
                
                let networkAttractions = try decoder.decode([Attraction].self, from: data)
                self.allAttactions = networkAttractions
                completion(.success(self.allAttactions))
                
            } catch {
                
                NSLog("Error decoding ticket: \(error)")
                completion(.failure(.noDecode))
                return
                
            }
            }.resume()
    }
}
