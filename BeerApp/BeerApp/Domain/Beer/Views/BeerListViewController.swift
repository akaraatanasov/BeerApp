//
//  BeerListViewController.swift
//  BeerApp
//
//  Created by Alexander Karaatanasov on 26.09.20.
//  Copyright © 2020 Alexander Karaatanasov. All rights reserved.
//

import UIKit

class BeerListViewController: UIViewController {
    
    // MARK: - Vars
    
    var viewModel: BeerListDisplay! {
        didSet {
            viewModel.beerListItemsDidChange = { [unowned self] viewModel in
                if viewModel.beerListItems.isEmpty {
                    // TODO: - Show no data background
                } else {
                    UIView.transition(with: self.tableView,
                                      duration: 0.5,
                                      options: .transitionFlipFromRight,
                                      animations: { self.tableView.reloadData() })
                }
            }
        }
    }

    // MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        displayData()
    }
    
    // MARK: - Private
    
    private func configureView() {
        title = NSLocalizedString("BeerListViewController.Title", comment: "Beers List title")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        tableView.register(BeerListItemCell.self, forCellReuseIdentifier: BeerListItemCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        tableView.separatorColor = .black
        tableView.separatorInset = .zero
    }
    
    private func displayData() {
        viewModel.fetchItems()
    }
    
    // MARK: - Actions
    
    @objc private func addTapped(_ sender: Any) {
        viewModel.addTapped(sender: self)
    }

}

// MARK: - Table View Delegate

extension BeerListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.itemTapped(at: indexPath, sender: self)
    }
    
}

// MARK: - Table View Data Source

extension BeerListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.beerListItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BeerListItemCell.reuseIdentifier, for: indexPath) as? BeerListItemCell ??
                                                     BeerListItemCell(style: .subtitle, reuseIdentifier: BeerListItemCell.reuseIdentifier)
        cell.viewModel = viewModel.beerListItems[indexPath.row]
        return cell
    }
    
}
