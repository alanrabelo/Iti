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
    }
    
    func setupConstraints() {
        label.heightAnchor.constraint(equalToConstant: 35).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    func setupExtraConfigurations() {
        
    }
    
    var textfieldType: TextFieldType = .date
    var textfieldDelegate: UITextFieldDelegate?
    
    let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    let textField: CustomTextfield = {
        let textField = CustomTextfield(frame: .zero)
        textField.borderStyle = .none
        textField.layer.cornerRadius = 5
        textField.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 247/255, alpha: 1)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "System", size: 14)
        return textField
    }()
    
    init(labelText: String, placeholder: String, textfieldType: TextFieldType, delegate: UITextFieldDelegate, textFieldText: String = "") {
        label.text = labelText
        textField.placeholder = placeholder
        textField.text = textFieldText
        textfieldDelegate = delegate
        textField.type = textfieldType
        
        super.init(frame: .zero)
        setupTextField()
        setup()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addArrangedSubview(label)
        self.addArrangedSubview(textField)
        self.axis = .vertical
        self.distribution = .fillEqually
        self.alignment = .fill
        self.spacing = 8
    }
    
    required init(coder: NSCoder) {
        self.textfieldType = .date
        super.init(coder: coder)
    }
    
    private func setupTextField() {
        switch textField.type {
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
    
}
