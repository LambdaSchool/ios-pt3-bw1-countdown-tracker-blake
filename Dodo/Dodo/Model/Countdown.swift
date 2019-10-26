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
        dateAndTime:    Date,
        category:       Category
    
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
    
    var readableDate: String {
        let date = dateAndTime
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy h:mm a"
        formatter.locale = Locale(identifier: "en_US")
        
        return formatter.string(from: date)
    }
    
    //MARK: - Init
    init(title: String, dateAndTime: Date, category: Category) {
        self.title = title
        self.dateAndTime = dateAndTime
        self.category = category
    }
}
