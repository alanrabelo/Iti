//
//  ViewController.swift
//  Iti
//
//  Created by Alan Rabelo Martins on 05/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
        let logo = UIImage(named: "logoiti")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    @IBAction func saibaTudo(_ sender: Any) {
        if let url = URL(string: "https://iti.itau") {
            UIApplication.shared.open(url)
        }
    }
}

