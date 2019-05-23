//
//  ViewController.swift
//  iSpaceLab
//
//  Created by Ho Dac Hung on 4/24/19.
//  Copyright © 2019 Ho Dac Hung. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UITableViewController {
    let cellID = "cellID"
    let names = [
        ExpandableNames(isExpanded: true, names: ["An", "Anh"]),
        ExpandableNames(isExpanded: true, names: ["Bảo", "Bắc", "Bình"]),
        ExpandableNames(isExpanded: true, names: ["Mẫn", "Minh"]),
        ExpandableNames(isExpanded: true, names: ["Pháp", "Phương"]),
    ]

    var isLeft = true
    @objc func handleReload(){
        var indexPathToReload = [IndexPath]()
        for section in names.indices{
            for row in names[section].indices{
                let indexPath = IndexPath(row: row, section: section)
                indexPathToReload.append(indexPath)
            }
        }
        isLeft = !isLeft
        let animationStyle = isLeft ? UITableView.RowAnimation.left : .right
        tableView.reloadRows(at: indexPathToReload, with: animationStyle)
    }

    @objc func handleExpandClose(button: UIButton){
        let section = button.tag
        var indexPaths = [IndexPath]()
        for row in names[section]names.indices{
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }

        let isExpanded = names[section].isExpanded
        names[section].isExpanded = !isExpanded

        button.setTitle(isExpanded ? "Open" : "Close", for: .normal)

        if(isExpanded){
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }

    func someMethodIWantToCall(cell: UITableViewCell){
        guard let indexPathTapped = tableView.indexPath(for: cell) else { return }

        let contact = 
            twoDimensionalArray[indexPathTapped.section].names[indexPathTapped.row]
        print(contact)

        let hasFavorited = contact.hasFavorited
            twoDimensionalArray[indexPathTapped.section].names
            [indexPathTapped.row].hasFavorited = !hasFavorited
            
        cell.accessoryView?.tintColor = hasFavorited ? UIColor.lightGray: .red

    }

    private func fetchContacts(){
        print("Attemping to fetch contacts today..")

        let store = CNContactStore()

        store.requestAccess(for : .contacts){ (granted, err) } in
            if let err = err{
                print("Failed to request access:", err)
                return
            }

            if granted {
                print("Access granted")

                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor]
                
                do {
                    var favoritableContacts = [FavoritableContact]()

                    try store.enumerateContacts(with: request, usingBlock: {(contact,
                        stopPointerIfYouWantToStopEnumerating) in

                        print(contact.givenName)
                        print(contact.familyName)
                        print(contact.phoneNumbers.first?.value.stringValue ??"")

                        favoritableContacts.append(FavoritableContact(Contact: contact, hasFavorited: false))
                    })
                    
                    let names = ExpandableNames(isExpanded: true, names: favoritableContacts)
                    self.twoDimensionalArray = [names]
                } catch let err {
                    print("Failed to enumerate Contacts:", err)
                })
            }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchContacts()
        // Do any additional setup after loading the view.

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reload", style: 
        .plain, target: self, action: #selector(handleReload))

        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }


}

