//
//  RegisterRouter.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 19.11.2022.
//

import Foundation
import UIKit

class RegisterRouter:PresenterToRouterRegisterProtocol{
    static func createModule(ref: RegisterViewController, navigationController: UINavigationController) {
        ref.registerPresenter =  RegisterPresenter()
        ref.registerPresenter?.registerInteractor = RegisterInteractor()
        ref.registerPresenter?.registerInteractor?.navigationController = navigationController
    }
    
    
    
}
