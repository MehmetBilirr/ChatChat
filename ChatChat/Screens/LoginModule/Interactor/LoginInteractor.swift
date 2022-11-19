//
//  LoginInteractor.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 18.11.2022.
//

import Foundation
import UIKit

class LoginInteractor:PresenterToInteractorLoginProtocol {
     var navigationController: UINavigationController?
    
    func login(email: String, password: String) {
            AuthManager.shared.firebaseSignIn(email: email, password: password) { [weak self] bool in
                if bool {
                    self?.navigationController?.pushViewController(RegisterViewController(), animated: true)
                }
            }
            
        
    }
    func register() {
        
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    
}
