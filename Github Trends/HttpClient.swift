//
//  HttpClient.swift
//  Github Trends
//
//  Created by Andres on 14/02/2018.
//  Copyright © 2018 Andres. All rights reserved.
//

import UIKit

class HttpClient {
    let session = URLSession.shared
    let githubApi = "https://api.github.com"

    public func fetchTrendingRepos(completion: @escaping ([Repository]?) -> Void) {

        guard
            let threeDaysAgoString = threeDaysAgo(),
            let trendingURL = url(
                url: "\(githubApi)/search/repositories",
                params: [
                    "sort" : "stars",
                    "order": "desc",
                    "q": "created:>\(threeDaysAgoString)"
                ]
        ) else {
            completion(nil)
            return
        }

        let request = requestFor(url: trendingURL)
        let task = session.dataTask(with: request) { (data, response, error) in
            guard
                let data = data,
                let jsonResponse = try? JSONDecoder().decode(Response.self, from: data) else
            {
                completion(nil)
                return
            }
            completion(jsonResponse.items)
        }

        task.resume()
    }

    private func requestFor(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.addValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        return request
    }

    private func url(url: String, params: [String: String]) -> URL? {
        guard var urlComponents = URLComponents(string: url) else { return nil }
        urlComponents.queryItems = params.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }

        return urlComponents.url
    }

    private func threeDaysAgo() -> String? {
        let threeDaysAgoDate = Calendar.current.todayPlus(days: -3)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        guard let date = threeDaysAgoDate else { return nil }
        return dateFormatter.string(from: date)
    }
}
