//
//  LoginView.swift
//  Iti
//
//  Created by Italus Rodrigues on 23/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import UIKit

class LoginView: UIView, CodeView {
    
    let topImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "backImage")
        imageView.contentMode = .top
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let whiteView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white

        return view
    }()
    
    let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bem-Vindo"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "E-mail"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Senha"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let loginButton: GradientButton = {
        let button = GradientButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("entrar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        return button
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("criar cadastro", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        return button
    }()
    
    init(textFieldDelegate: UITextFieldDelegate) {
        super.init(frame: .zero)
        self.emailTextField.delegate = textFieldDelegate
        self.passwordTextField.delegate = textFieldDelegate
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupComponents() {
        addSubview(topImageView)
        addSubview(whiteView)
        
        whiteView.addSubview(label)
        whiteView.addSubview(emailTextField)
        whiteView.addSubview(passwordTextField)
        whiteView.addSubview(loginButton)
        whiteView.addSubview(signUpButton)
    }
    
    func setupConstraints() {
        //TopView
        topImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topImageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        topImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        topImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        
        //WhiteView
        whiteView.topAnchor.constraint(equalTo: topImageView.bottomAnchor).isActive = true
        whiteView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        whiteView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        whiteView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        //Label
        label.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 20).isActive = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        //EmailTextField
        emailTextField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: widthAnchor, constant: -40).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //PasswordTextField
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: emailTextField.widthAnchor).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: emailTextField.centerXAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor).isActive = true
        
        //LoginButton
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
        loginButton.widthAnchor.constraint(equalTo: emailTextField.widthAnchor).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: emailTextField.centerXAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalTo: emailTextField.heightAnchor).isActive = true
        
        //SignUpButton
        signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20).isActive = true
        signUpButton.widthAnchor.constraint(equalTo: emailTextField.widthAnchor).isActive = true
        signUpButton.centerXAnchor.constraint(equalTo: emailTextField.centerXAnchor).isActive = true
        signUpButton.heightAnchor.constraint(equalTo: emailTextField.heightAnchor).isActive = true
    }
    
    func setupExtraConfigurations() {
        
    }
    
    func reloadSublayers() {
        let gradientColor = UIColor.gradientColorFor(view: loginButton, firstColor: UIColor(named: "MainOrange")!, secondColor: UIColor(named: "MainPink")!)
        print(loginButton.frame.width)
        loginButton.layer.insertSublayer(gradientColor, at: 0)
        
        topImageView.image = topImageView.image!.resizeTopAlignedToFill(newWidth: topImageView.frame.width)
    }

}

extension UIImage {
    func resizeTopAlignedToFill(newWidth: CGFloat) -> UIImage? {
        let newHeight = size.height * newWidth / size.width

        let newSize = CGSize(width: newWidth, height: newHeight)

        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}
