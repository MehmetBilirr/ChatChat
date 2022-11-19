//
//  RegisterPresenter.swift.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 19.11.2022.
//

import Foundation
import UIKit


class RegisterPresenter:ViewToPresenterRegisterProtocol {
    var registerInteractor: PresenterToInteractorRegisterProtocol?
    
    func register(profileImageView: UIImageView, firstName: String, lastName: String, email: String, password: String) {
        registerInteractor?.register(profileImageView: profileImageView, firstName: firstName, lastName: lastName, email: email, password: password)
    }
    
    
    
}
