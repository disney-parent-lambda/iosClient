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
    case post = "POST"
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
    
    init() {
        loadTokenFromPersistentStore()
    }
    
    
    var token: Token? {
        willSet{
            currentToken = newValue
        }
    }
    
    static let baseURL = URL(string: "https://disneyparents.herokuapp.com")!
    
    private var loginFileURL: URL? {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documentsDirectory.appendingPathComponent("log.plist")
    }
    
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
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic bGFtYmRhLWNsaWVudDpsYW1iZGEtc2VjcmV0", forHTTPHeaderField: "Authorization")
        
        var componets = URLComponents(string: "")
        let grantType = URLQueryItem(name: "grant_type", value: "password")
        let username = URLQueryItem(name: "username", value: user.username)
        let password = URLQueryItem(name: "password", value: user.password)
        
        componets?.queryItems = [grantType, username, password]
        
        var bodyString = componets?.string
        bodyString?.removeFirst()
        
        request.httpBody = bodyString?.data(using: .utf8)
        
//        let jsonEncoder = JSONEncoder()
//        do {
//            let jsonData = try jsonEncoder.encode(user)
//            request.httpBody = jsonData
//        } catch {
//            print("Error encoding user object: \(error)")
//        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            
            if let error = error { completion(error); return }
            
            guard let data = data else { completion(NSError()); return }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                self.token = try decoder.decode(Token.self, from: data)
            } catch {
                print("Error decoding token: \(error)")
                completion(error)
                return
            }
            self.saveTokenToPersistentStore()
            completion(nil)
            }.resume()
    }
    
    func saveTokenToPersistentStore() {
        guard let url = self.loginFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(self.token)
            try data.write(to: url)
        } catch {
            NSLog("Error saving token data: \(error)")
        }
    }
    
    func loadTokenFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = self.loginFileURL,
            fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            token = try decoder.decode(Token.self, from: data)
        } catch {
            NSLog("Error loading token data: \(error)")
        }
    }
}
