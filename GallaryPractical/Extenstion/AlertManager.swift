//
//  AlertManager.swift
//  Gallery
//
//  Created by Ravi on 03/02/24.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
}
