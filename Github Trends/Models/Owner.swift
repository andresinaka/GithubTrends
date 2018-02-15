//
//  Owner.swift
//  Github Trends
//
//  Created by Andres on 15/02/2018.
//  Copyright © 2018 Andres. All rights reserved.
//

import UIKit

class Owner: Decodable {
    let username: String?
    let avatarString: String?

    private enum CodingKeys : String, CodingKey {
        case username = "login", avatarString = "avatar_url"
    }
}
