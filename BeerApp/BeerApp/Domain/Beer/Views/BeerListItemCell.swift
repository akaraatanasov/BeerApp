//
//  BeerListItemCell.swift
//  BeerApp
//
//  Created by Alexander Karaatanasov on 30.09.20.
//  Copyright © 2020 Alexander Karaatanasov. All rights reserved.
//

import UIKit

class BeerListItemCell: UITableViewCell {

    static let reuseIdentifier = "beerCell"
    
    // MARK: - Vars
    
    var viewModel: BeerListItemDisplay? {
        didSet {
            textLabel?.text = viewModel?.beerNameDisplay
            detailTextLabel?.text = viewModel?.beerTypeDisplay
        }
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        super.init(style: .subtitle, reuseIdentifier: BeerListItemCell.reuseIdentifier)
        accessoryType = .disclosureIndicator
    }
    
}
