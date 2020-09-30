//
//  BeerListViewModel.swift
//  BeerApp
//
//  Created by Alexander Karaatanasov on 26.09.20.
//  Copyright © 2020 Alexander Karaatanasov. All rights reserved.
//

import Foundation

// MARK: - Beer Item

protocol BeerListItemDisplay {
    // data
    init(beerModel: BeerDisplayModel)
    var beerModel: BeerDisplayModel { get }
    var beerNameDisplay: String { get }
    var beerTypeDisplay: String { get }
}

class BeerListItemViewModel: BeerListItemDisplay {

    let beerModel: BeerDisplayModel
    
    required init(beerModel: BeerDisplayModel) {
        self.beerModel = beerModel
    }
    
    var model: BeerDisplayModel {
        return beerModel
    }
    
    var beerNameDisplay: String {
        return beerModel.name
    }
    
    var beerTypeDisplay: String {
        return String(format: NSLocalizedString("BeerListViewModel.BeerTypeDisplay", comment: "Beer type string"), beerModel.type)
    }
}

// MARK: - Beer List

protocol BeerListDisplay {
    // data
    var beerListItems: [BeerListItemDisplay] { get }
    var beerListItemsDidChange: ((BeerListDisplay) -> ())? { get set }
    func listItemViewModel(for indexPath: IndexPath) -> BeerListItemDisplay
    // actions
    func fetchItems()
    func addTapped(sender: Any)
    func itemTapped(at: IndexPath, sender: Any)
}

class BeerListViewModel: BeerListDisplay {
    
    enum Routes {
        case beerCreate((Bool) -> Void)
        case beerDetail(BeerListItemDisplay)
    }
    
    // MARK: - Vars
    
    private var router: Router
    private var apiClient: APIClient
    
    // MARK: - Init
    
    init(router: Router) {
        self.router = router
        self.apiClient = APIClient()
    }
    
    // MARK: - Beer List Display Data
    
    var beerListItems: [BeerListItemDisplay] = [] {
        didSet {
            beerListItemsDidChange?(self)
        }
    }
    
    var beerListItemsDidChange: ((BeerListDisplay) -> ())?
    
    func listItemViewModel(for indexPath: IndexPath) -> BeerListItemDisplay {
        return beerListItems[indexPath.row]
    }
    
    // MARK: - Beer List Display Actions
    
    func fetchItems() {
        apiClient.get(from: .beerList, responseType: [BeerDisplayModel].self) { [weak self] response in
            guard let items = response else {
                // TODO: - Show some error alert
                return
            }
            
            DispatchQueue.main.async {
                self?.beerListItems = items.sorted(by: { $0.id > $1.id })
                                           .map { BeerListItemViewModel(beerModel: $0) }
                                           
            }
        }
    }
    
    func addTapped(sender: Any) {
        let completionHandler: (Bool) -> Void = { [weak self] successfullyAdded in
            if successfullyAdded {
                self?.fetchItems()
            }
        }
        router.route(on: sender as? BeerListViewController, context: Routes.beerCreate(completionHandler), animated: true)
    }
    
    func itemTapped(at indexPath: IndexPath, sender: Any) {
        let beerItemViewModel = beerListItems[indexPath.row]
        router.route(on: sender as? BeerListViewController, context: Routes.beerDetail(beerItemViewModel), animated: true)
    }
    
}
