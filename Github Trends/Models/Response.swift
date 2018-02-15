//
//  Response.swift
//  Github Trends
//
//  Created by Andres on 14/02/2018.
//  Copyright © 2018 Andres. All rights reserved.
//

import UIKit

struct Response: Decodable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Repository]

    private enum CodingKeys : String, CodingKey {
        case items, incompleteResults = "incomplete_results", totalCount = "total_count"
    }
}
