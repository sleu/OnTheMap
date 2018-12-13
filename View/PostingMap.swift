//
//  PostingMap.swift
//  OnTheMap
//
//  Created by Sean Leu on 12/6/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation
import UIKit

class PostingMap: UIView {
    let title = "Add Location"
    
    func cancelButton() -> UIBarButtonItem {
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
        return cancel
    }
    
    func finishButton() -> UIButton {
        let finishButton = UIButton()
        finishButton.setTitle("FINISH", for: UIControl.State.normal)
        finishButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        finishButton.backgroundColor = UIColor.blue
        finishButton.layer.cornerRadius = 5.0
        finishButton.clipsToBounds = true
        return finishButton
    }
}
