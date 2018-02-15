//
//  HttpClientMock.swift
//  Github TrendsTests
//
//  Created by Andres on 15/02/2018.
//  Copyright © 2018 Andres. All rights reserved.
//

import XCTest

class HttpClientMock: HttpClient {
    
    override func downloadImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            completion(UIImage())
        }
    }

    override func downloadReadme(repository: String, completion: @escaping (String?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            completion("This is a test")
        }
    }

    override public func fetchTrendingRepos(completion: @escaping ([Repository]?) -> Void) {
        let rawData = TestHelpers.rawDataFromFile(filename: "repositories")
        let response = try! JSONDecoder().decode(Response.self, from: rawData as Data)

        completion(response.items)
    }

}
