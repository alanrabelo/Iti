//
//  FormStackView.swift
//  Iti
//
//  Created by Alan Rabelo Martins on 12/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import UIKit

class FormStackView: UIStackView, CodeView {
    
    func setupComponents() {
        setupTextField()
    }
    
    func setupConstraints() {
        
    }
    
    func setupExtraConfigurations() {
        
    }
    
    var textfieldType: TextFieldType
    var textfieldDelegate: UITextFieldDelegate?
    
    let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    let textField: CustomTextfield = {
        let textField = CustomTextfield(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = true
        return textField
    }()
    
    init(labelText: String, placeholder: String, textfieldType: TextFieldType, textFieldText: String = "") {
        label.text = labelText
        textField.placeholder = placeholder
        textField.text = textFieldText
        self.textfieldType = textfieldType
        super.init(frame: .zero)
    }
    
    private func setupTextField() {
        switch textfieldType {
        case .title:
            textField.keyboardType = .default
        case .price:
            textField.keyboardType = .decimalPad
        case .date:
            textField.keyboardType = .default
        case .ammount:
            textField.keyboardType = .numberPad
        }
        
        textField.delegate = textfieldDelegate
    }
    
    required init(coder: NSCoder) {
        self.textfieldType = .title
        super.init(coder: coder)
    }
}
