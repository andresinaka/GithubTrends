//
//  TrendingViewModel.swift
//  Github Trends
//
//  Created by Andres on 15/02/2018.
//  Copyright © 2018 Andres. All rights reserved.
//

import UIKit

class TrendingViewModel {
    let httpClient: HttpClient
    var repositories: [Repository] = []
    var reloadTableViewClosure: (()->())?
    var updateLoadingClosure: ((Bool)->())?
    var errorClosure: ((String)->())?

    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }

    private var cellViewModels: [TrendingCellViewModel] = [TrendingCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }

    var error: String = "" {
        didSet {
            self.errorClosure?(error)
        }
    }

    var isLoading: Bool = false {
        didSet {
            self.updateLoadingClosure?(isLoading)
        }
    }

    var numberOfCells: Int {
        return cellViewModels.count
    }

    func getCellViewModel( at indexPath: IndexPath ) -> TrendingCellViewModel {
        return cellViewModels[indexPath.row]
    }

    func fetchData() {
        isLoading = true
        httpClient.fetchTrendingRepos { [weak self] (repositories) in
            self?.isLoading = false
            guard let repos = repositories else {
                self?.error = "Something went wrong"
                return
            }
            self?.handleResponse(repositories: repos)
        }
    }

    private func handleResponse(repositories: [Repository]) {
        let trendingCellViewModels = repositories.map { (repository) -> TrendingCellViewModel in
            let trendingCellViewModel = TrendingCellViewModel()
            trendingCellViewModel.descriptionText = repository.description
            trendingCellViewModel.nameText = repository.fullName
            trendingCellViewModel.starsCountText = String(describing: repository.stars)

            return trendingCellViewModel
        }

        self.cellViewModels = trendingCellViewModels
    }
}
