//
//  LoginViewController.swift
//  Gallery
//
//  Created by Ravi on 03/02/24.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController {
    
    @IBOutlet weak var logWithGoogleButton: UIButton!
    
    private var loginViewModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        logWithGoogleButton.layer.borderWidth = 1
        logWithGoogleButton.layer.borderColor = UIColor.label.cgColor
        
        logWithGoogleButton.layer.cornerRadius = logWithGoogleButton.bounds.height / 2
        HandleResponse()
    }
    
    @IBAction func LoginWithGoogleButtonPressed(_ sender: UIButton) {
        self.startLoading()
        loginViewModel.SignInWithGoogle(viewController: self)
    }
    
    private func HandleResponse()  {
        loginViewModel.onSuccess = {  user in
            self.stopLoading()
            self.LoginSuccess()
        }

        loginViewModel.onFailure = { error in
            self.stopLoading()
            self.showAlert(title: "Error", message: "Login failed: \(error.localizedDescription)")
        }
    }

    private func LoginSuccess() {
        let vc = storyboard?.instantiateViewController(identifier: "GallaryViewController") as! GallaryViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
