//
//  ViewController.swift
//  Iti
//
//  Created by Alan Rabelo Martins on 05/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnEye: UIButton!
    @IBOutlet weak var labelValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor.init(hexString: "2B374A")
    }
 
    private func setupUI() {
        
        let logo = UIImage(named: "logoiti")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        navigationController?.navigationBar.shadowImage = UIImage()
        
        btnEye.setBackgroundImage(UIImage(systemName: "eye.slash"), for: .normal)
        labelValue.text = "R$ 0,00"
    }

    @IBAction func saibaTudo(_ sender: UIButton) {
        if let url = URL(string: "https://iti.itau") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func btnHideShow(_ sender: UIButton) {
        
        if sender.tag == 0 {
            btnEye.setBackgroundImage(UIImage(systemName: "eye.fill"), for: .normal)
            labelValue.text = "R$ -,--"
            sender.tag = 1
            print(sender.tag)
        } else {
            btnEye.setBackgroundImage(UIImage(systemName: "eye.slash"), for: .normal)
            labelValue.text = "R$ 0,00"
            sender.tag = 0
            print(sender.tag)
        }
        
    }
    
    
}

extension UIColor {
   convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

