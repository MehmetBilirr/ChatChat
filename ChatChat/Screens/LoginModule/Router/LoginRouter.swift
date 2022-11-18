//
//  LoginRouter.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 19.11.2022.
//

import Foundation
import UIKit


class LoginRouter:PresenterToRouterLoginProtocol {
    static func createModule(ref: LoginViewController, navigationController: UINavigationController) {
        
        ref.loginPresenter = LoginPresenter()
        ref.loginPresenter?.loginInteractor = LoginInteractor()
        ref.loginPresenter?.loginInteractor?.navigationController = navigationController
        
    }
    



}
