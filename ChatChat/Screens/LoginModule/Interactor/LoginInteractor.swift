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
        if email == "" && password == "" {
            navigationController?.pushViewController(RegisterViewController(), animated: true)
        }
    }
    func register() {
        
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    
}
