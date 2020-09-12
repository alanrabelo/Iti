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
    
    let lbAmount                     = LbTitle(title: "Quatidade")
    let lbPurchasePrice              = LbTitle(title: "Preço de Compra")
    let lbQuantityDescription        = LbInfos(frame: .zero)
    let lbPrice                      = LbInfos(frame: .zero)
    let lbPurchaseDate               = LbTitle(title: "Data da Compra")
    let lbTotalValue                 = LbTitle(title: "Valor Total")
    let lbDate                       = LbInfos(frame: .zero)
    let lbTotalValueText             = LbInfos(frame: .zero)
    let lbTodayQuote                 = LbTitle(title: "Cotação hoje")
    let lbTodayValue                 = LbTitle(title: "Valor Hoje")
    let lbTodayQuoteText             = LbTodayValues(frame: .zero)
    let lbTodayValueText             = LbTodayValues(frame: .zero)
    let lbProfitabilityTitle         = LbTitle(title: "Rentabilidade obtida até hoje")
    
    let contentView: UIView = {
           
        let contentView = UIView(frame: .zero)
        
        contentView.backgroundColor = UIColor.white
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()
    
    let lbStockIdentifier: UILabel = {
          
          let label                                           = UILabel(frame: .zero)
          
          label.text                                          = "ITAUSA"
          
          label.textAlignment                                 = .center
          
          label.font                                          = .lbStockIdentifier
          
          label.textColor                                     = .lbStockIdentifier
          
         // label.accessibilityIdentifier                       = "welcome-title-label"
          
          label.translatesAutoresizingMaskIntoConstraints     = false
          
          return label
      }()
    
    let viewLine: UIView = {
           
        let viewLine = UIView(frame: .zero)
        
        viewLine.translatesAutoresizingMaskIntoConstraints = false
        
        viewLine.backgroundColor = UIColor.viewLine
        
        return viewLine
    }()
    

    let lbProfitability : UILabel = {
        
        let label                                           = UILabel(frame: .zero)
        
        //label.text                                        = Localization.welcomeText
        
        label.textAlignment                                 = .center
        
        label.font                                          = .lbProfitability
        
        label.textColor                                     = .lbProfitability
        
        //label.accessibilityIdentifier                     = "welcome-title-label"
        
        label.translatesAutoresizingMaskIntoConstraints     = false
        
        return label
    }()
    
    // MARK: - View Life Cycle -
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}


extension DetailInvestimentView {
    
    func setupComponents() {
        
        contentView.addSubview(lbStockIdentifier)
        contentView.addSubview(lbAmount)
        contentView.addSubview(lbPurchasePrice)
//        contentView.addSubview(lbPrice)
//        contentView.addSubview(lbPurchaseDate)
//        contentView.addSubview(lbTotalValue)
//        contentView.addSubview(lbDate)
//        contentView.addSubview(lbTotalValueText)
//        contentView.addSubview(lbTodayQuote)
//        contentView.addSubview(lbTotalValue)
//        contentView.addSubview(lbTodayQuoteText)
//        contentView.addSubview(lbTodayValueText)
//        contentView.addSubview(viewLine)
//        contentView.addSubview(lbProfitabilityTitle)
//        contentView.addSubview(lbProfitability)
        
        addSubview(contentView)
     }
     
     func setupConstraints() {
        
        //Content View
            contentView.topAnchor.constraint(equalTo: topAnchor).isActive       = true
         contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive    = true
          contentView.widthAnchor.constraint(equalTo: widthAnchor).isActive     = true
        contentView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive   = true
        
        let contentViewHeightContraint      = contentView.heightAnchor.constraint(equalTo: heightAnchor)
        
        contentViewHeightContraint.priority = .defaultLow
        
        contentViewHeightContraint.isActive = true
        
        //MARK : Contraints lbStockIdentifier
        
             lbStockIdentifier.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Margin.lbStockIdentifierTopAnchor).isActive = true
         lbStockIdentifier.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margin.leadingSuperview).isActive = true
        
        
        //MARK : Contraints lbAmount
        
             lbAmount.topAnchor.constraint(equalTo: lbStockIdentifier.bottomAnchor, constant: Margin.lbAmountTopAnchor).isActive = true
         lbAmount.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margin.leadingSuperview).isActive = true
        
        //MARK : Contraints lbPurchasePrice
        
             lbPurchasePrice.topAnchor.constraint(equalTo: lbAmount.topAnchor).isActive = true
         lbPurchasePrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Margin.trailingSuperview).isActive = true
    }
     
     func setupExtraConfigurations() {
         
     }
}
