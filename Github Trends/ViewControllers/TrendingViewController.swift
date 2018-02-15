
//
//  TrendingViewController.swift
//  Github Trends
//
//  Created by Andres on 14/02/2018.
//  Copyright © 2018 Andres. All rights reserved.
//

import UIKit

class TrendingViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!

    lazy var viewModel: TrendingViewModel = {
        let httpClient = HttpClient()
        return TrendingViewModel(httpClient: httpClient)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        initializeViewModelBindings()
        viewModel.fetchData()
    }

    func initializeViewModelBindings() {
        viewModel.updateTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        viewModel.updateLoading = { [weak self] (loading) in
            DispatchQueue.main.async {
                if(loading) {
                    self?.loadingIndicatorView.startAnimating()
                } else {
                    self?.loadingIndicatorView.stopAnimating()
                }
            }
        }

        viewModel.updateError = { [weak self] (errorString) in
            let alertController = UIAlertController(
                title: "",
                message: errorString,
                preferredStyle: .alert
            )
            alertController.addAction(
                UIAlertAction(title: "Ok", style: .default, handler: nil)
            )

            DispatchQueue.main.async {
                self?.present(alertController, animated: true, completion: nil)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? ProjectDetailViewController,
            let indexPath = sender as? IndexPath else { return }

        viewController.viewModel = viewModel.getCellViewModel(at: indexPath)
    }
}

extension TrendingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "RepoDetail", sender: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TrendingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let trendingCell = tableView.dequeueReusableCell(
            withIdentifier: TrendingTableViewCell.identifier,
            for: indexPath
        ) as! TrendingTableViewCell

        let trendingViewModel = viewModel.getCellViewModel(at: indexPath)
        trendingCell.configure(viewModel: trendingViewModel)
        return trendingCell
    }
}
