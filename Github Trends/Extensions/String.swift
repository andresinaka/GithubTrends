//
//  String.swift
//  Github Trends
//
//  Created by Andres on 15/02/2018.
//  Copyright © 2018 Andres. All rights reserved.
//

import UIKit

extension String {
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }

    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
}
