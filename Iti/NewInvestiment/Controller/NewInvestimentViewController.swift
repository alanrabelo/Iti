//
//  NewInvestimentViewController.swift
//  Iti
//
//  Created by Alan Rabelo Martins on 05/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import UIKit

class NewInvestimentViewController: UIViewController {
    
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
    private var datePicker: UIDatePicker?
    private var purchaseDate: Date = Date()
    private var ammount: Int = 0
    private var price: Int = 0 {
        didSet {
            textfieldStockPrice.text = formattedPrice
        }
    }
    
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
        return formatter.string(from: Float(price)/100 as NSNumber) ?? "R$ 0,00"
    }
    
    private var formattedPurchaseDate: String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateStyle = .short
        let selectedDate: String = dateFormatter.string(from: self.purchaseDate)
        return selectedDate
    }
    
    // MARK: - IBActions
    @IBAction func sendRequest(_ sender: Any) {
        if validateInput() {
            print("Enviando dados")
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        textfieldStockName.becomeFirstResponder()
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
            purchaseDate = date
            textfieldPurchaseDate.text = formattedPurchaseDate
        }
    }
    
    func presentDatePicker() {
        if let datePicker = self.datePicker {
            self.purchaseDate = datePicker.date
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
        if textfieldStockPrice.text == "" || price == 0 {
            textfieldStockPrice.status = .invalid
            isValid = false
        }
        if textfieldStockAmmount.text == "" || ammount == 0 {
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

extension NewInvestimentViewController: UITextFieldDelegate {
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
        var priceAsString = String(price)
        let numberOfDigits = priceAsString.lengthOfBytes(using: .utf8)
        let newStringLength = replacement.lengthOfBytes(using: .utf8)
        if numberOfDigits == 0 { return true }
        
        if newStringLength == 0 && numberOfDigits > 0 {
            priceAsString.removeLast()
            if priceAsString.lengthOfBytes(using: .utf8) == 0 {
                price = 0
                return false
            }
        }
        
        guard let newPrice = Int(priceAsString + replacement) else { return false }
        price = Int(newPrice)
        return false
    }
    
    func validateStockAmmount(_ previous: String?, _ replacement: String, _ newString: String?) -> Bool {
        let newStringLength = newString?.lengthOfBytes(using: .utf8) ?? 0
        let textIsNotNumerical = Int(replacement) == nil && newStringLength > 0
        if textIsNotNumerical {
            return false
        }
        guard let newText = newString, let ammount = Int(newText) else { return false }
        self.ammount = ammount
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let currentTextField = textField as? CustomTextfield else { return }
        currentTextField.status = .valid
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
