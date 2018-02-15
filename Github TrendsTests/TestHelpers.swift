//
//  TestHelpers.swift
//  Github TrendsTests
//
//  Created by Andres on 15/02/2018.
//  Copyright © 2018 Andres. All rights reserved.
//

import Foundation

class TestHelpers {
    class func rawDataFromFile(filename: String) -> NSData {
        let bundle = Bundle(for: TestHelpers.self)
        let path = bundle.path(forResource: filename, ofType: "json")!
        let jsonData = NSData(contentsOfFile: path)

        return jsonData!
    }
}
