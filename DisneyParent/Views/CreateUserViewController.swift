//
//  CreateUserViewController.swift
//  DisneyParent
//
//  Created by Bradley Yin on 7/30/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

class CreateUserViewController: UIViewController {

    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    
    //Properties
    let loginController = LoginController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func createNewUser(){
        guard let username = usernameTextfield.text, !username.isEmpty, let password = passwordTextfield.text, !password.isEmpty else { return }
        let newUser = User(username: username, password: password)
        loginController.signUp(with: newUser) { (error) in
            if error != nil{
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
        
        
    }

}
