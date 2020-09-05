//
//  UIView+GradientSublayer.swift
//  Iti
//
//  Created by Italus Rodrigues do Prado on 05/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import UIKit

extension UIView {
    
    func addGradientSublayer(firstColor: UIColor, secondColor: UIColor, endPoint: CGPoint = CGPoint(x: 1.0, y: 0.0)) {
        let gradientColorTopView = UIColor.gradientColorFor(view: self, firstColor: firstColor, secondColor: secondColor, endPoint: endPoint)
        self.layer.insertSublayer(gradientColorTopView, at: 0)
    }
}
