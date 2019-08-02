//
//  LoginViewController.swift
//  DisneyParent
//
//  Created by Bradley Yin on 7/30/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    


    

    //Properties
    var loginController = LoginController()
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    


    @IBAction func loginButtonTapped(_ sender: Any) {
        
        
        if let username = self.usernameTextField.text, !username.isEmpty,
            let password = self.passwordTextField.text, !password.isEmpty {
            let user = User(username: username, password: password)
            
            
            loginController.signIn(with: user) { (error) in
                if let error = error {
                    NSLog("Error occurred during sign up: \(error)")
                } else {
                    performSegue(withIdentifier: "loginShowSegue", sender: self)
                }
            }
        }
    }
    
    
    
    @IBAction func createAccountButtonTapped(_ sender: Any) {
    }
    
}
