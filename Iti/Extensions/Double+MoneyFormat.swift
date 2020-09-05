//
//  String+MoneyFormat.swift
//  Iti
//
//  Created by Italus Rodrigues do Prado on 05/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import Foundation

extension Double {
    var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from:
            NSNumber(value: self))
            ?? "R$ \(self)"
    }
}
