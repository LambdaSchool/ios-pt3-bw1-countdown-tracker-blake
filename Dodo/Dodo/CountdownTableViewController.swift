//
//  CountdownTableTableViewController.swift
//  Dodo
//
//  Created by Blake Andrew Price on 10/22/19.
//  Copyright © 2019 Blake Andrew Price. All rights reserved.
//

import UIKit

class CountdownTableViewController: UITableViewController {
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        countdownController.loadFromPersistentStore()
       _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            for cell in self.tableView.visibleCells {
                guard let selectedCell = cell as? CountdownTableViewCell else {fatalError("Timer error!")}
                selectedCell.updateViews()
            }
        }
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    //MARK: - Properties
    let countdownController = CountdownController()
    
    //MARK: - Table View Data Source
    override func numberOfSections(in tableView: UITableView) -> Int {
        if countdownController.countdowns.count == 0 {
            return 0
        } else if countdownController.finishedCountdowns.count == 0 {
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountdownCell", for: indexPath) as? CountdownTableViewCell else { fatalError("A countdown cell was not found!") }
        let countdown = countdownFor(indexPath: indexPath)
        cell.countdown = countdown
        cell.updateViews()
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let countdown = countdownFor(indexPath: indexPath)
            countdownController.deleteCountdown(countdown: countdown)
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddCountdownSegue" {
            if let countdownDetailVC = segue.destination as? CountdownDetailViewController {
                countdownDetailVC.countdownController = countdownController
            }
        } else if segue.identifier == "ShowCountdownSegue" {
            if let countdownDetailVC = segue.destination as? CountdownDetailViewController,
                let selectedCell = sender as? CountdownTableViewCell {
                countdownDetailVC.countdownController = countdownController
                countdownDetailVC.countdown = selectedCell.countdown
            }
        }
    }
    
    private func countdownFor(indexPath: IndexPath) -> Countdown {
        if indexPath.section == 0 {
            return countdownController.unfinishedCountdowns[indexPath.row]
        } else {
            return countdownController.finishedCountdowns[indexPath.row]
        }
    }
}
