//
//  LoginPresenter.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 18.11.2022.
//

import Foundation


class LoginPresenter:ViewToPresenterLoginProtocol {
    var loginInteractor: PresenterToInteractorLoginProtocol?
    
    func login(email: String, password: String) {
        loginInteractor?.login(email: email, password: password)
    }
    
    
}
