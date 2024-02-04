//
//  ActivityIndictorManager.swift
//  Gallery
//
//  Created by Ravi on 03/02/24.
//

import Foundation
import UIKit

@available(iOS 13.0, *)
extension UIViewController {
    private struct AssociatedKeys {
        static var activityIndicatorKey = "activityIndicatorKey"
    }
    
    private var activityIndicator: UIActivityIndicatorView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.activityIndicatorKey) as? UIActivityIndicatorView
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.activityIndicatorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func startLoading() {
        if activityIndicator == nil {
            activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator?.color = .black
            activityIndicator?.hidesWhenStopped = true
            
            if let indicator = activityIndicator {
                view.addSubview(indicator)
                
                indicator.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                ])
            }
        }
        
        activityIndicator?.startAnimating()
//         view.isUserInteractionEnabled = false
    }
    
    func stopLoading() {
        if let indicator = activityIndicator, indicator.isAnimating {
            indicator.stopAnimating()
            indicator.removeFromSuperview()
            activityIndicator = nil
        }
    }
}

