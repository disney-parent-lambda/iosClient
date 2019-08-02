//
//  ActtractionsController.swift
//  PracticeDisneyParent
//
//  Created by Nathan Hedgeman on 7/31/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

class AttractionController {
    
    
    var allAttactions: [Attraction] = []
    
    //Functions
    func fetchAllAttractions(completion: @escaping (Result<[Attraction], NetworkError>) -> Void) {
        
        let allAttractionsURL = TicketController.baseURL.appendingPathExtension("restaurants/restaurants")
        
        var request = URLRequest(url: allAttractionsURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("bearer \(currentToken?.accessToken ?? "")", forHTTPHeaderField: "Authorization")
        
        
//        //Backup
        if let path = Bundle.main.path(forResource: "restaurant", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                allAttactions = try JSONDecoder().decode([Attraction].self, from: data)

                completion(.success(self.allAttactions))
            } catch {
                NSLog("Error decoding restaurant: \(error)")
                completion(.failure(.noDecode))
                return
            }
        }
        
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
//                //String(data:data,encoding:.utf8)
//                self.allAttactions = try decoder.decode([Attraction].self, from: data)
//                
//                completion(.success(self.allAttactions))
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
