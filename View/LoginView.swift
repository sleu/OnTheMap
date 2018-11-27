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
    
    let udacLogo = UIImageView()
    let emailField = UITextField()
    let passwordField = UITextField()
    let loginButton = UIButton()
    let signupView = UITextView()
    let stackView = UIStackView()
    let screenSize = UIScreen.main.bounds
    
    private enum Text: String{
        case email, password
        case login = "LOG IN"}
    
    override init(frame: CGRect){
        super.init(frame: frame)
        udacLogoProperties()
        emailProperties()
        passwordProperties()
        loginButtonProperties()
        signUpView()
        stackViewProperties()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func udacLogoProperties() {
        udacLogo.image = UIImage(named: "logo-u.png")
        udacLogo.frame = CGRect(x: 0, y: 0, width: 10, height: 20)
    }
    
    func emailProperties() {
        emailField.placeholder = Text.email.rawValue.capitalized
        emailField.borderStyle = .roundedRect
        emailField.textAlignment = .center
        emailField.keyboardType = .emailAddress
        emailField.widthAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    func passwordProperties() {
        passwordField.placeholder = Text.password.rawValue.capitalized
        passwordField.borderStyle = .roundedRect
        passwordField.textAlignment = .center
        passwordField.isSecureTextEntry = true
        passwordField.widthAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    func loginButtonProperties() {
        loginButton.setTitle(Text.login.rawValue, for: UIControl.State.normal)
        loginButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        loginButton.backgroundColor = UIColor.blue
        loginButton.layer.cornerRadius = 5.0
        loginButton.clipsToBounds = true
        loginButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    func signUpView() {
        signupView.isEditable = false
        signupView.isScrollEnabled = false
        let attributedString = NSMutableAttributedString(string: "Don't have an account? Sign Up!")
        attributedString.addAttribute(.link, value: "https://www.udacity.com", range: NSRange(location: 22, length:9))
        signupView.attributedText = attributedString
    }
    
    func stackViewProperties() {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        stackView.addArrangedSubview(udacLogo)
        stackView.addArrangedSubview(emailField)
        stackView.addArrangedSubview(passwordField)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(signupView)
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 6.0
        stackView.setCustomSpacing(50, after: udacLogo)
        stackView.centerXAnchor.constraint(equalTo: (self.centerXAnchor)).isActive = true
        stackView.centerYAnchor.constraint(equalTo: (self.centerYAnchor)).isActive = true
    }
}
