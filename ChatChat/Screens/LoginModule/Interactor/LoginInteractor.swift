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

class LoginInteractor:PresenterToInteractorLoginProtocol {
     var navigationController: UINavigationController?
    
    func login(email: String, password: String) {
        ProgressHUD.show()
            AuthManager.shared.firebaseSignIn(email: email, password: password) { [weak self] bool in
                if bool {
                    let vc = MainTabBarController()
                    vc.modalPresentationStyle = .fullScreen
                    self?.navigationController?.present(vc, animated: true)
                    ProgressHUD.dismiss()
                }
            }
            
        
    }
    
    func loginWithFB(token: String) {
        AuthManager.shared.firebaseSignInWithFB(token: token)
        Profile.loadCurrentProfile { profile, error in
            guard let firstName = profile?.firstName,let lastName = profile?.lastName,let imageUrl = profile?.imageURL(forMode: .square, size: CGSize(width: 200, height: 200))?.absoluteString else {return}
            ProgressHUD.show()
            DataBaseManager.shared.createDataFirestoreFB(imageUrl: imageUrl, firstName: firstName, lastName: lastName) { [weak self] bool in
                if bool {
                    let vc = MainTabBarController()
                    vc.modalPresentationStyle = .fullScreen
                    self?.navigationController?.present(vc, animated: true)
                    ProgressHUD.dismiss()
                }
            }
        }
        
    }
    func register() {
        
        navigationController?.pushViewController(RegisterViewController(), animated: true)
        
    }
    
    
}
