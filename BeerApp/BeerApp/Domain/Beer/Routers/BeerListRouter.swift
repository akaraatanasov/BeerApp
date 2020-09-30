//
//  BeerListRouter.swift
//  BeerApp
//
//  Created by Alexander Karaatanasov on 28.09.20.
//  Copyright © 2020 Alexander Karaatanasov. All rights reserved.
//

import UIKit

class BeerListRouter: Router {
    
    // MARK: - Constants
    
    private let beerStoryboard = UIStoryboard(name: "Beer", bundle: .main)
    
    // MARK: - Router Conformance
    
    func route(on baseVC: UIViewController?, context: Any?, animated: Bool) {
        guard let routes = context as? BeerListViewModel.Routes else {
            assertionFailure("The route enum is missmatched!")
            return
        }
        
        switch routes {
        case .beerDetail(let beerItemViewModel):
            let beerDetailViewModel = BeerDetailViewModel(beerModel: beerItemViewModel.beerModel)
            let beerDetailController = beerStoryboard.instantiateViewController(withIdentifier: "BeerDetailViewController") as! BeerDetailViewController
            beerDetailController.viewModel = beerDetailViewModel
            
            baseVC?.navigationController?.pushViewController(beerDetailController, animated: true)
        case .beerCreate(let completionHandler):
            let beerCreateRouter = BeerCreateRouter()
            let beerCreateViewModel = BeerCreateViewModel(router: beerCreateRouter, completionHandler: completionHandler)
            let beerCreateController = beerStoryboard.instantiateViewController(withIdentifier: "BeerCreateViewController") as! BeerCreateViewController
            beerCreateController.viewModel = beerCreateViewModel
            let beerCreateNavigationController = UINavigationController(rootViewController: beerCreateController)
            
            baseVC?.present(beerCreateNavigationController, animated: animated)
        }
    }

}
