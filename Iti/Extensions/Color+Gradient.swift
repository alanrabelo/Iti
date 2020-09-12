//
//  Color+Gradient.swift
//  Iti
//
//  Created by Italus Rodrigues do Prado on 05/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func gradientColorFor(view: UIView, firstColor: UIColor, secondColor: UIColor, endPoint: CGPoint = CGPoint(x: 1.0, y: 0.0)) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = endPoint
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = view.bounds
        
        return gradientLayer
    }
}
