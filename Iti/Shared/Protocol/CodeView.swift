//
//  CodeView.swift
//  Iti
//
//  Created by Marcos Lacerda on 12/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import Foundation

protocol CodeView {
    
    func setup()
    
    func setupComponents()
    
    func setupConstraints()
    
    func setupExtraConfigurations()
}

extension CodeView {
    
    func setup() {
        
        setupComponents()
        
        setupConstraints()
        
        setupExtraConfigurations()
    }
}
