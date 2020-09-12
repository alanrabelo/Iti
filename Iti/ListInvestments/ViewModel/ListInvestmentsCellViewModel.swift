//
//  ListInvestmentsCellViewModel.swift
//  Iti
//
//  Created by Italus Rodrigues do Prado on 12/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import Foundation

class ListInvestmentsCellViewModel {
    
    private let investment: Investment
    private let percentage: Double
    
    init(investment: Investment, percentage: Double) {
        self.investment = investment
        self.percentage = percentage
    }
    
    var active: String {
        investment.active?.uppercased() ?? "-----"
    }
    
    var totalValue: String {
        let formattedPrice = (investment.price * investment.quantity).formattedPrice
        return "\(formattedPrice)"
    }
    
    var percentageValue: String {
        let percentageString = String(format: "%.2f", percentage)
        return "\(percentageString)%"
    }
    
}
