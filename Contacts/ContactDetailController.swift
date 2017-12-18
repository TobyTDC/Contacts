//
//  ContactDetailController.swift
//  Contacts
//
//  Created by toby tang on 2017-12-09.
//  Copyright © 2017 Toby Tang. All rights reserved.
//

import UIKit

protocol ContactDetailControllerDelegate: class {
    func didMarkAsFavorite(_ contact: Contact)
}

class ContactDetailController: UITableViewController {
    
    var contact: Contact?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()

    }
    // OUtlets
    
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var streetAddressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var zipLabel: UILabel!
    
    weak var delegate: ContactDetailControllerDelegate?
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configureView() {
        guard let contact = contact else { return }
        phoneNumberLabel.text = contact.phone
        emailLabel.text = contact.email
        streetAddressLabel.text = contact.street
        cityLabel.text = contact.city
        stateLabel.text = contact.state
        zipLabel.text = contact.zip
        profileView.image = contact.image
        nameLabel.text = "\(contact.firstName) \(contact.lastName)"
    }
    
    @IBAction func markAsFavorite(_ sender: Any) {
        guard let contact = contact else { return }
        delegate?.didMarkAsFavorite(contact)
        print("btn clicked")
        print(contact)
    }
    
    //Mark: - Navigation
    
   
}
