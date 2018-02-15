//
//  TrendingTableViewCell.swift
//  Github Trends
//
//  Created by Andres on 15/02/2018.
//  Copyright © 2018 Andres. All rights reserved.
//

import UIKit

class TrendingTableViewCell: UITableViewCell {
    static let identifier = "TrendingLabelID"

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    func configure(viewModel: TrendingCellViewModel) {
        nameLabel.text = viewModel.nameText
        starsCountLabel.text = viewModel.starsCountText
        descriptionLabel.text = viewModel.descriptionText
    }
}
