//
//  ForexModel.swift
//  Iti
//
//  Created by Italus Rodrigues do Prado on 05/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import Foundation

struct Forex: Codable {
    
    let symbol: String
    let price: String
    
    enum CodingKeys: String, CodingKey {
        case symbol = "01. symbol"
        case price = "05. price"
    }
    
    var priceFormatted: String {
        "\((Double(price) ?? 0.0).formattedPrice)"
    }

}
