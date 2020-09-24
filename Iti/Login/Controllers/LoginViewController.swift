//
//  LoginViewController.swift
//  Iti
//
//  Created by Italus Rodrigues on 23/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var firebaseAuth = FirebaseAuth()
    var auth: ItiAuth?
    weak var coordinator: LoginCoordinator?
    lazy var loginView = LoginView(textFieldDelegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView.signUpButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchDown)
        loginView.loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchDown)
        self.view = loginView
    }
    
    @objc func didTapLoginButton() {
        print("login")
        
        guard let email = loginView.emailTextField.text, let password = loginView.passwordTextField.text else { return }
        auth = ItiAuth(email: email, password: password)
        
        firebaseAuth.signIn(authentication: auth, onSuccess: { [weak self] in
            self?.coordinator?.showHome()
        })
    }
    
    @objc func didTapSignUpButton() {
        print("signup")
        
        guard let email = loginView.emailTextField.text, let password = loginView.passwordTextField.text else { return }
        auth = ItiAuth(email: email, password: password)
        
        firebaseAuth.register(authentication: auth, onSuccess: { [weak self] in
            self?.firebaseAuth.signIn(authentication: self?.auth, onSuccess: {
                self?.coordinator?.showHome()
            })
        })
    }
    
    override func viewDidLayoutSubviews() {
        loginView.reloadSublayers()
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text,
            let textRange = Range(range, in: text) else
        { return true }
        
        let newText = text.replacingCharacters(in: textRange, with: string)
        
        if textField == loginView.emailTextField {
            print("Texto email mudou: \(newText)")
        } else {
            print("Texto senha mudou: \(newText)")
        }
        return true
    }
}
