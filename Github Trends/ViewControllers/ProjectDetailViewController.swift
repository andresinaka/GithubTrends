//
//  ProjectDetailViewController.swift
//  Github Trends
//
//  Created by Andres on 15/02/2018.
//  Copyright © 2018 Andres. All rights reserved.
//

import UIKit

class ProjectDetailViewController: UIViewController {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var readmeLabel: UILabel!
    @IBOutlet weak var userAvatarImageView: UIImageView!

    @IBOutlet weak var forksButton: UIButton!
    @IBOutlet weak var starsButton: UIButton!

    var viewModel: RepositoryViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeViewModelBindings()
        viewModel?.fetchData()
    }

    func initializeViewModelBindings() {
        viewModel?.updateOwnerImage = { [weak self] (ownerImage) in
            DispatchQueue.main.async {
                self?.userAvatarImageView.image = ownerImage
            }
        }

        viewModel?.updateStarsCountText = { [weak self] (starsCountText) in
            DispatchQueue.main.async {
                guard let starsText = starsCountText else { return }
                self?.starsButton.setTitle("\(starsText) Stars", for: .normal)
            }
        }

        viewModel?.updateForksCountText = { [weak self] (forkCountText) in
            DispatchQueue.main.async {
                guard let forksText = forkCountText else { return }
                self?.forksButton.setTitle("\(forksText) Forks", for: .normal)
            }
        }

        viewModel?.updateOwnerUsername = { [weak self] (username) in
            DispatchQueue.main.async {
                self?.userNameLabel.text = username
            }
        }

        viewModel?.updateDescriptionText = { [weak self] (description) in
            DispatchQueue.main.async {
                self?.descriptionLabel.text = description
            }
        }

        viewModel?.updateNameText = { [weak self] (nametext) in
            DispatchQueue.main.async {
                self?.title = nametext
            }
        }

        viewModel?.updateReadme = { [weak self] (readme) in
            DispatchQueue.main.async {
                self?.readmeLabel.text = readme
            }
        }
    }
}
