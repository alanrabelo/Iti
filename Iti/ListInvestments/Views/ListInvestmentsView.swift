//
//  ListInvestmentsView.swift
//  Iti
//
//  Created by Italus Rodrigues do Prado on 12/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import UIKit

class ListInvestmentsView: UIView, CodeView {
    
    //MARK: - Properties
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 10
        tableView.layer.masksToBounds = true
        return tableView
    }()
    
    let topView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "MainOrange") ?? .orange
        //        let firstColor = UIColor(named: "MainOrange") ?? .white
        //        let secondColor = UIColor(named: "MainPink") ?? .white
        
        //        view.addGradientSublayer(firstColor: firstColor, secondColor: secondColor, endPoint: CGPoint(x: 1.5, y: 0.0))
        
        return view
    }()
    
    let patrimonyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "meu patrimônio"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .white
        label.alpha = 0.5
        
        return label
    }()
    
    let totalAmmountLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "R$ 0,00"
        label.font = .systemFont(ofSize: 34, weight: .semibold)
        label.textColor = .white
        
        return label
    }()
    
    let eyeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let newInvestmentButton: GradientButton = {
        let button = GradientButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Novo Investimento", for: .normal)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.backgroundColor = .orange
        return button
    }()
    
    // MARK: - Inits
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Methods
    func setupComponents() {
        addSubview(topView)
        addSubview(tableView)
        addSubview(newInvestmentButton)
        
        //TopView Subviews
        topView.addSubview(patrimonyLabel)
        topView.addSubview(totalAmmountLabel)
        topView.addSubview(eyeButton)
    }
    
    func setupConstraints() {
        //TopView
        topView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        topView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        topView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        topView.bottomAnchor.constraint(equalTo: totalAmmountLabel.bottomAnchor, constant: 20).isActive = true
        
        //PatrimonyLabel
        patrimonyLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 10).isActive = true
        patrimonyLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 20).isActive = true
        
        //TotalAmmountLabel
        totalAmmountLabel.topAnchor.constraint(equalTo: patrimonyLabel.bottomAnchor).isActive = true
        totalAmmountLabel.leadingAnchor.constraint(equalTo: patrimonyLabel.leadingAnchor).isActive = true
        
        //EyeButton
        eyeButton.centerYAnchor.constraint(equalTo: totalAmmountLabel.centerYAnchor).isActive = true
        eyeButton.leadingAnchor.constraint(equalTo: totalAmmountLabel.trailingAnchor, constant: 10).isActive = true
        
        //NewInvestmentButton
        newInvestmentButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        newInvestmentButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        newInvestmentButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        newInvestmentButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //TableView
        tableView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: newInvestmentButton.topAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        tableView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
    }
    
    func setupExtraConfigurations() {
        self.backgroundColor = .white
        tableView.register(ListInvestmentsTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
}
