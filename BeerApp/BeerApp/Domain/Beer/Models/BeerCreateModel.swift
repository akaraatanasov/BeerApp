//
//  BeerCreateModel.swift
//  BeerApp
//
//  Created by Alexander Karaatanasov on 30.09.20.
//  Copyright © 2020 Alexander Karaatanasov. All rights reserved.
//

import Foundation

struct BeerCreateModel: Codable {
    var name: String
    var type: String
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case type = "beer_type"
        case description
    }
}
