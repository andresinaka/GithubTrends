//
//  RepositoriesViewModelTests.swift
//  Github TrendsTests
//
//  Created by Andres on 15/02/2018.
//  Copyright © 2018 Andres. All rights reserved.
//

import XCTest

class RepositoriesViewModelTests: XCTestCase {
    
    var modelView: RepositoriesViewModel!

    override func setUp() {
        super.setUp()
        let mockHttpClient = HttpClientMock()
        modelView = RepositoriesViewModel(httpClient: mockHttpClient)
    }

    func testNotifiesUpdateTable() {
        let expect = expectation(description: "All notiications are returned")

        modelView.updateTableView = {
            XCTAssertEqual(self.modelView.numberOfCells, 30)
            XCTAssertNotNil(self.modelView.getCellViewModel(at: IndexPath(row: 0, section: 0)))

            expect.fulfill()
        }

        modelView.fetchData()


        waitForExpectations(timeout: 10) { error in
            print(error ?? "No error")
        }
    }

    func testUpdates() {
        let dispatchGroup = DispatchGroup()
        let expect = expectation(description: "All notiications are returned")

        dispatchGroup.enter()
        modelView.updateTableView = {
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        modelView.updateTableView = {
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        modelView.updateLoading = { (finished) in
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
}
