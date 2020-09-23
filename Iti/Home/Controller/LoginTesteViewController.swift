//
//  LoginTesteViewController.swift
//  Iti
//
//  Created by Matheus Ramos on 23/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import UIKit

class LoginTesteViewController: UIViewController {
    
    var firebaseAuth = FirebaseAuth()
    var auth: Auth?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        auth = Auth(email: "matheusteste1@gmail.com", password: "123456")
    }
    
    @IBAction func register(_ sender: Any) {
        
        firebaseAuth.register(authentication: auth)
        
    }
    
    
    
    @IBAction func login(_ sender: Any) {
        
        firebaseAuth.signIn(authentication: auth)
        
    }
    
    
    
    @IBAction func logout(_ sender: Any) {
        
        firebaseAuth.signOut()
        
    }
    
}
