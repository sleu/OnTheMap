//
//  PostingView.swift
//  OnTheMap
//
//  Created by Sean Leu on 12/3/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation
import UIKit

class PostingView: UIView {
    
    let worldLogo = UIImageView()
    let locationTextField = UITextField()
    let urlTextField = UITextField()
    let findLocationButton = UIButton()
    let stackView = UIStackView()
    let screenSize = UIScreen.main.bounds
    let title = "Add Location"
    
    private enum Text: String{
        case location = "Enter your location"
        case website = "Enter your link"
        case find = "FIND LOCATION"
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        worldLogoProperties()
        locationProperties()
        urlProperties()
        findLocationButtonProperties()
        stackViewProperties()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func worldLogoProperties() {
        worldLogo.image = UIImage(named: "icon_world.png")
        worldLogo.frame = CGRect(x: 0, y: 0, width: 10, height: 20)
    }
    
    func locationProperties() {
        locationTextField.placeholder = Text.location.rawValue
        locationTextField.borderStyle = .roundedRect
        locationTextField.textAlignment = .center
        locationTextField.widthAnchor.constraint(equalToConstant: 250).isActive = true
    }
    func urlProperties() {
        urlTextField.placeholder = Text.website.rawValue
        urlTextField.borderStyle = .roundedRect
        urlTextField.textAlignment = .center
        urlTextField.widthAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    func findLocationButtonProperties() {
        findLocationButton.setTitle(Text.find.rawValue, for: UIControl.State.normal)
        findLocationButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        findLocationButton.backgroundColor = UIColor.blue
        findLocationButton.layer.cornerRadius = 5.0
        findLocationButton.clipsToBounds = true
        findLocationButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
    }
    func stackViewProperties() {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        stackView.addArrangedSubview(worldLogo)
        stackView.addArrangedSubview(locationTextField)
        stackView.addArrangedSubview(urlTextField)
        stackView.addArrangedSubview(findLocationButton)
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 6.0
        stackView.setCustomSpacing(20, after: worldLogo)
        stackView.centerXAnchor.constraint(equalTo: (self.centerXAnchor)).isActive = true
        stackView.centerYAnchor.constraint(equalTo: (self.centerYAnchor)).isActive = true
    }
    
    func cancelButton() -> UIBarButtonItem {
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
        return cancel
    }
}
