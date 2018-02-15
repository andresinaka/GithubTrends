//
//  RepositoryTests.swift
//  Github TrendsTests
//
//  Created by Andres on 15/02/2018.
//  Copyright © 2018 Andres. All rights reserved.
//

import XCTest

class RepositoryTests: XCTestCase {
    
    func repositories() -> [Repository] {
        let rawData = TestHelpers.rawDataFromFile(filename: "repositories")
        let response = try! JSONDecoder().decode(Response.self, from: rawData as Data)
        return response.items
    }

    func testResponse() {
        let repos = repositories()
        let firstRepository = repos.first!
        let owner = firstRepository.owner!

        XCTAssertEqual(owner.username!, "raphael-ernaelsten")
        XCTAssertEqual(owner.avatarString!, "https://avatars0.githubusercontent.com/u/32592121?v=4")

        XCTAssertEqual(firstRepository.description!, "Volumetric Lighting for Unity")
        XCTAssertEqual(firstRepository.name!, "Aura")
        XCTAssertEqual(firstRepository.fullname!, "raphael-ernaelsten/Aura")
        XCTAssertEqual(firstRepository.forks!, 20)
        XCTAssertEqual(firstRepository.stars!, 351)
        XCTAssertEqual(firstRepository.id!, 121258772)

    }
}
