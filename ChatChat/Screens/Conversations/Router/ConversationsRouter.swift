//
//  ConversationsRouter.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 21.11.2022.
//

import Foundation
import UIKit


class ConversationsRouter:PresenterToRouterConversationsProcol {

    static func createModule(ref:ConversationsViewController,navigationController:UINavigationController){
        let presenter = ConversationsPresenter()
        let interactor = ConversationsInteractor()
        ref.presenter = presenter
        ref.presenter?.view = ref
        ref.presenter?.interactor = interactor
        ref.presenter?.interactor?.presenter = presenter
        ref.presenter?.interactor?.navigationController = navigationController
    }
    
}
