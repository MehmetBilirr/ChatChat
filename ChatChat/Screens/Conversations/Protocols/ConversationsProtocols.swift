//
//  ConversationsProtocols.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 21.11.2022.
//

import Foundation
import UIKit


protocol ViewToPresenterConversationsProcotol {
    var interactor:PresenterToInteractorConversationsProtocol?{get set}
    func didTapComposeButton()
    func didGetUser(user:User)
}

protocol PresenterToInteractorConversationsProtocol {
    var navigationController:UINavigationController?{get set}
    func didTapComposeButton()
    func didGetUser(user:User)
}


protocol PresenterToRouterConversationsProcol {
    static func createModule(ref:ConversationsViewController,navigationController:UINavigationController)
}
