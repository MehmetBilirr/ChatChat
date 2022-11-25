//
//  ChatRouter.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 25.11.2022.
//

import Foundation
import UIKit


class ChatRouter:PresenterToRouterChatPRocotol {
    static func createModule(ref: ChatViewController, navigationController: UINavigationController) {
        
        let presenter = ChatPresenter()
        let interactor = ChatInteractor()
        ref.presenter = presenter
        ref.presenter?.view = ref
        ref.presenter?.interactor = interactor
        ref.presenter?.interactor?.presenter = presenter
        ref.presenter?.interactor?.navigationController = navigationController
    }
    
    
}
