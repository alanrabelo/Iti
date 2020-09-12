//
//  DetailInvestimentLbInfos.swift
//  Iti
//
//  Created by Marcos Lacerda on 12/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import UIKit

class LbInfos: UILabel {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
    }
    
    private func commonInit() {
        
     //text                                          = Localization.welcomeText
      
       textAlignment                                 = .center
      
       font                                          = .lbInfos
      
       textColor                                     = .lbInfos
      
     //accessibilityIdentifier                     = "welcome-title-label"
      
       translatesAutoresizingMaskIntoConstraints     = false
                  
    }
}

