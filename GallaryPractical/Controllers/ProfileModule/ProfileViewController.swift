//
//  ProfileViewController.swift
//  Gallery
//
//  Created by Ravi on 03/02/24.
//

import Foundation
import UIKit
import GoogleSignIn

class ProfileViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Profile"
        img.layer.cornerRadius = img.bounds.height / 2
        
        setupProfile()
    }
    
    func setupProfile() {
        guard let user = GIDSignIn.sharedInstance.currentUser else {
            print("Unable to get user profile")
            return
        }

        if let imageURL = user.profile?.imageURL(withDimension: 500) {
            img.setImage(urlString: imageURL.absoluteString)
        }

        lblUserName.text = user.profile?.name ?? ""
        lblEmail.text = user.profile?.email ?? ""
    }

    
    @IBAction func logutButtonTapped(_ sender: UIButton) {
        self.showAlertAndLogout()
    }
  
    private func showAlertAndLogout() {
        let alert = UIAlertController(title: "Are you sure want to logout?", message: "", preferredStyle: .alert)
        let noAction = UIAlertAction(title: "No", style: .default, handler: nil)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive, handler: {_ in
            GIDSignIn.sharedInstance.signOut()
            self.navigationController?.popToRootViewController(animated: true)
        })
        alert.addAction(noAction)
        alert.addAction(yesAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
