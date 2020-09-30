//
//  BeerDisplayModel.swift
//  BeerApp
//
//  Created by Alexander Karaatanasov on 26.09.20.
//  Copyright © 2020 Alexander Karaatanasov. All rights reserved.
//

import Foundation

struct BeerDisplayModel: Codable {
    var id: Int
    var name: String
    var type: String
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case type = "beer_type"
        case description
    }
}
