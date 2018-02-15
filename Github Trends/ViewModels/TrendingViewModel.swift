//
//  TrendingViewModel.swift
//  Github Trends
//
//  Created by Andres on 15/02/2018.
//  Copyright © 2018 Andres. All rights reserved.
//

import UIKit

class TrendingViewModel: BasicViewModel {
    let httpClient: HttpClient
    var repositories: [Repository] = []
    var updateTableView: (()->())?
    var updateLoading: ((Bool)->())?
    var updateError: ((String)->())?

    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }

    private var cellViewModels: [TrendingCellViewModel] = [TrendingCellViewModel]() {
        didSet {
            self.updateTableView?()
        }
    }

    var error: String = "" {
        didSet {
            self.updateError?(error)
        }
    }

    var isLoading: Bool = false {
        didSet {
            self.updateLoading?(isLoading)
        }
    }

    var numberOfCells: Int {
        return cellViewModels.count
    }

    func getCellViewModel( at indexPath: IndexPath ) -> TrendingCellViewModel {
        return cellViewModels[indexPath.row]
    }

    override func fetchData() {
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
            let trendingCellViewModel = TrendingCellViewModel(httpClient: httpClient)
            trendingCellViewModel.descriptionText = repository.description
            trendingCellViewModel.nameText = repository.fullName
            trendingCellViewModel.starsCountText = "\(repository.stars ?? 0)"
            trendingCellViewModel.forksCountText =  "\(repository.forks ?? 0)"
            trendingCellViewModel.owner = repository.owner

            return trendingCellViewModel
        }

        self.cellViewModels = trendingCellViewModels
    }
}
