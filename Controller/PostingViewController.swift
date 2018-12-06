//
//  PostingViewController.swift
//  OnTheMap
//
//  Created by Sean Leu on 12/3/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation
import UIKit

class PostingViewController: UIViewController {
    
    var postingView: PostingView {return self.view as! PostingView}
    var locationTextField: UITextField {return postingView.locationTextField}
    var urlTextField: UITextField {return postingView.urlTextField}
    var findLocationButton: UIButton {return postingView.findLocationButton}
    var keyboardOnScreen = false
    var newStudent = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = PostingView()
        locationTextField.delegate = self
        urlTextField.delegate = self
        findLocationButton.addTarget(self, action: #selector(PostingViewController.findLocation), for: .touchDown)
        subscribeToNotification(UIResponder.keyboardWillShowNotification, selector: #selector(keyboardWillShow))
        subscribeToNotification(UIResponder.keyboardWillHideNotification, selector: #selector(keyboardWillHide))
        subscribeToNotification(UIResponder.keyboardDidShowNotification, selector: #selector(keyboardDidShow))
        subscribeToNotification(UIResponder.keyboardDidHideNotification, selector: #selector(keyboardDidHide))
        loadNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromAllNotifications()
    }
    
    @objc func findLocation() {
        let location = locationTextField.text!
        let url = urlTextField.text!
        guard (!location.isEmpty) else {
            displayNotification("Location is missing")
            return
        }
        guard (!url.isEmpty) else {
            displayNotification("URL is missing")
            return
        }
        guard let validUrl = URL(string: url), UIApplication.shared.canOpenURL(validUrl) else {
            displayNotification("Invalid URL")
            return
        }
        if newStudent {
            //TODO: ParseClient.newpoststudent
        } else{
            //TODO: ParseClient updateputstudent
        }
        print("finding")
    }
    
    func loadNavigationBar() {
        let cancelButton = postingView.cancelButton()
        cancelButton.target = self
        cancelButton.action = #selector(cancel)
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.title = postingView.title
        
    }
    
    @objc func cancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func displayLocation(){
        //TODO: mapcode and finish - new screen
        self.dismiss(animated: true, completion: nil)
    }
    
    func displayNotification(_ error: String){
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}
extension PostingViewController: UITextFieldDelegate {
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Show/Hide Keyboard
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if !keyboardOnScreen {
            view.frame.origin.y = -findLocationButton.frame.origin.y+50
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
private extension PostingViewController {
    
    func subscribeToNotification(_ notification: NSNotification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }
    
    func unsubscribeFromAllNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
}
