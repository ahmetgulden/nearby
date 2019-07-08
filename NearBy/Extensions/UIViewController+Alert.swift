//
//  UIViewController+Alert.swift
//  NearBy
//
//  Created by Ahmet Gülden on 9.07.2019.
//  Copyright © 2019 Ahmet Gülden. All rights reserved.
//

import UIKit

extension UIViewController {

    /// Shows an alert message with done button.
    ///
    /// - Parameter message: Message to be displayed.
    func nrb_showAlert(withMessage message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let doneButton = UIAlertAction(title: "Done", style: .default)
        alert.addAction(doneButton)
        present(alert, animated: true, completion: nil)
    }
}
