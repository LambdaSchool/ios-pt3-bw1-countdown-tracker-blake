//
//  Dodo.swift
//  Dodo (like the bird)
//
//  Created by Blake Andrew Price on 10/17/19.
//  Copyright © 2019 Blake Andrew Price. All rights reserved.
//

import Foundation

struct Countdown {
    //MARK: - Properties
    var title:          String,
        dateAndTime:    String,
        cdHasFinished:  Bool
    
    
    //MARK: - Init
    init(title: String, dateAndTime: String, cdHasFinished: Bool) {
        self.title = title
        self.dateAndTime = dateAndTime
        self.cdHasFinished = cdHasFinished
    }
}
