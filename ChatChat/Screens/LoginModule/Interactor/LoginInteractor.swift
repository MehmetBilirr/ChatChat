//
//  LoginInteractor.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 18.11.2022.
//

import Foundation
import UIKit
import FBSDKLoginKit
import ProgressHUD
import FirebaseAuth

class LoginInteractor:PresenterToInteractorLoginProtocol {
    var navigationController: UINavigationController?
    
    private func presentMainVC() {
        let vc = MainTabBarController()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.present(vc, animated: true)
    }
    
    func login(email: String, password: String) {
        ProgressHUD.show()
        AuthManager.shared.firebaseSignIn(email: email, password: password) { [weak self] bool in
            if bool {
                self?.presentMainVC()
                ProgressHUD.dismiss()
            }
        }
        
        
    }
    
    func loginWithFB(token: String) {
        AuthManager.shared.firebaseSignInWithFB(token: token)
        Profile.loadCurrentProfile { profile, error in
            guard error == nil else {return}
            guard let firstName = profile?.firstName,let lastName = profile?.lastName,let imageUrl = profile?.imageURL(forMode: .square, size: CGSize(width: 200, height: 200))?.absoluteString else {return}
            DataBaseManager.shared.createDataFirestore(with: imageUrl, firstName: firstName, lastName: lastName)
            self.presentMainVC()
            
        }
        
    }
    
    func loginWithGoogle(viewController: UIViewController) {
        
        AuthManager.shared.firebaseSignInWithGoogle(viewController: viewController) {  bool in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if bool {
                    DataBaseManager.shared.checkIfUserLogin { bool in
                        if !bool {
                            let user = Auth.auth().currentUser
                            guard let user = user else {return}
                            guard let imageUrl = user.photoURL?.absoluteString, let name = user.displayName else {return}
                            let array = name.components(separatedBy: " ")

                            
                            DataBaseManager.shared.createDataFirestore(with: imageUrl, firstName: array[0], lastName: array[1])
                        }
                    }
                    
                    self.presentMainVC()
                    
                    
                }
                
            }
            
        }
    }
    
    func register() {
        
        navigationController?.pushViewController(RegisterViewController(), animated: true)
        
    }
    
    
}
