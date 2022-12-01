//
//  ProfileRouter.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 19.11.2022.
//

import Foundation
import UIKit

class ProfileRouter:PresenterToRouterProfileProtocol {
    
    static func createModule(ref: ProfileViewController, navigationController: UINavigationController) {
        
        ref.presenter = ProfilePresenter()
        ref.presenter?.interactor = ProfileInteractor()
        ref.presenter?.view = ref
        ref.presenter?.interactor?.navigationController = navigationController
    }
    
    
}
