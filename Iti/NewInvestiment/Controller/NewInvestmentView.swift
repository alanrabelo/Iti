
//
//  NewInvestmentView.swift
//  Iti
//
//  Created by Alan Rabelo Martins on 12/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import UIKit

class NewInvestmentView: UIView, CodeView {
    
    weak var textFieldDelegate: UITextFieldDelegate?
    
    private let labelTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = true
        label.text = "Preencha as informações sobre a sua nova compra de ações"
        return label
    }()

    private let labelName: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = true
        label.text = "Ativo"
        return label
    }()
    private let labelQuantity: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = true
        label.text = "Quantidade"
        return label
    }()
    private let labelPrice: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = true
        label.text = "Preço da Compra"
        return label
    }()

    private let labelStartDate: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = true
        label.text = "Data de Início"
        return label
    }()

    private let textFieldName: UITextField = {
        let textField = UITextField
    }()

    
    func setupComponents() {
        <#code#>
    }
    
    func setupConstraints() {
        <#code#>
    }
    
    func setupExtraConfigurations() {
        <#code#>
    }

    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
