//
//  DetailInvestimentView.swift
//  Iti
//
//  Created by Marcos Lacerda on 12/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import UIKit

protocol DetailInvestimentViewDelegate: AnyObject {
   
    func exitButtonTapped()
    
    func editInfosButtonTapped()
}

enum CodeViewState {
   
    case start, animating, finish
}

class DetailInvestimentView: UIView, CodeView {
 
    // MARK: - Properties
   
    weak var delegate : DetailInvestimentViewDelegate?
    
    var state         : CodeViewState = .start
    
    let contentView: UIView = {
           
        let contentView = UIView(frame: .zero)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()
}


extension DetailInvestimentView {
    
    func setupComponents() {
         
     }
     
     func setupConstraints() {
         
     }
     
     func setupExtraConfigurations() {
         
     }
}
