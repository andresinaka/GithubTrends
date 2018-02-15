//
//  ResponseTests.swift
//  Github TrendsTests
//
//  Created by Andres on 15/02/2018.
//  Copyright © 2018 Andres. All rights reserved.
//

import XCTest

class ResponseTests: XCTestCase {

    func response() -> Response {
        let rawData = TestHelpers.rawDataFromFile(filename: "repositories")
        return try! JSONDecoder().decode(Response.self, from: rawData as Data)
    }

    func testResponse() {
        let response = self.response()
        XCTAssertFalse(response.incompleteResults)
        XCTAssertEqual(response.totalCount, 159611)
        XCTAssertEqual(response.items.count, 30)
    }
}
