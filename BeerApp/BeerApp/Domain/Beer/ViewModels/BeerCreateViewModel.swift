//
//  BeerCreateViewModel.swift
//  BeerApp
//
//  Created by Alexander Karaatanasov on 26.09.20.
//  Copyright © 2020 Alexander Karaatanasov. All rights reserved.
//

import Foundation

protocol BeerCreateDisplay {
    // data
    func isBeerInputValid(for: String) -> Bool
    // actions
    func cancelCreation(sender: Any)
    func createNewBeer(name: String, type: String, description: String, sender: Any)
}

class BeerCreateViewModel: BeerCreateDisplay {

    enum Routes {
        case beerList
    }
    
    // MARK: - Vars
    
    private var router: Router
    private var apiClient: APIClient
    private var shouldListViewRefresh: (Bool) -> Void
    
    // MARK: - Init
    
    init(router: Router, completionHandler: @escaping (Bool) -> Void) {
        self.router = router
        self.apiClient = APIClient()
        self.shouldListViewRefresh = completionHandler
    }
    
    // MARK: - Beer Create Display Data
    
    func isBeerInputValid(for input: String) -> Bool {
        return !input.isEmpty
    }
    
    // MARK: - Beer Create Display Actions
    
    func cancelCreation(sender: Any) {
        router.route(on: sender as? BeerCreateViewController, context: Routes.beerList, animated: true)
        shouldListViewRefresh(false)
    }
    
    func createNewBeer(name: String, type: String, description: String, sender: Any) {
        let beerBody = BeerCreateModel(name: name, type: type, description: description)
        apiClient.post(to: .beerCreate, requestBody: beerBody, responseType: MessageResponseModel.self) { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    self?.router.route(on: sender as? BeerCreateViewController, context: Routes.beerList, animated: true)
                    self?.shouldListViewRefresh(true)
                } else {
                    // TODO: - Show some error alert
                }
            }
        }
    }
    
}
