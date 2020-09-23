//
//  FormStackView.swift
//  Iti
//
//  Created by Alan Rabelo Martins on 12/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import UIKit

class FormStackView: UIStackView, CodeView {
    
    // MARK: - Variables
    var textfieldType: TextFieldType = .date
    var textfieldDelegate: UITextFieldDelegate?
    
    // MARK: - Visual Elements
    let label: CustomLabel = {
        let label = CustomLabel(frame: .zero)
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
    
    // MARK: - Methods
    init(labelText: String, placeholder: String, textfieldType: TextFieldType, delegate: UITextFieldDelegate, textFieldText: String = "") {
        label.text = labelText
        textField.placeholder = placeholder
        textField.text = textFieldText
        textfieldDelegate = delegate
        textField.type = textfieldType
        textField.label = label
        
        super.init(frame: .zero)
        setupTextField()
        setup()
        setupStackView()
    }
    
    required init(coder: NSCoder) {
        self.textfieldType = .date
        super.init(coder: coder)
    }
    
    private func setupStackView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addArrangedSubview(label)
        self.addArrangedSubview(textField)
        self.axis = .vertical
        self.distribution = .fillEqually
        self.alignment = .fill
        self.spacing = 0
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
    
    func setupComponents() {}
    
    func setupConstraints() {
        label.heightAnchor.constraint(equalToConstant: 35).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    func setupExtraConfigurations() {}
    
}
