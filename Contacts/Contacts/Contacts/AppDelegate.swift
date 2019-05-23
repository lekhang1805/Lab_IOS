//
//  AppDelegate.swift
//  iSpaceLab
//
//  Created by Ho Dac Hung on 4/24/19.
//  Copyright © 2019 Ho Dac Hung. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        window = UIWindow()
        window?.makeKeyAndVisible()
        let navController = UINavigationController(rootViewController: ViewController)
        window?.rootViewController = navController()
        return true
    }

    override func tableView(_ tableVIew: UITableView, numberOfRowsInSection section: Int) ->Int{
        return names[section].names.count
    }
    
    override func tableView(_ tableVIew: UITableView, cellForRowAt indexPatch: IndexPatch) ->UITableViewCell{
        
        let cell = ContactCell(style: subtitle, reuseIdentifier: cellID)

        cell.link= self

        let favoritableContact = 
            twoDimentionalArray[indexPatch.section].name[indexPatch.row]

        cell.textLabel?.text = favoritableContact.contact.givenName + " " +
            favoritableContact.contact.familyName
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)

        cell.detailTextLabel?.text = 
            favoritableContact.contact.phoneNumbers.first?.value.stringvalue
        
        cell.accessoryView?.tinColor = favoritableContact.hasFavorited ? UIColor.red : .lightGray
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPatch)
        
        return cell
    }

    override func numberOfSection(in tableView: UITableView) ->Int{
        return names.count
    }
    override func tableView(_ tableVIew: UITableView, viewForHeaderInSection section: Int) ->UIView{
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .yellow
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.tag = section
        button.addTarget(self, action: #selector(handleExpandClose), for: touchUpInside)
        return button
    }
    override func tableVIew(_tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }

    


}

