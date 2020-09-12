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
    let btnEdit                      = GradientButton(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
    
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
        contentView.addSubview(lbQuantityDescription)
        contentView.addSubview(lbPrice)
        contentView.addSubview(lbPurchaseDate)
        contentView.addSubview(lbTotalValue)
        contentView.addSubview(lbDate)
        contentView.addSubview(lbTotalValueText)
        contentView.addSubview(viewLine)
        contentView.addSubview(lbTodayQuote)
        contentView.addSubview(lbTodayValue)
        contentView.addSubview(lbTodayQuoteText)
        contentView.addSubview(lbTodayValueText)
        contentView.addSubview(lbProfitabilityTitle)
        contentView.addSubview(lbProfitability)
        contentView.addSubview(btnEdit)
        
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
        
        //MARK: Contraints lbStockIdentifier
        
             lbStockIdentifier.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Margin.lbStockIdentifierTopAnchor).isActive = true
         lbStockIdentifier.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margin.leadingSuperview).isActive = true
        
        
        //MARK: Contraints lbAmount
        
             lbAmount.topAnchor.constraint(equalTo: lbStockIdentifier.bottomAnchor, constant: Margin.lbAmountTopAnchor).isActive = true
         lbAmount.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margin.leadingSuperview).isActive = true
        
        //MARK: Contraints lbPurchasePrice
        
             lbPurchasePrice.topAnchor.constraint(equalTo: lbAmount.topAnchor).isActive = true
        lbPurchasePrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Margin.trailingSuperview).isActive = true
        
        //MARK: Contraints lbQuantityDescription
        
             lbQuantityDescription.topAnchor.constraint(equalTo: lbAmount.bottomAnchor, constant: Margin.topLbTitle).isActive = true
         lbQuantityDescription.leadingAnchor.constraint(equalTo: lbAmount.leadingAnchor).isActive = true
        
        //MARK: Contraints lbPrice
        
             lbPrice.topAnchor.constraint(equalTo: lbPurchasePrice.topAnchor, constant: Margin.topLbTitle).isActive = true
        lbPrice.trailingAnchor.constraint(equalTo: lbPurchasePrice.trailingAnchor).isActive = true
        
        //MARK: Contraints lbPurchaseDate
        
             lbPurchaseDate.topAnchor.constraint(equalTo: lbQuantityDescription.bottomAnchor, constant: (Margin.topLbTitle + 15)).isActive = true
         lbPurchaseDate.leadingAnchor.constraint(equalTo: lbAmount.leadingAnchor).isActive = true
        
        //MARK: Contraints lbTotalValue
        
             lbTotalValue.topAnchor.constraint(equalTo: lbPurchaseDate.topAnchor).isActive = true
        lbTotalValue.trailingAnchor.constraint(equalTo: lbPurchasePrice.trailingAnchor).isActive = true
        
        //MARK: Contraints lbDate
        
             lbDate.topAnchor.constraint(equalTo: lbPurchaseDate.bottomAnchor, constant: Margin.topLbTitle).isActive = true
         lbDate.leadingAnchor.constraint(equalTo: lbPurchaseDate.leadingAnchor).isActive = true
        
        //MARK: Contraints lbTotalValue
        
             lbTotalValueText.topAnchor.constraint(equalTo: lbTotalValue.bottomAnchor, constant: Margin.topLbTitle).isActive = true
        lbTotalValueText.trailingAnchor.constraint(equalTo: lbTotalValue.trailingAnchor).isActive = true
        
        //MARK: Contraints viewLine
        
             viewLine.topAnchor.constraint(equalTo: lbDate.bottomAnchor, constant: (Margin.topLbTitle + 20)).isActive = true
          viewLine.heightAnchor.constraint(equalToConstant: Size.viewLineHeight).isActive = true
         viewLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant : Margin.leadingSuperview).isActive = true
        viewLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant : Margin.trailingSuperview).isActive = true
        
        //MARK: Contraints lbTodayQuote

             lbTodayQuote.topAnchor.constraint(equalTo: viewLine.bottomAnchor, constant: (Margin.topLbTitle + 20)).isActive = true
             lbTodayQuote.leadingAnchor.constraint(equalTo: lbPurchaseDate.leadingAnchor).isActive = true

        //MARK: Contraints lbTodayValue

             lbTodayValue.topAnchor.constraint(equalTo: lbTodayQuote.topAnchor).isActive = true
             lbTodayValue.trailingAnchor.constraint(equalTo: lbTotalValue.trailingAnchor).isActive = true
        
        //MARK: Contraints lbTodayQuoteText

             lbTodayQuoteText.topAnchor.constraint(equalTo: lbTodayQuote.bottomAnchor, constant: (Margin.topLbTitle + 5)).isActive = true
             lbTodayQuoteText.leadingAnchor.constraint(equalTo: lbTodayQuote.leadingAnchor).isActive = true

        //MARK: Contraints lbTodayValueText

             lbTodayValueText.topAnchor.constraint(equalTo: lbTodayValue.topAnchor, constant: (Margin.topLbTitle + 5)).isActive = true
             lbTodayValueText.trailingAnchor.constraint(equalTo: lbTodayValue.trailingAnchor).isActive = true
        
        //MARK: Contraints lbProfitabilityTitle

             lbProfitabilityTitle.topAnchor.constraint(equalTo: lbTodayQuote.bottomAnchor, constant: (Margin.topLbTitle + 56)).isActive = true
             lbProfitabilityTitle.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        //MARK: Contraints lbProfitability

             lbProfitability.topAnchor.constraint(equalTo: lbProfitabilityTitle.bottomAnchor).isActive = true
             lbProfitability.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Margin.leadingSuperview).isActive = true
             lbProfitability.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: Margin.trailingSuperview).isActive = true
             lbProfitability.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        //MARK: Contraints BtnEdit

         btnEdit.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Margin.leadingSuperview).isActive = true
         btnEdit.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: Margin.trailingSuperview).isActive = true
         btnEdit.heightAnchor.constraint(equalToConstant: Size.btnEditHeight).isActive = true
         btnEdit.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: Margin.btnEditBottom).isActive = true
    }
     
     func setupExtraConfigurations() {
         
     }
}
