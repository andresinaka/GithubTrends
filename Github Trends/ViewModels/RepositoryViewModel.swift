//
//  RepositoryViewModel.swift
//  Github Trends
//
//  Created by Andres on 15/02/2018.
//  Copyright © 2018 Andres. All rights reserved.
//

import UIKit

class RepositoryViewModel: BasicViewModel {
    let httpClient: HttpClient

    var updateStarsCountText: ((String?)->())?
    var updateOwnerUsername: ((String?)->())?
    var updateDescriptionText: ((String?)->())?
    var updateForksCountText: ((String?)->())?
    var updateNameText: ((String?)->())?
    var updateOwnerImage: ((UIImage)->())?
    var updateReadme: ((String?)->())?
    var updateFullnameText: ((String?)->())?

    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }

    var readme: String? {
        didSet {
            self.updateReadme?(readme)
        }
    }

    var nameText: String? {
        didSet {
            self.updateNameText?(nameText)
        }
    }

    var fullnameText: String? {
        didSet {
            self.updateFullnameText?(fullnameText)
        }
    }

    var starsCountText: String? {
        didSet {
            self.updateStarsCountText?(starsCountText)
        }
    }

    var forksCountText: String? {
        didSet {
            self.updateForksCountText?(forksCountText)
        }
    }

    var descriptionText: String? {
        didSet {
            self.updateDescriptionText?(descriptionText)
        }
    }

    var owner: Owner? {
        didSet {
            self.updateOwnerUsername?(owner?.username)
        }
    }

    var ownerImage: UIImage? {
        didSet {
            if let oImage = ownerImage {
                self.updateOwnerImage?(oImage)
            }
        }
    }

    override func fetchData() {
        
        self.updateStarsCountText?(starsCountText)
        self.updateDescriptionText?(descriptionText)
        self.updateOwnerUsername?(owner?.username)
        self.updateNameText?(nameText)
        self.updateForksCountText?(forksCountText)

        let imageStringUrl = owner?.avatarString ?? ""
        httpClient.downloadImage(urlString: imageStringUrl) { [weak self] (image) in
            guard let image = image else { return }
            self?.ownerImage = image
        }

        let repositoryName = fullnameText ?? ""
        httpClient.downloadReadme(repository: repositoryName) { [weak self] (readme) in
            guard let readme = readme else { return }
            self?.readme = readme
        }
    }
}
