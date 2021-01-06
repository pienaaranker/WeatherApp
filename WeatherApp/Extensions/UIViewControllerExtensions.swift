//
//  UIViewControllerExtensions.swift
//  WeatherApp
//
//  Created by Pienaar Anker on 2021/01/06.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, handler:((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: GlobalStrings.Alert.okButton, style: .default, handler: handler))
        self.present(alert, animated: true, completion: nil)
    }
}
