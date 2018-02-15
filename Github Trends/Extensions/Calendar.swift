//
//  Calendar.swift
//  Github Trends
//
//  Created by Andres on 14/02/2018.
//  Copyright © 2018 Andres. All rights reserved.
//

import UIKit

extension Calendar {
    func todayPlus(days: Int) -> Date? {
        return self.date(byAdding: .day, value: days, to: Date())
    }
}
