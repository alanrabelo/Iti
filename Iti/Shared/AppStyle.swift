//
//  AppStyle.swift
//  Iti
//
//  Created by Marcos Lacerda on 12/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import UIKit

extension UIColor {
        
    static let lbStockIdentifier    = UIColor.black
    
    static let lbTitle              = UIColor.systemGray
    
    static let lbInfos              = UIColor.black
    
    static let viewLine             = UIColor.systemGray4
    
    static let lbTodayValues        = UIColor(named: "ProfitabilityColor")
    
    static let lbProfitability      = UIColor(named: "ProfitabilityColor")


}

extension UIFont {
   
    static let lbStockIdentifier    = UIFont.systemFont(ofSize: 20, weight: .semibold)
    
    static let lbTitle              = UIFont.systemFont(ofSize: 15, weight: .semibold)
    
    static let lbInfos              = UIFont.systemFont(ofSize: 17)
    
    static let lbTodayValues        = UIFont.systemFont(ofSize: 22, weight: .medium)
    
    static let lbProfitability      = UIFont.boldSystemFont(ofSize: 115)
    
}

enum Margin {
    
    static let lbStockIdentifierTopAnchor : CGFloat   = 40
    
    static let lbAmountTopAnchor          : CGFloat   = 25
    
    static let topLbTitle                 : CGFloat   = 5
    
    static let leadingSuperview           : CGFloat   = 20
    
    static let trailingSuperview          : CGFloat   = -20
    
    static let btnEditBottom              : CGFloat   = 20
}

enum Size {
    
    static let viewLineHeight : CGFloat   = 1
    
    static let btnEditHeight : CGFloat    = 40
    
    static let btnEditWidth : CGFloat     = 40
}
