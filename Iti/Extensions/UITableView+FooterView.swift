//
//  UITableView+FooterView.swift
//  Iti
//
//  Created by Italus Rodrigues do Prado on 05/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import UIKit

extension UITableView {
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.tableFooterView = UIView()
    }
}
