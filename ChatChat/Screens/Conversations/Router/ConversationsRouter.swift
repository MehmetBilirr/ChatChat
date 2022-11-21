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
        
        ref.presenter = ConversationsPresenter()
        ref.presenter?.interactor = ConversationsInteractor()
        ref.presenter?.interactor?.navigationController = navigationController
    }
    
}
