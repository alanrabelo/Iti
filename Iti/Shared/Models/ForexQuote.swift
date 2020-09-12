//
//  ForexQuote.swift
//  Iti
//
//  Created by Italus Rodrigues do Prado on 05/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import Foundation

struct ForexQuote: Codable {
    
    let quote: Forex
    
    enum CodingKeys: String, CodingKey {
        case quote = "Global Quote"
    }
}
