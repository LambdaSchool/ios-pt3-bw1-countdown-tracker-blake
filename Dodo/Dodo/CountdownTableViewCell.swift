//
//  CountdownTableViewCell.swift
//  Dodo
//
//  Created by Blake Andrew Price on 10/22/19.
//  Copyright © 2019 Blake Andrew Price. All rights reserved.
//

import UIKit

class CountdownTableViewCell: UITableViewCell {
    //MARK: - Properties
    var countdown: Countdown?
    
    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeRemainingLabel: UILabel!
    
    //MARK: - Functions
    func updateViews() {
        guard let countdown = countdown else { return }
        
        titleLabel.text = countdown.title
        timeRemainingLabel.text = countdown.readableInterval
    }
    
}
