//
//  CountdownTableTableViewController.swift
//  Dodo
//
//  Created by Blake Andrew Price on 10/22/19.
//  Copyright © 2019 Blake Andrew Price. All rights reserved.
//

import UIKit
import NotificationCenter

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
        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: UIApplication.shared, queue: nil) { (_) in
            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - Properties
    let countdownController = CountdownController()
    
    //MARK: - Table View Data Source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Category.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let selectedCase = Category.allCases[section]
        return selectedCase.rawValue
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let selectedCase = Category.allCases[section]
        return countdownController.countdowns(in: selectedCase).count
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
        let selectedCase = Category.allCases[indexPath.section]
        let countdowns = countdownController.countdowns(in: selectedCase)
        return countdowns[indexPath.row]
    }
}
