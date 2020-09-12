//
//  CustomLabel.swift
//  Iti
//
//  Created by Alan Rabelo Martins on 05/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import Foundation
import UIKit

enum TextFieldType: Int {
    case title, ammount, price, date
}

class CustomTextfield: UITextField {
    
    var label: CustomLabel?
    var type: TextFieldType = .title
    
    var status: FormStatus = .valid {
        didSet {
            label?.status = status
            if status == .invalid {
                self.textColor = .red
                self.text = "Campo obrigatório"
            } else {
                self.textColor = .black
            }
        }
    }
    
    func moveToNext() {
        next?.becomeFirstResponder()
    }
    
    func switchStatus() {
        label?.switchStatus()
        status = status == .valid ? .invalid : .valid
    }
}
