//
//  CustomLabel.swift
//  Iti
//
//  Created by Alan Rabelo Martins on 05/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import Foundation
import UIKit

class CustomLabel: UILabel {
    var status: FormStatus = .valid {
        didSet {
            self.textColor = status == .valid ? .black : .red
        }
    }
    
    func switchStatus() {
        status = status == .valid ? .invalid : .valid
    }
}
