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
//    @IBOutlet weak var textfieldStockName: CustomTextfield!
//    @IBOutlet weak var textfieldStockAmmount: CustomTextfield!
//    @IBOutlet weak var textfieldStockPrice: CustomTextfield!
//    @IBOutlet weak var textfieldPurchaseDate: CustomTextfield!
//    @IBOutlet weak var labelStockName: CustomLabel!
//    @IBOutlet weak var labelStockAmmount: CustomLabel!
//    @IBOutlet weak var labelPurchasePrice: CustomLabel!
//    @IBOutlet weak var labelPurchaseDate: CustomLabel!
//    @IBOutlet weak var scrollView: UIScrollView!
    
    weak var coordinator: NewInvestmentCoordinator?
    
    // MARK: - Properties
    var activeTextfield: CustomTextfield?
    lazy var viewModel: InvestmentViewModel = InvestmentViewModel(in: context)
    var formView: NewInvestmentView {
        self.view as! NewInvestmentView
    }
    
    private var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "pt_BR")
        datePicker.date = Date()
        datePicker.maximumDate = Date()
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        return datePicker
    }()

    private var toolbar: UIToolbar = {
        let textToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        textToolbar.barStyle = .default
        textToolbar.items = [
            UIBarButtonItem(title: "Ok", style: .plain, target: self, action: #selector(keyboardOkAction)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Próximo", style: .plain, target: self, action: #selector(keyboardNextAction))]
        textToolbar.sizeToFit()
        return textToolbar
    }()
    
        
    // MARK: - IBActions
    @IBAction func sendRequest(_ sender: Any) {
        viewModel.save()
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
        viewModel.delegate = self
        setupKeyboardNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.view = formView
        formView.buttonDismiss.addTarget(self, action: #selector(didTapDismissButton), for: .touchDown)
        
//        setupTextFields()
    }
    
    // MARK: - Date Picker
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        viewModel.newInvestmentModel.startDate = sender.date.asString
        formView.stackViewStartDate.textField.text = viewModel.purchaseDate
    }
    
    func presentDatePicker() {
        
        viewModel.newInvestmentModel.startDate = datePicker.date.asString
    }
    
    // MARK: Textfields
    func moveToNext(fromTextField textfield: CustomTextfield) {
        switch textfield.type {
        case .title:
            formView.stackViewName.textField.becomeFirstResponder()
        case .ammount:
            formView.stackViewQuantity.textField.becomeFirstResponder()
        case .price:
            formView.stackViewPrice.textField.becomeFirstResponder()
        case .date:
            formView.stackViewStartDate.textField.becomeFirstResponder()
        }
    }
    
//    func setupTextFields() {
//        textfieldPurchaseDate.text = viewModel.purchaseDate
//        textfieldStockPrice.text = viewModel.price
//        textfieldStockAmmount.text = viewModel.quantity
//        textfieldStockName.text = viewModel.name
//
//        textfieldStockAmmount.type = .ammount
//        textfieldStockAmmount.label = labelStockAmmount
//
//        textfieldStockPrice.type = .price
//        textfieldStockPrice.label = labelPurchasePrice
//
//        textfieldPurchaseDate.type = .date
//        textfieldPurchaseDate.label = labelPurchaseDate
//
//        textfieldStockName.type = .title
//        textfieldStockName.label = labelStockName
//    }
    
    // MARK: - Keyboard Notifications for Scrollview
    func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = formView.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        formView.scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        formView.scrollView.contentInset = contentInset
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
    
    @objc func didTapDismissButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    deinit {
        print("NewInvestmentViewController deinit")
    }
}

extension NewInvestmentViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text,
            let textRange = Range(range, in: text) else
        { return true }
        
        let newText = text.replacingCharacters(in: textRange, with: string)
        
        if textField == formView.stackViewPrice.textField {
            return viewModel.shouldChangeCharactersIn(priceTextfield: textField, string, newText)
        } else if textField == formView.stackViewQuantity.textField {
            return viewModel.shouldChangeCharactersIn(quantityTextfield: textField, string, newText)
        } else if textField == formView.stackViewName.textField {
            viewModel.newInvestmentModel.active = newText
        } 
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let currentTextField = textField as? CustomTextfield else { return }
        viewModel.textFieldDidBeginEditing(currentTextField)
        activeTextfield = currentTextField
        textField.inputAccessoryView = toolbar
        print(currentTextField.type)
        if currentTextField.type == .date {
            textField.inputView = datePicker
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

extension NewInvestmentViewController: InvestmentViewModelDelegate {
    
    func didValidateTextfields(_ viewModel: InvestmentViewModel, _ validation: (Bool, Bool, Bool)) {
        if !validation.0 {
            formView.stackViewName.textField.status = .invalid
        }
        if !validation.1 {
            formView.stackViewPrice.textField.status = .invalid
        }
        if !validation.2 {
            formView.stackViewQuantity.textField.status = .invalid
        }
    }
    
    func didCreateInvestment(_ viewModel: InvestmentViewModel) {
        dismiss(animated: true, completion: nil)
    }
    
    func errorCreatingInvestment(_ viewModel: InvestmentViewModel) {
        
    }
    
}
