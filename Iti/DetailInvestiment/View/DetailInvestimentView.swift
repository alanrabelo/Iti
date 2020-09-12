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
    
    let lbStockIdentifier: UILabel = {
          
          let label                                           = UILabel(frame: .zero)
          
          //label.text                                          = Localization.welcomeText
          
          label.textAlignment                                 = .center
          
          label.font                                          = .lbStockIdentifier
          
          label.textColor                                     = .lbStockIdentifier
          
         // label.accessibilityIdentifier                       = "welcome-title-label"
          
          label.translatesAutoresizingMaskIntoConstraints     = false
          
          return label
      }()
    
    let lbTitle : UILabel = {
        
        let label                                           = UILabel(frame: .zero)
        
        //label.text                                          = Localization.welcomeText
        
        label.textAlignment                                 = .center
        
        label.font                                          = .lbTitle
        
        label.textColor                                     = .lbTitle
        
        //label.accessibilityIdentifier                       = "welcome-title-label"
        
        label.translatesAutoresizingMaskIntoConstraints     = false
        
        return label
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
