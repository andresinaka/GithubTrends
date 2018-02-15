//
//  Style.swift
//  Github Trends
//
//  Created by Andres on 15/02/2018.
//  Copyright © 2018 Andres. All rights reserved.
//

import Foundation
import UIKit

class Style{
    class func configureStyles() -> Void {
        let barColor = UIColor(named: "Navigation")!
        UINavigationBar.appearance().tintColor = barColor
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: barColor
        ]
    }
}
