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
            AuthManager.shared.firebaseSignIn(email: email, password: password) { [weak self] bool in
                if bool {
                    let vc = MainTabBarController()
                    vc.modalPresentationStyle = .fullScreen
                    self?.navigationController?.present(vc, animated: true)
                }
            }
            
        
    }
    
    func loginWithFB(token: String) {
        AuthManager.shared.firebaseSignInWithFB(token: token)
        let personImage = UIImageView(image: UIImage(named: "person"))
        Profile.loadCurrentProfile { profile, error in
            guard let firstName = profile?.firstName,let lastName = profile?.lastName else {return}
            ProgressHUD.show()
            DataBaseManager.shared.setupProfile(imageView: personImage, firstName: firstName, lastName: lastName) { [weak self] bool in
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
