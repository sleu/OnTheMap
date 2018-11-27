//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Sean Leu on 11/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var loginView: LoginView {return self.view as! LoginView}
    var emailField: UITextField {return loginView.emailField}
    var passwordField: UITextField {return loginView.passwordField}
    var loginButton: UIButton {return loginView.loginButton}
    var signupView: UIView {return loginView.signupView}
    var keyboardOnScreen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = LoginView()
        emailField.delegate = self
        passwordField.delegate = self
        loginButton.addTarget(self, action: #selector(LoginViewController.loginPressed), for: .touchDown)
        subscribeToNotification(UIResponder.keyboardWillShowNotification, selector: #selector(keyboardWillShow))
        subscribeToNotification(UIResponder.keyboardWillHideNotification, selector: #selector(keyboardWillHide))
        subscribeToNotification(UIResponder.keyboardDidShowNotification, selector: #selector(keyboardDidShow))
        subscribeToNotification(UIResponder.keyboardDidHideNotification, selector: #selector(keyboardDidHide))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromAllNotifications()
    }

    @objc func loginPressed() {
        guard !emailField.text!.isEmpty && !passwordField.text!.isEmpty else {
            self.displayNotification("Email or Password is missing")
            return
        }
        UdacClient.sharedInstance.authenticateUser(emailField.text!, passwordField.text!) { (success, errorMessage) in
            if success {
                DispatchQueue.main.async {
                    self.clearText()
                    self.switchToMain()}
            } else {
                DispatchQueue.main.async {
                    self.displayNotification("Incorrect Login")}
            }
        }
    }
    func displayNotification(_ error: String){
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    func switchToMain() {
        let newVC = MainViewController()
        var navController: UINavigationController?
        navController = UINavigationController(rootViewController: newVC)
        self.present(navController!, animated: true, completion: nil)
    }
    func clearText() {
        emailField.text = ""
        passwordField.text = ""
    }
}
extension LoginViewController: UITextFieldDelegate {
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Show/Hide Keyboard
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if !keyboardOnScreen {
            view.frame.origin.y = -signupView.frame.origin.y+50
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if keyboardOnScreen {
            view.frame.origin.y = 0
        }
    }
    
    @objc func keyboardDidShow(_ notification: Notification) {
        keyboardOnScreen = true
    }
    
    @objc func keyboardDidHide(_ notification: Notification) {
        keyboardOnScreen = false
    }
    
    func keyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = (notification as NSNotification).userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func resignIfFirstResponder(_ textField: UITextField) {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
    }
}

private extension LoginViewController {
    
    func subscribeToNotification(_ notification: NSNotification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }
    
    func unsubscribeFromAllNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
}
