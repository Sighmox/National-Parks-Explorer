//
//  ErrorAlertController.swift
//  National Parks Explorer
//
//  Created by Paul Baker on 4/9/19.
//  Copyright © 2019 Paul Baker. All rights reserved.
//

import UIKit

class ErrorAlertController {
    
    // Creates an alert controller with some default options, and one OK button
    // for a basic alert/error dialog.
    
    static func alert(title: String = "Error", message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        return alert
    }
}
