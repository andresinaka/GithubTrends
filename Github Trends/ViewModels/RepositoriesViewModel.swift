//
//  RepositoriesViewModel.swift
//  Github Trends
//
//  Created by Andres on 15/02/2018.
//  Copyright © 2018 Andres. All rights reserved.
//

import UIKit

class RepositoriesViewModel: BasicViewModel {
    let httpClient: HttpClient
    var repositories: [Repository] = []
    var updateTableView: (()->())?
    var updateLoading: ((Bool)->())?
    var updateError: ((String)->())?

    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }

    private var cellViewModels: [RepositoryViewModel] = [RepositoryViewModel]() {
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

    func getCellViewModel( at indexPath: IndexPath ) -> RepositoryViewModel {
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
        let trendingCellViewModels = repositories.map { (repository) -> RepositoryViewModel in
            let trendingCellViewModel = RepositoryViewModel(httpClient: httpClient)
            trendingCellViewModel.descriptionText = repository.description
            trendingCellViewModel.nameText = repository.name
            trendingCellViewModel.fullnameText = repository.fullname
            trendingCellViewModel.starsCountText = "\(repository.stars ?? 0)"
            trendingCellViewModel.forksCountText =  "\(repository.forks ?? 0)"
            trendingCellViewModel.owner = repository.owner

            return trendingCellViewModel
        }

        self.cellViewModels = trendingCellViewModels
    }
}
