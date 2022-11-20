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
            guard let firstName = profile?.firstName,let lastName = profile?.lastName,let imageUrl = profile?.imageURL(forMode: .square, size: CGSize(width: 200, height: 200))?.absoluteString else {return}
            ProgressHUD.show()
            DataBaseManager.shared.createDataFirestore(with: imageUrl, firstName: firstName, lastName: lastName) { [weak self] bool in
                if bool {
                    self?.presentMainVC()
                    ProgressHUD.dismiss()
                }
            }
        }
        
    }
    
    func loginWithGoogle(viewController: UIViewController) {
        
        AuthManager.shared.firebaseSignInWithGoogle(viewController: viewController) { [weak self] bool in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if bool {
                   
                    let user = Auth.auth().currentUser
                    guard let user = user else {return}
                    let imageUrl = user.photoURL?.absoluteString, name = user.displayName
                    DataBaseManager.shared.createDataFirestore(with: imageUrl!, firstName: name!, lastName: name!) {[weak self] bool in
                            if bool {
                                let vc = MainTabBarController()
                                vc.modalPresentationStyle = .fullScreen
                                self?.navigationController?.present(vc, animated: true)
                            }
                        
                        
                    }
                    
            }
                
            }
            
            }
    }
    
    
    func register() {
        
        navigationController?.pushViewController(RegisterViewController(), animated: true)
        
    }
    
    
}
