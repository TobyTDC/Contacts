//
//  ContactListController.swift
//  Contacts
//
//  Created by toby tang on 2017-12-09.
//  Copyright © 2017 Toby Tang. All rights reserved.
//

import UIKit

extension Contact {
    var firstLetterForSort: String {
        return String(firstName.characters.first!).uppercased()
    }
}

extension ContactsSource {
    static var sortedUniqueFirstLetters: [String] {
        let firstLetters = contacts.map { $0.firstLetterForSort }
        let uniqueFirstLetters = Set(firstLetters)
        return Array(uniqueFirstLetters).sorted()
    }
    
    static var sectionedContacts: [[Contact]]{
        return sortedUniqueFirstLetters.map { firstLetter in
            let filteredContacts = contacts.filter { $0.firstLetterForSort == firstLetter }
                return filteredContacts.sorted(by: { $0.firstName < $1.firstName })
                
            
        }
    }
}

class ContactListController: UITableViewController {

    let dataSource = ContactDataSource(sectionData: ContactsSource.sectionedContacts, sectionTitles: ContactsSource.sortedUniqueFirstLetters)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = dataSource
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

   
    //Tableview Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showContact" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let contact = dataSource.object(at: indexPath)
                
                guard let navigationController = segue.destination as? UINavigationController, let contactDetailController = navigationController.topViewController as? ContactDetailController else { return }
                contactDetailController.contact = contact
                contactDetailController.delegate = self
            }
        }
    }
}

extension Contact: Equatable {
    static func ==(lhs: Contact, rhs: Contact) -> Bool {
        return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName && lhs.street == rhs.street && lhs.city == rhs.city && lhs.state == rhs.state && lhs.zip == rhs.zip && lhs.phone == rhs.phone && lhs.email == rhs.email
    }
}

extension ContactListController: ContactDetailControllerDelegate {
    func didMarkAsFavorite(_ contact: Contact) {
        guard let indexPath = dataSource.indexPath(for: contact) else {
            return
        }
        
        var favoriteContact = dataSource.object(at: indexPath)
        favoriteContact.favorite = true
        
        dataSource.updateContact(favoriteContact, at: indexPath)
            
            print("fn called")
        tableView.reloadData()
            
    }
}
