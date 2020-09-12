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
    weak var investmentModelDelegate: InvestmentViewModelDelegate?
    private let labelTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Preencha as informações sobre a sua nova compra de ações"
        return label
    }()
    
    let stackViewName: FormStackView = {
        return FormStackView(labelText: "Ativo", placeholder: "Digite um nome para seu ativo", textfieldType: .title)
    }()
    
    let stackViewQuantity: FormStackView = {
        return FormStackView(labelText: "Quantidade", placeholder: "Quantas ações você gostaria de investir?", textfieldType: .title)
    }()
    
    let stackViewPrice: FormStackView = {
        return FormStackView(labelText: "Preço de Compra", placeholder: "", textfieldType: .title)
    }()
    
    let stackViewStartDate: FormStackView = {
        return FormStackView(labelText: "Data de início", placeholder: "", textfieldType: .title)
    }()
    
    let buttonInvest: UIButton = {
        let button = GradientButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Investir", for: .normal)
        return button
    }()
    
    let buttonDismiss: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        return button
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.keyboardDismissMode = .interactive
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        return scrollView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    init(textFieldDelegate: UITextFieldDelegate, investmentsModelDelegate: InvestmentViewModelDelegate) {
        self.textFieldDelegate = textFieldDelegate
        self.investmentModelDelegate = investmentsModelDelegate
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupComponents() {
        
        stackViewName.textfieldDelegate = self
        stackViewPrice.textfieldDelegate = self
        stackViewQuantity.textfieldDelegate = self
        stackViewStartDate.textfieldDelegate = self
        
        self.addSubview(buttonDismiss)
        self.addSubview(labelTitle)
        self.addSubview(scrollView)
        
        stackView.addArrangedSubview(stackViewName)
        stackView.addArrangedSubview(stackViewPrice)
        stackView.addArrangedSubview(stackViewQuantity)
        stackView.addArrangedSubview(stackViewStartDate)
        scrollView.addSubview(stackView)
        self.addSubview(buttonInvest)
    }
    
    func setupConstraints() {
        
        // Button Dismiss
        buttonDismiss.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        buttonDismiss.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        buttonDismiss.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonDismiss.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        // LabelTitle
        labelTitle.topAnchor.constraint(equalTo: buttonDismiss.bottomAnchor, constant: 10).isActive = true
        labelTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        labelTitle.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 20).isActive = true
        
        //ScrollView
        scrollView.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 10).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        //Content View
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        let contentViewHeightContraint = stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        contentViewHeightContraint.priority = .defaultLow
        contentViewHeightContraint.isActive = true
        
        // Button
        buttonInvest.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 20).isActive = true
        buttonInvest.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        buttonInvest.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        buttonInvest.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupExtraConfigurations() {
        self.backgroundColor = .white
    }

    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension NewInvestmentView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return textFieldDelegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: string) ?? true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldDelegate?.textFieldDidBeginEditing?(textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldDelegate?.textFieldDidEndEditing?(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textFieldDelegate?.textFieldShouldReturn?(textField) ?? false
    }
}

extension NewInvestmentView: InvestmentViewModelDelegate {
    
    func didValidateTextfields(_ viewModel: InvestmentViewModel, _ validation: (Bool, Bool, Bool)) {
        investmentModelDelegate?.didValidateTextfields(viewModel, validation)
    }
    
    func didCreateInvestment(_ viewModel: InvestmentViewModel) {
        investmentModelDelegate?.didCreateInvestment(viewModel)
    }
    
    func errorCreatingInvestment(_ viewModel: InvestmentViewModel) {
        investmentModelDelegate?.errorCreatingInvestment(viewModel)
    }
}
