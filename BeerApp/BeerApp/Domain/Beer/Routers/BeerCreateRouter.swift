//
//  BeerCreateRouter.swift
//  BeerApp
//
//  Created by Alexander Karaatanasov on 30.09.20.
//  Copyright © 2020 Alexander Karaatanasov. All rights reserved.
//

import UIKit

class BeerCreateRouter: Router {
    
    // MARK: - Router Conformance
    
    func route(on baseVC: UIViewController?, context: Any?, animated: Bool) {
        guard let routes = context as? BeerCreateViewModel.Routes else {
            assertionFailure("The route enum is missmatched!")
            return
        }
        
        switch routes {
        case .beerList:
            baseVC?.dismiss(animated: animated)
        }
    }

}
