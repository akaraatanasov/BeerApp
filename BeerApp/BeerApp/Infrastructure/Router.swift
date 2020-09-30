//
//  Router.swift
//  BeerApp
//
//  Created by Alexander Karaatanasov on 26.09.20.
//  Copyright © 2020 Alexander Karaatanasov. All rights reserved.
//

import UIKit

protocol Router {
    
    /// This method should be used as an entry point for presenting the VC for particular router
    ///
    /// - Parameters:
    ///   - baseVC: the base VC
    ///   - context: optional context
    ///   - animated: animated presenting or not
    func route(on baseVC: UIViewController?, context: Any?, animated: Bool)
    
}

class AppRouter: Router {
    
    enum Routes {
        case beerList
    }
    
    // MARK: - Vars
    
    weak var window: UIWindow?
    
    // MARK: - Init
    
    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: - Public
    
    func setInitialScreen() {
        route(on: nil, context: Routes.beerList, animated: true)
    }
    
    // MARK: - Router Conformance
    
    func route(on baseVC: UIViewController?, context: Any?, animated: Bool) {
        guard let routes = context as? Routes else {
            assertionFailure("The route enum is missmatched!")
            return
        }
        
        switch routes {
        case .beerList:
            let beerListRouter = BeerListRouter()
            let beerListViewModel = BeerListViewModel(router: beerListRouter)
            let beerStoryboard = UIStoryboard(name: "Beer", bundle: .main)
            let beerListController = beerStoryboard.instantiateViewController(withIdentifier: "BeerListViewController") as! BeerListViewController
            beerListController.viewModel = beerListViewModel
            
            let rootViewController = UINavigationController(rootViewController: beerListController)
            window?.rootViewController = rootViewController
            window?.makeKeyAndVisible()
        }
    }
}
