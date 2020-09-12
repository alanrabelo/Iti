//
//  InvestimentViewModel.swift
//  Iti
//
//  Created by Alan Rabelo Martins on 12/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import UIKit
import CoreData

protocol InvestmentViewModelDelegate: AnyObject {
    func didCreateInvestment(_ viewModel: InvestmentViewModel)
    func errorCreatingInvestment(_ viewModel: InvestmentViewModel)
    func didValidateTextfields(_ viewModel: InvestmentViewModel, _ validation: (Bool, Bool, Bool))
}

class InvestmentViewModel {
    
    //MARK: - Properties
    private var investment: Investment
    private var context: NSManagedObjectContext
    var newInvestmentModel: NewInvestmentModel
    weak var delegate: InvestmentViewModelDelegate?
    
    
    private var rawPrice: Double {
        return Double(newInvestmentModel.price) / 100
    }
    
    var price: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR") // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        formatter.numberStyle = .currency
        return formatter.string(from: Double(newInvestmentModel.price)/100 as NSNumber) ?? "R$ 0,00"
    }
    
    var purchaseDate: String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateStyle = .short
        let selectedDate: String = dateFormatter.string(from: newInvestmentModel.startDate.asDate)
        return selectedDate
    }
    
    var rawQuantity: Int {
        return Int(newInvestmentModel.quantity)
    }
    
    var quantity: String {
        return rawQuantity > 0 ? "\(rawQuantity)" : ""
    }
    
    var name: String {
        return newInvestmentModel.active.uppercased()
    }
    
    init(in context: NSManagedObjectContext) {
        self.investment = Investment(context: context)
        self.newInvestmentModel = NewInvestmentModel(withModel: nil)
        self.context = context
    }
    
    init(withModel model: Investment, in context: NSManagedObjectContext) {
        self.investment = model
        self.newInvestmentModel = NewInvestmentModel(withModel: model)
        self.context = context
    }
    
    func validateInput() -> (Bool, Bool, Bool) {
        let validation = (name != "", rawPrice != 0, rawQuantity != 0)
        delegate?.didValidateTextfields(self, validation)
        return validation
    }
    
    func save() {
        let validationResult = validateInput()
        if !validationResult.0 || !validationResult.1 || !validationResult.2 {
            delegate?.errorCreatingInvestment(self)
            return
        }
        
        investment.quantity = newInvestmentModel.quantity
        investment.active = newInvestmentModel.active
        investment.price = Double(newInvestmentModel.price)/100
        investment.startDate = newInvestmentModel.startDate
        
        do {
            try context.save()
            delegate?.didCreateInvestment(self)
        } catch {
            delegate?.errorCreatingInvestment(self)
            print("Failed saving")
        }
    }
    
    func shouldChangeCharactersIn(priceTextfield textfield: UITextField, _ replacement: String, _ newString: String?) -> Bool {
        var priceAsString = String(self.newInvestmentModel.price)
        let numberOfDigits = priceAsString.lengthOfBytes(using: .utf8)
        let newStringLength = replacement.lengthOfBytes(using: .utf8)
        if numberOfDigits == 0 { return true }
        
        if newStringLength == 0 && numberOfDigits > 0 {
            priceAsString.removeLast()
            if priceAsString.lengthOfBytes(using: .utf8) == 0 {
                newInvestmentModel.price = 0
                textfield.text = price
                return false
            }
        }
        
        guard let newPrice = Int(priceAsString + replacement) else { return false }
        newInvestmentModel.price = Int(newPrice)
        textfield.text = price
        return false
    }
    
    func shouldChangeCharactersIn(quantityTextfield textfield: UITextField, _ replacement: String, _ newString: String?) -> Bool {
        let newStringLength = newString?.lengthOfBytes(using: .utf8) ?? 0
        if newStringLength <= 0 {
            return true
        }
        let textIsNotNumerical = Int(newString ?? "") == nil && newStringLength > 0
        if textIsNotNumerical {
            return false
        }
        guard let newText = newString, let ammount = Double(newText) else { return false }
        newInvestmentModel.quantity = ammount
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: CustomTextfield) {
        if textField.status == .invalid {
            textField.text = ""
            textField.status = .valid
        }
        
        if textField.type == .price {
            textField.text = price
        }
    }
}
