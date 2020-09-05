//
//  GradientButton.swift
//  Iti
//
//  Created by Italus Rodrigues do Prado on 05/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import UIKit

class GradientButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        self.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.masksToBounds = true
        let gradientColor = UIColor.gradientColorFor(view: self, firstColor: UIColor(named: "MainOrange")!, secondColor: UIColor(named: "MainPink")!)
        self.layer.insertSublayer(gradientColor, at: 0)
    }

}
