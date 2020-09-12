//
//  DetailInvestimentLbTitle.swift
//  Iti
//
//  Created by Marcos Lacerda on 12/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import UIKit

class LbTitle: UILabel {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    convenience init(title: String) {
        
        self.init(frame: .zero)
       
        commonInit(title: title)
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
    }
    
    private func commonInit(title : String) {
        
        text                                          = title
                
        textAlignment                                 = .center
        
        font                                          = .lbTitle
        
        textColor                                     = .lbTitle
                
        translatesAutoresizingMaskIntoConstraints     = false
    }
}

