//
//  LoginViewModel.swift
//  Gallery
//
//  Created by Ravi on 03/02/24.
//

import Foundation
import Firebase
import FirebaseAuth
import GoogleSignIn

class AuthViewModel {
    
    var onSuccess: ((User) -> Void)?
    var onFailure: ((Error) -> Void)?
    
    private func signIn(credential : AuthCredential) {
        Auth.auth().signIn(with: credential) { [weak self] (result, error) in
            if let error = error {
                self?.onFailure?(error)
                return
            }
            
            if let user = result?.user {
                let currentUser = User(uid: user.uid, displayName: user.displayName ?? "", email: user.email ?? "")
                self?.onSuccess?(currentUser)
            }
        }
    }
    
    func SignInWithGoogle( viewController : UIViewController )  {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { result, error in
            if let error = error  {
                print("Unable to get result")
                self.onFailure?(error)
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                print("Invalid result")
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,accessToken: user.accessToken.tokenString)
            self.signIn(credential: credential)
        }
    }
}
