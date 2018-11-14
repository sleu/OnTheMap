//
//  LoginView.swift
//  OnTheMap
//
//  Created by Sean Leu on 11/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation
import UIKit

class LoginView: UIView {
    
    let emailField = UITextField()
    let passwordField = UITextField()
    let loginButton = UIButton()
    let signupLabel = UILabel()
    let stackView = UIStackView()
    let screenSize = UIScreen.main.bounds
    
    private enum Text: String{
        case email, password
        case login = "LOG IN"
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        emailProperties()
        passwordProperties()
        loginButtonProperties()
        signupLabelProperties()
        stackViewProperties()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func emailProperties() {
        emailField.placeholder = Text.email.rawValue.capitalized
        emailField.borderStyle = .roundedRect
        emailField.textAlignment = .center
        emailField.keyboardType = .emailAddress
    }
    
    func passwordProperties() {
        passwordField.placeholder = Text.password.rawValue.capitalized
        passwordField.borderStyle = .roundedRect
        passwordField.textAlignment = .center
        passwordField.isSecureTextEntry = true
    }
    
    func loginButtonProperties() {
        loginButton.setTitle(Text.login.rawValue, for: UIControl.State.normal)
        loginButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        loginButton.backgroundColor = UIColor.blue
        loginButton.layer.cornerRadius = 5.0
        loginButton.clipsToBounds = true
    }
    
    func signupLabelProperties() {
        signupLabel.text = "Don't have an account? Sign Up" //TODO sign up link
        signupLabel.textAlignment = .center
    }
    
    func stackViewProperties() {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        stackView.addArrangedSubview(emailField)
        stackView.addArrangedSubview(passwordField)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(signupLabel)
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fillEqually
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing = 5.0
        stackView.centerXAnchor.constraint(equalTo: (self.centerXAnchor)).isActive = true
        stackView.centerYAnchor.constraint(equalTo: (self.centerYAnchor)).isActive = true
    }
    
}
