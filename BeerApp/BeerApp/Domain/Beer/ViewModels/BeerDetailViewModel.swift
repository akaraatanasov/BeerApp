//
//  BeerDetailViewModel.swift
//  BeerApp
//
//  Created by Alexander Karaatanasov on 26.09.20.
//  Copyright © 2020 Alexander Karaatanasov. All rights reserved.
//

import Foundation

protocol BeerDetailDisplay {
    // data
    init(beerModel: BeerDisplayModel)
    var beerModelDidChange: ((BeerDetailDisplay) -> ())? { get set }
    var beerNameDisplay: String { get }
    var beerTypeDisplay: String { get }
    var beerDescriptionDisplay: String { get }
    // actions
    func fetchItem()
}

class BeerDetailViewModel: BeerDetailDisplay {
    
    // MARK: - Vars

    private var beerModel: BeerDisplayModel {
        didSet {
            beerModelDidChange?(self)
        }
    }
    
    private var apiClient: APIClient
    
    // MARK: - Init
    
    required init(beerModel: BeerDisplayModel) {
        self.beerModel = beerModel
        self.apiClient = APIClient()
    }
    
    // MARK: - Beer Detail Display Data
    
    var beerModelDidChange: ((BeerDetailDisplay) -> ())?

    var beerNameDisplay: String {
        return beerModel.name
    }
    
    var beerTypeDisplay: String {
        return String(format: NSLocalizedString("BeerDetailViewModel.BeerTypeDisplay", comment: "Beer type string"), beerModel.type)
    }
    
    var beerDescriptionDisplay: String {
        return beerModel.description
    }
    
    // MARK: - Beer Detail Display Actions
    
    func fetchItem() {
        let beerId = beerModel.id
        apiClient.get(from: .beerDetail(beerId), responseType: BeerDisplayModel.self) { [weak self] response in
            guard let item = response else {
                // TODO: - Show some error alert
                return
            }
            
            DispatchQueue.main.async {
                self?.beerModel = item
            }
        }
    }
    
}
