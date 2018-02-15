
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
        viewModel.reloadTableViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        viewModel.updateLoadingClosure = { [weak self] (loading) in
            guard let strongSelf = self else { return }

            DispatchQueue.main.async {
                strongSelf.loadingIndicatorView.isHidden = !loading
            }
        }

        viewModel.errorClosure = { [weak self] (errorString) in
            let alertController = UIAlertController(
                title: "",
                message: errorString,
                preferredStyle: .alert
            )
            alertController.addAction(
                UIAlertAction(title: "Ok", style: .default, handler: nil)
            )

            self?.present(alertController, animated: true, completion: nil)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "RepoDetail") {
            print("FAFAFA")
        }
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
