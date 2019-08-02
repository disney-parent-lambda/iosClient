//
//  MyTicketTableViewController.swift
//  DisneyParent
//
//  Created by Bradley Yin on 7/30/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

class MyTicketTableViewController: UITableViewController {
    
    
    //Properties
    let ticketController = TicketController()

    override func viewDidLoad() {
        super.viewDidLoad()

        ticketController.fetchMyTickets { (_) in
            print(self.ticketController.myTickets)
        }
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTicketCell", for: indexPath)
        
        let ticket = ticketController.myTickets[indexPath.row]
        cell.textLabel?.text = ticket.title
        
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ticketController.myTickets.count
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let detailVC = segue.destination as? TicketDetailsViewController else {return}
        
        if segue.identifier == "MyTicketDetailShowSegue"{
            
            detailVC.fromMyTicket = true
            detailVC.fromAdd = false
            
            
            guard let indexPath = self.tableView.indexPathForSelectedRow else {return}
            
            let ticket = ticketController.myTickets[indexPath.row]
            detailVC.ticket = ticket
            
            detailVC.ticketController = ticketController
            
        }else{
            
            detailVC.fromMyTicket = true
            detailVC.fromAdd = true
            
            
            detailVC.ticketController = ticketController
        }
        
        
        
    
    }

}
