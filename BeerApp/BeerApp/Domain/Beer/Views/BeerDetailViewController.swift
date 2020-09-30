//
//  BeerDetailViewController.swift
//  BeerApp
//
//  Created by Alexander Karaatanasov on 26.09.20.
//  Copyright © 2020 Alexander Karaatanasov. All rights reserved.
//

import UIKit

class BeerDetailViewController: UIViewController {
    
    // MARK: - Vars
    
    var viewModel: BeerDetailDisplay! {
        didSet {
            viewModel.beerModelDidChange = { [weak self] viewModel in
                DispatchQueue.main.async {
                    self?.updateLabels()
                }
            }
        }
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        displayData()
    }
    
    // MARK: - Private
    
    private func configureView() {
        title = NSLocalizedString("BeerDetailViewController.Title", comment: "Details title")
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func displayData() {
        updateLabels()
        viewModel.fetchItem()
    }
    
    private func updateLabels() {
        titleLabel.text = viewModel.beerNameDisplay
        subtitleLabel.text = viewModel.beerTypeDisplay
        descriptionLabel.text = viewModel.beerDescriptionDisplay
    }
    
}
