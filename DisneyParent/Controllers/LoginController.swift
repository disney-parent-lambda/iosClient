//
//  LoginController.swift
//  DisneyParent
//
//  Created by Nathan Hedgeman on 7/29/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "Post"
    case put = "PUT"
}

enum NetworkError: Error {
    case noAuthorization
    case badAuthorization
    case noData
    case badData
    case noEncode
    case noDecode
    case otherError
}

class LoginController {
    
    var token: Token?
    
    static let baseURL = URL(string: "https://disneyparents.herokuapp.com")!
    
}

//MARK: SignUp and SignIn fuctions
extension LoginController {
    
    func signUp(with user: User, completion: @escaping (Error?) -> ()) {
        
        let signUpURL = LoginController.baseURL.appendingPathComponent("createnewuser")
        
        var request = URLRequest(url: signUpURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(user)
            request.httpBody = jsonData
        } catch {
            NSLog("Error encoding user object: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            
            if let error = error {
                completion(error)
                return
            }
            
            completion(nil)
            }.resume()
    }
    
    func signIn(with user: User, completion: @escaping (Error?) -> ()) {
        let loginURL = LoginController.baseURL.appendingPathComponent("login")
        
        var request = URLRequest(url: loginURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(user)
            request.httpBody = jsonData
        } catch {
            print("Error encoding user object: \(error)")
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            
            if let error = error { completion(error); return }
            
            guard let data = data else { completion(NSError()); return }
            
            let decoder = JSONDecoder()
            do {
                self.token = try decoder.decode(Token.self, from: data)
            } catch {
                print("Error decoding token: \(error)")
                completion(error)
                return
            }
            
            completion(nil)
            }.resume()
    }
}
