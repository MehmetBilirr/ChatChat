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
        let presenter = ProfilePresenter()
        let interactor = ProfileInteractor()
        ref.presenter = presenter
        ref.presenter?.interactor = interactor
        ref.presenter?.view = ref
        ref.presenter?.interactor?.presenter = presenter
        ref.presenter?.interactor?.navigationController = navigationController
    }
    
    
}
