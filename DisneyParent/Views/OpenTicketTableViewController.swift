//
//  OpenTicketTableViewController.swift
//  DisneyParent
//
//  Created by Bradley Yin on 7/30/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

class OpenTicketTableViewController: UITableViewController {
<<<<<<< HEAD

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
=======
    
    //Properties
    let ticketController = TicketController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        ticketController.fetchAllTickets { (_) in
            print(self.ticketController.allTickets)
        }
>>>>>>> codeDevelopment
    }
    
    
    
    
    // MARK: - Table view data source
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //
    //        return 0
    //    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ticketController.allTickets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TicketCell", for: indexPath)
        
        let ticket = ticketController.allTickets[indexPath.row]
        cell.textLabel?.text = ticket.title
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let detailVC = segue.destination as? TicketDetailsViewController else {return}
        
        if segue.identifier == "OpenTicketDetailShowSegue" {
            detailVC.fromMyTicket = false
            
            guard let indexPath = self.tableView.indexPathForSelectedRow else {return}
            
            let ticket = ticketController.allTickets[indexPath.row]
            detailVC.ticket = ticket
            
            detailVC.ticketController = ticketController
            //print("openticket")
        }
    }
    func loadTicket(){
        //api calls
        
    }
}
extension OpenTicketTableViewController: UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //filter search result here
        print("search")
    }
}
