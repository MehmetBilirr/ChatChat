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
    var view:PresenterToViewConversationProtocol? {get set}
    func didTapComposeButton()
    func didGetUser(user:User)
    func getConversations()
    func getConversation(indexpath:IndexPath) -> Conversation
    func getConversationCount() -> Int
}

protocol PresenterToInteractorConversationsProtocol {
    var presenter:InteractorToPresenterConversationProtocol?{get set}
    var navigationController:UINavigationController?{get set}
    func didTapComposeButton()
    func didGetUser(user:User)
    func getConversations()
}


protocol InteractorToPresenterConversationProtocol {
    
    func didfetchConvervations(conversations:[Conversation])
}

protocol PresenterToViewConversationProtocol {
    func reloadData()
}


protocol PresenterToRouterConversationsProcol {
    static func createModule(ref:ConversationsViewController,navigationController:UINavigationController)
}
