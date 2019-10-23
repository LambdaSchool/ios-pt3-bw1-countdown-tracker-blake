//
//  Dodo.swift
//  Dodo (like the bird)
//
//  Created by Blake Andrew Price on 10/17/19.
//  Copyright © 2019 Blake Andrew Price. All rights reserved.
//

import Foundation

struct Countdown: Codable, Equatable {
    //MARK: - Properties
    var title:          String,
        dateAndTime:    Date
    
    //MARK: - Computed Properties
    var cdHasFinished: Bool {
        return dateAndTime <= Date()
    }
    
    var readableInterval: String {
        let interval = dateAndTime.timeIntervalSinceNow
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        
        return formatter.string(from: interval) ?? ""
    }
    
    //MARK: - Init
    init(title: String, dateAndTime: Date) {
        self.title = title
        self.dateAndTime = dateAndTime
    }
}
