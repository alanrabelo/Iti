//
//  HasCodeView.swift
//  Iti
//
//  Created by Marcos Lacerda on 12/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import UIKit

protocol HasCodeView {
    
    associatedtype CustomView: UIView
}

extension HasCodeView where Self: UIViewController {
    
    var customView: CustomView {
    
        return view as! CustomView
    }
}
