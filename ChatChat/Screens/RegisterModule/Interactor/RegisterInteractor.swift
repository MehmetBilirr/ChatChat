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
        
        AuthManager.shared.firebsaseSignUp(email: email, password: password) { bool in
            if bool {
                ProgressHUD.showSuccess()
            }
        }
    }
    
    
}
