//
//  Countdown+Comparable.swift
//  Dodo
//
//  Created by Blake Andrew Price on 10/23/19.
//  Copyright © 2019 Blake Andrew Price. All rights reserved.
//

import Foundation

extension Countdown: Comparable {
    static func < (lhs: Countdown, rhs: Countdown) -> Bool {
        return lhs.dateAndTime < rhs.dateAndTime
    }
}
