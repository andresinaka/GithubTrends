//
//  Repository.swift
//  Github Trends
//
//  Created by Andres on 14/02/2018.
//  Copyright © 2018 Andres. All rights reserved.
//

import UIKit

struct Repository: Decodable {
    let fullName: String?
    let id: Int?
    let stars: Int?
    let name: String?
    let description: String?

    private enum CodingKeys : String, CodingKey {
        case name, fullName = "full_name", id, stars = "stargazers_count", description
    }
}

