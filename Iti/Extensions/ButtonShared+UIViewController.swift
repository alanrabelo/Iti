//
//  SharedButton.swift
//  Iti
//
//  Created by Cleber Reis on 23/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import UIKit

extension UIViewController {
    public func sharedButton() {
        let text = "Mensagem de compartilhamento"
        guard let imagem = UIImage(named: "img01") else {return}
        guard let myWebsite = URL(string:"https://iti.itau") else {return}
        
        let shared = [text, imagem, myWebsite] as [Any]
        let viewController = UIActivityViewController(activityItems: shared, applicationActivities: nil)
        viewController.popoverPresentationController?.sourceView = self.view
        present(viewController, animated: true, completion: nil)
    }
}
