//
//  TicketDetailsViewController.swift
//  DisneyParent
//
//  Created by Bradley Yin on 7/30/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

class TicketDetailsViewController: UIViewController {
    
    //Propeties
    var ticket: Ticket?
    var ticketController: TicketController?
    
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
            nameTextfield.text = ticket?.username
            locationTextfield.text = ticket?.location
            timeTextfield.text = ticket?.time
            numberOfChildrenTextfield.text = ticket?.numberOfKids
        }
        if !fromMyTicket{
            saveButton.title = "Accept"
            title = "name of ticket"
            nameTextfield.text = ticket?.username
            locationTextfield.text = ticket?.location
            timeTextfield.text = ticket?.time
            numberOfChildrenTextfield.text = ticket?.numberOfKids
        }

        // Do any additional setup after loading the view.
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextfield.text,
              let location = locationTextfield.text,
              let time = timeTextfield.text,
              let childen = numberOfChildrenTextfield.text else {return}
        
        if fromAdd {
            
            ticketController?.createTicket(with: name, location: location, time: time, numberOfKids: childen, completion: { (_) in })
                
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            
        }
        
        if fromMyTicket && !fromAdd {
            ticketController?.updateTicket(ticket: ticket!, title: name, location: location, time: time, children: childen)
            
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        if !fromMyTicket {
            ticketController?.toggleAcceptTicket(ticket: ticket!)
            
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    



}
