//
//  TicketDetailsViewController.swift
//  DisneyParent
//
//  Created by Bradley Yin on 7/30/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

class TicketDetailsViewController: UIViewController {
    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var locationTextfield: UITextField!
    @IBOutlet weak var timeTextfield: UITextField!
    @IBOutlet weak var numberOfChildrenTextfield: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var fromAdd = false
    var fromMyTicket = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if fromAdd{
            saveButton.title = "Submit"
            title = "Create new ticket"
        }
        if fromMyTicket && !fromAdd{
            saveButton.title = "Save"
            title = "name of ticket"
        }
        if !fromMyTicket{
            saveButton.title = "Accept"
            title = "name of ticket"
        }

        // Do any additional setup after loading the view.
    }
    



}
