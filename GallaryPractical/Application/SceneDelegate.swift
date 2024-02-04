//
//  SceneDelegate.swift
//  Gallery
//
//  Created by Ravi on 03/02/24.
//

import UIKit
import GoogleSignIn

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        checkPreviousLogin()
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    private func checkPreviousLogin() {
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn() { GIDGoogleUser , error in
                if let error = error {
                    print("Error : \(error)")
                }
                
                if GIDGoogleUser != nil {
                    self.showMainScreen()
                }
            }
        }
    }
    
    private func showMainScreen() {
        if let mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GallaryViewController") as? GallaryViewController,
           let rootViewController = window?.rootViewController {

            (rootViewController as? UINavigationController)?.pushViewController(mainViewController, animated: true)
        }
    }

}

