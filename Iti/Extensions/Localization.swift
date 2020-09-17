//
//  Localization.swift
//  Iti
//
//  Created by Cleber Reis on 16/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import Foundation

enum Localization {
    static let profileText = "PROFILE".localized
    static let balanceText = "BALANCE".localized
    static let aboutText = "ABOUT_HOME".localized
    static let heritageText = "MY_HERITAGE".localized
    static let currentBalanceText = "CURRENT_BALANCE".localized
    static let inWalletText = "IN_WALLET".localized
    static let newInvestimentText = "NEW_INVESTIMENT".localized
    static let noRegisteredText = "NO_REGISTERED_ACTIONS".localized
    static let quantityText = "QUANTITY".localized
    static let purchasePriceText = "PURCHASE_PRICE".localized
    static let purchaseDateText = "PURCHASE_DATE".localized
    static let amountText = "AMOUNT".localized
    static let quoteTodayText = "QUOTE_TODAY".localized
    static let valueTodayText = "VALUE_TODAY".localized
    static let profitabilityText = "PROFITABILITY".localized
    static let editInformationText = "EDIT_INFORMATION".localized
    static let titleInvestimentText = "TITLE_INVESTIMENT".localized
    static let activeText = "ACTIVE".localized
    static let quantityNewText = "QUANTITY_NEW".localized
    static let purchasePriceNewText = "PURCHASE_PRICEE_NEW".localized
    static let startDateText = "START_DATE".localized
    static let investText = "INVEST".localized
    static let requiredFieldText = "REQUIRED_FIELD".localized
    static let activedPlaceholder = "NAME_ACTIVED_PLACEHOLDER".localized
    static let quantityPlaceholder = "QUANTITY_PLACEHOLDER".localized
}

extension String {
   var localized: String {
       return NSLocalizedString(self, comment: "")
   }
}
