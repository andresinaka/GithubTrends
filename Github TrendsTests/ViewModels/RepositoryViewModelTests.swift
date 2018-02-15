//
//  RepositoryViewModelTests.swift
//  Github TrendsTests
//
//  Created by Andres on 15/02/2018.
//  Copyright © 2018 Andres. All rights reserved.
//

import XCTest

class RepositoryViewModelTests: XCTestCase {
    var modelView: RepositoryViewModel!

    override func setUp() {
        super.setUp()
        let mockHttpClient = HttpClientMock()
        modelView = RepositoryViewModel(httpClient: mockHttpClient)
    }

    func testReceiveUpdatesInBackgroundThread() {
        modelView.updateOwnerImage = { (ownerImage) in
            XCTAssertTrue(!Thread.isMainThread)
        }

        modelView.updateReadme = { (readme) in
            XCTAssertTrue(!Thread.isMainThread)
        }

        modelView.fetchData()
    }

    func testReceiveUpdatesForAllFields() {
        let dispatchGroup = DispatchGroup()
        let expect = expectation(description: "All notiications are returned")

        dispatchGroup.enter()
        modelView.updateOwnerImage = { (ownerImage) in
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        modelView.updateStarsCountText = { (starsCountText) in
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        modelView.updateForksCountText = { (forkCountText) in
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        modelView.updateOwnerUsername = { (username) in
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        modelView.updateDescriptionText = { (description) in
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        modelView.updateNameText = { (nametext) in
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        modelView.updateReadme = { (readme) in
            dispatchGroup.leave()
        }

        modelView.fetchData()
        dispatchGroup.notify(queue: DispatchQueue.main) {
            expect.fulfill()
        }

        waitForExpectations(timeout: 10) { error in
            print(error ?? "No error")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
