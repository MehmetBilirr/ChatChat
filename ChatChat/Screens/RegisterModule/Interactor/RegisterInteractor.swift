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
        ProgressHUD.show()
        AuthManager.shared.firebaseSignUp(email: email, password: password) { [weak self] bool in
            
            if bool {
                DataBaseManager.shared.setupProfile(imageView: profileImageView, firstName: firstName, lastName: lastName, email: email) { [weak self] bool in
                    if bool {
                        let vc = MainTabBarController()
                        vc.modalPresentationStyle = .fullScreen
                        self?.navigationController?.present(vc, animated: true)
                        ProgressHUD.dismiss()
                    }
                }
            }
        }
    }
    
    
}
