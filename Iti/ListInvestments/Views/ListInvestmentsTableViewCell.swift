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
    func configure(with investiment: Investment?) {
        activeLabel.text = investiment?.active
        saldoAtualLabel.text = "\(investiment?.price)"
    }

}