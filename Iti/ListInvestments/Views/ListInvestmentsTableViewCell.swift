//
//  ListInvestmentsTableViewCell.swift
//  Iti
//
//  Created by Italus Rodrigues do Prado on 05/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import UIKit

class ListInvestmentsTableViewCell: UITableViewCell {

    @IBOutlet weak var barView: UIView!
    
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var activeLabel: UILabel!
    @IBOutlet weak var saldoAtualLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        barView.layer.cornerRadius = barView.frame.width/2
        barView.layer.masksToBounds = true
    }
    
    // MARK: - Methods
    func configure(with viewModel: ListInvestmentsCellViewModel) {
        activeLabel.text = viewModel.active
        saldoAtualLabel.text = viewModel.totalValue
        percentageLabel.text = viewModel.percentageValue
    }
//    func configure(with investiment: Investment?, currentValue: Double? = nil) {
//        activeLabel.text = investiment?.active?.uppercased()
//        if let price = investiment?.price, let quantity = investiment?.quantity {
//            if let currentValue = currentValue {
//                let formattedPrice = (currentValue * quantity).formattedPrice
//                saldoAtualLabel.text = "\(formattedPrice)"
//            } else {
//                let formattedPrice = (price * quantity).formattedPrice
//                saldoAtualLabel.text = "\(formattedPrice)"
//            }
//        }
//    }
}
