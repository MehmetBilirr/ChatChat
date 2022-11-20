//
//  LoginPresenter.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 18.11.2022.
//

import Foundation
import UIKit


class LoginPresenter:ViewToPresenterLoginProtocol {
     var loginInteractor: PresenterToInteractorLoginProtocol?
    
    func login(email: String, password: String) {
        loginInteractor?.login(email: email, password: password)
    }
    func register() {
        loginInteractor?.register()
    }
    
    func loginWithFB(token: String) {
        loginInteractor?.loginWithFB(token: token)
    }
    
    func loginWithGoogle(viewController: UIViewController) {
        loginInteractor?.loginWithGoogle(viewController: viewController)
    }
}
