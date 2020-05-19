//
//  MenuViewController.swift
//  Quran247
//
//  Created by Jimoh Babatunde  on 11/05/2020.
//  Copyright © 2020 Dawah Nigeria. All rights reserved.
//

import UIKit

enum MenuType: Int {
    case home
    case support
    case ourInitiatives
    case share
    case aboutDn
}

class MenuViewController: UITableViewController {
    
    @IBOutlet var tableViewMenu: UITableView?
    var didTapMenu: ((MenuType) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else {return}
        dismiss(animated: true) { [weak self] in
            SideMenuTransition.sharedInstance.isPresenting = false
            print("Dismissing: \(menuType)")
            self?.didTapMenu?(menuType)
        }
    }
    
}
