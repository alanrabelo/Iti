//
//  ListInvestmentsTableViewCell.swift
//  Iti
//
//  Created by Italus Rodrigues do Prado on 05/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import UIKit

class ListInvestmentsTableViewCell: UITableViewCell {
    
    let barView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "MainPink") ?? .white
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        return view
    }()
    
    let activeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 16)
        label.text = "Teste"
        return label
    }()
    
    let saldoTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 12)
        label.text = "saldo atual"
        return label
    }()
    
    let saldoAtualLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "MainPink") ?? .black
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.text = "R$ --,--"
        return label
    }()
    
    let percentageTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.text = "% na carteira"
        return label
    }()
    
    let percentageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "MainPink") ?? .black
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.text = "0,00%"
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // MARK: - Methods
    func configure(with viewModel: ListInvestmentsCellViewModel) {
        setup()
        activeLabel.text = viewModel.active
        saldoAtualLabel.text = viewModel.totalValue
        percentageLabel.text = viewModel.percentageValue
    }
    
}

extension ListInvestmentsTableViewCell: CodeView {
    func setupComponents() {
        addSubview(barView)
        addSubview(activeLabel)
        addSubview(saldoTitleLabel)
        addSubview(saldoAtualLabel)
        addSubview(percentageLabel)
        addSubview(percentageTitleLabel)
    }
    
    func setupConstraints() {
        //BarView
        barView.widthAnchor.constraint(equalToConstant: 4).isActive = true
        barView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
        barView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        barView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        
        //ActiveLabel
        activeLabel.topAnchor.constraint(equalTo: barView.topAnchor).isActive = true
        activeLabel.leadingAnchor.constraint(equalTo: barView.trailingAnchor, constant: 10).isActive = true
        
        //SaldoTitleLabel
        saldoTitleLabel.centerYAnchor.constraint(equalTo: barView.centerYAnchor).isActive = true
        saldoTitleLabel.leadingAnchor.constraint(equalTo: activeLabel.leadingAnchor).isActive = true
        
        //SaldoAtualLabel
        saldoAtualLabel.bottomAnchor.constraint(equalTo: barView.bottomAnchor).isActive = true
        saldoAtualLabel.leadingAnchor.constraint(equalTo: activeLabel.leadingAnchor).isActive = true
        
        //PercentageLabel
        percentageLabel.bottomAnchor.constraint(equalTo: barView.bottomAnchor).isActive = true
        percentageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        //PercentageTitleLabel
        percentageTitleLabel.bottomAnchor.constraint(equalTo: percentageLabel.topAnchor).isActive = true
        percentageTitleLabel.trailingAnchor.constraint(equalTo: percentageLabel.trailingAnchor).isActive = true
    }
    
    func setupExtraConfigurations() {
        
    }
    
    
}
