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
        
        ref.profilePresenter = ProfilePresenter()
        ref.profilePresenter?.profileInteractor = ProfileInteractor()
        ref.profilePresenter?.profileInteractor?.navigationController = navigationController
    }
    
    
}
