//
//  NewInvestimentViewController.swift
//  Iti
//
//  Created by Alan Rabelo Martins on 05/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import UIKit

class NewInvestmentViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var textfieldStockName: CustomTextfield!
    @IBOutlet weak var textfieldStockAmmount: CustomTextfield!
    @IBOutlet weak var textfieldStockPrice: CustomTextfield!
    @IBOutlet weak var textfieldPurchaseDate: CustomTextfield!
    @IBOutlet weak var labelStockName: CustomLabel!
    @IBOutlet weak var labelStockAmmount: CustomLabel!
    @IBOutlet weak var labelPurchasePrice: CustomLabel!
    @IBOutlet weak var labelPurchaseDate: CustomLabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Properties
    var activeTextfield: CustomTextfield?
    var investment: Investment?
    private var datePicker: UIDatePicker?
    var newInvestmentModel = NewInvestmentModel(withModel: nil)

    private var toolbar: UIToolbar {
        let textToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        textToolbar.barStyle = .default
        textToolbar.items = [
            UIBarButtonItem(title: "Ok", style: .plain, target: self, action: #selector(keyboardOkAction)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Próximo", style: .plain, target: self, action: #selector(keyboardNextAction))]
        textToolbar.sizeToFit()
        return textToolbar
    }
    
    private var name: String = ""
    
    private var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR") // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        formatter.numberStyle = .currency
        return formatter.string(from: Double(newInvestmentModel.price)/100 as NSNumber) ?? "R$ 0,00"
    }
    
    private var formattedPurchaseDate: String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateStyle = .short
        let selectedDate: String = dateFormatter.string(from: newInvestmentModel.startDate.asDate)
        return selectedDate
    }
    
    // MARK: - IBActions
    @IBAction func sendRequest(_ sender: Any) {
        if validateInput() {
            
            if investment == nil {
                investment = Investment(context: context)
            }
            
            if let ammountString = textfieldStockAmmount.text {
                investment?.quantity = Double(ammountString) ?? 0
            }
            investment?.active = textfieldStockName.text ?? ""
            investment?.price = Double(newInvestmentModel.price)/100
            investment?.startDate = newInvestmentModel.startDate
            
            do {
                try context.save()
            } catch {
                print("Failed saving")
            }
            
            print("Enviando dados")
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func closeView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapScreen(_ sender: Any) {
        view.endEditing(true)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardNotifications()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupDatePicker()
        setupTextFields()
    }
    
    // MARK: - Date Picker
    func setupDatePicker() {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.locale = Locale(identifier: "pt_BR")
        datePicker?.maximumDate = Date()
        datePicker?.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        if let date = datePicker?.date {
            newInvestmentModel.startDate = date.asString
            textfieldPurchaseDate.text = formattedPurchaseDate
        }
    }
    
    func presentDatePicker() {
        if let datePicker = self.datePicker {
            newInvestmentModel.startDate = datePicker.date.asString
        }
    }
    
    // MARK: Textfields
    func moveToNext(fromTextField textfield: CustomTextfield) {
        switch textfield.type {
        case .title:
            textfieldStockAmmount.becomeFirstResponder()
        case .ammount:
            textfieldStockPrice.becomeFirstResponder()
        case .price:
            textfieldPurchaseDate.becomeFirstResponder()
        case .date:
            textfieldStockName.becomeFirstResponder()
        }
    }
    
    func setupTextFields() {
        textfieldPurchaseDate.text = formattedPurchaseDate
        textfieldStockPrice.text = formattedPrice
        let quantityString = newInvestmentModel.quantity > 0 ? "\(Int(newInvestmentModel.quantity))" : ""
        textfieldStockAmmount.text = quantityString
        textfieldStockName.text = newInvestmentModel.active.uppercased()
        
        textfieldStockAmmount.type = .ammount
        textfieldStockAmmount.label = labelStockAmmount
        
        textfieldStockPrice.type = .price
        textfieldStockPrice.label = labelPurchasePrice
        
        textfieldPurchaseDate.type = .date
        textfieldPurchaseDate.label = labelPurchaseDate
        
        textfieldStockName.type = .title
        textfieldStockName.label = labelStockName
    }
    
    func validateInput() -> Bool {
        var isValid = true
        
        if textfieldStockName.text == "" {
            textfieldStockName.status = .invalid
            isValid = false
        }
        if textfieldStockPrice.text == "" || newInvestmentModel.price == 0 {
            textfieldStockPrice.status = .invalid
            isValid = false
        }
        if textfieldStockAmmount.text == "" || newInvestmentModel.quantity == 0 {
            textfieldStockAmmount.status = .invalid
            isValid = false
        }
        
        return isValid
    }
    
    // MARK: - Keyboard Notifications for Scrollview
    func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    // MARK: Keyboard toolbar actions
    @objc func keyboardOkAction() {
        self.view.endEditing(true)
    }
    
    @objc func keyboardNextAction() {
        if let activeTextfield = activeTextfield {
            moveToNext(fromTextField: activeTextfield)
        }
    }
}

extension NewInvestmentViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var newText: String?
        
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            newText = text.replacingCharacters(in: textRange, with: string)
        }
        
        if textField == textfieldStockPrice {
            return validateStockPrice(textField.text, string, newText)
        } else if textField == textfieldStockAmmount {
            return validateStockAmmount(textField.text, string, newText)
        }
        return true
    }
    
    func validateStockPrice(_ previous: String?, _ replacement: String, _ newString: String?) -> Bool {
        var priceAsString = String(newInvestmentModel.price)
        let numberOfDigits = priceAsString.lengthOfBytes(using: .utf8)
        let newStringLength = replacement.lengthOfBytes(using: .utf8)
        if numberOfDigits == 0 { return true }
        
        if newStringLength == 0 && numberOfDigits > 0 {
            priceAsString.removeLast()
            if priceAsString.lengthOfBytes(using: .utf8) == 0 {
                newInvestmentModel.price = 0
                self.textfieldStockPrice.text = formattedPrice
                return false
            }
        }
        
        guard let newPrice = Int(priceAsString + replacement) else { return false }
        newInvestmentModel.price = Int(newPrice)
        self.textfieldStockPrice.text = formattedPrice
        return false
    }
    
    func validateStockAmmount(_ previous: String?, _ replacement: String, _ newString: String?) -> Bool {
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let currentTextField = textField as? CustomTextfield else { return }
        if currentTextField.status == .invalid {
            currentTextField.text = ""
            currentTextField.status = .valid
        }
        activeTextfield = currentTextField
        textField.inputAccessoryView = toolbar
        if textField == textfieldPurchaseDate {
            textField.inputView = datePicker
        } else if currentTextField.type == .price {
            currentTextField.text = formattedPrice
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextfield = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let currentTextField = textField as? CustomTextfield else { return false }
        moveToNext(fromTextField: currentTextField)
        return true
    }
}
