//
//  RegisterInteractor.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 19.11.2022.
//

import Foundation
import UIKit
import ProgressHUD

class RegisterInteractor:PresenterToInteractorRegisterProtocol {
    var navigationController: UINavigationController?
    
    func register(profileImageView: UIImageView, firstName: String, lastName: String, email: String, password: String) {
        
        AuthManager.shared.firebaseSignUp(email: email, password: password) { [weak self] bool in
            if bool {
                DataBaseManager.shared.setupProfile(imageView: profileImageView, firstName: firstName, lastName: lastName) { [weak self] bool in
                    if bool {
                        let navLoginVc = UINavigationController(rootViewController: LoginViewController())
                        navLoginVc.modalPresentationStyle = .fullScreen
                        self?.navigationController?.present(navLoginVc, animated: true)
                    }
                }
            }
        }
    }
    
    
}
