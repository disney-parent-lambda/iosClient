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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func createNewUser(){
        guard let username = usernameTextfield.text, !username.isEmpty, let password = passwordTextfield.text, !password.isEmpty else { return }
        
        
    }

    @IBAction func ceateTapped(_ sender: Any) {
    }


}
