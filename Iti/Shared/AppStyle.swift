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
}

extension UIFont {
   
    static let lbStockIdentifier    = UIFont.systemFont(ofSize: 20, weight: .semibold)
    
    static let lbTitle              = UIFont.systemFont(ofSize: 15, weight: .semibold)
    
}

enum Margin {
    
    static let leadingSuperview: CGFloat    = 20
    
    static let  trailingSuperview: CGFloat   = 20
}
