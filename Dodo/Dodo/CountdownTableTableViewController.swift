//
//  CountdownTableTableViewController.swift
//  Dodo
//
//  Created by Blake Andrew Price on 10/22/19.
//  Copyright © 2019 Blake Andrew Price. All rights reserved.
//

import UIKit

class CountdownTableTableViewController: UITableViewController {
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    //MARK: - Properties
    let countdownController = CountdownController()
    
    //MARK: - Table View Data Source
    override func numberOfSections(in tableView: UITableView) -> Int {
        if countdownController.finishedCountdowns.count == 0 {
            return 1
        } else {
            return 2
        }
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Active Countdowns"
        } else {
            return "Finished Countdowns"
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return countdownController.unfinishedCountdowns.count
        } else {
            return countdownController.finishedCountdowns.count
        }
    }
}
