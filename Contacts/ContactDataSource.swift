//
//  ContactDataSource.swift
//  Contacts
//
//  Created by toby tang on 2017-12-10.
//  Copyright © 2017 Toby Tang. All rights reserved.
//

import Foundation
import UIKit



class ContactDataSource: NSObject, UITableViewDataSource {
    private var sectionedData: [[Contact]]
    let sectionTitles: [String]
    
    init(sectionData: [[Contact]], sectionTitles: [String])
    {
        self.sectionedData = sectionData
        self.sectionTitles = sectionTitles
        
        super.init()
    }
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionedData.count
    }
    
    //MARK: -Data Source
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionTitles
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sectionedData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let contactCell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell else { fatalError() }
        
        let contact = sectionedData[indexPath.section][indexPath.row]
        
        contactCell.profileImageView.image = contact.image
        contactCell.nameLabel.text = "\(contact.firstName)"
        contactCell.cityLabel.text = contact.city
        
        
        if contact.favorite == true {
            print("kkk")
            contactCell.favoriteView.image = #imageLiteral(resourceName: "Star")
        }
        
        if contact.favorite == false {
            contactCell.favoriteView.image = nil
        }
        
        print("isFavorate \(contact.favorite), section: \(indexPath.section), row: \(indexPath.row)")
        
        
        return contactCell
    }
    
    //Mark: Helper Methods
    
    func object(at indexPath: IndexPath) -> Contact {
        return sectionedData[indexPath.section][indexPath.row]
    }
    
    func indexPath(for contact: Contact) -> IndexPath? {
        for (index, contacts) in sectionedData.enumerated() {
            if let indexOfContact = contacts.index(of: contact){
                return IndexPath(row: indexOfContact, section: index)
            }
        }
        
        return nil
    }
    
    func updateContact(_ contact: Contact, at indexPath: IndexPath){
        sectionedData[indexPath.section][indexPath.row] = contact
    }
}

