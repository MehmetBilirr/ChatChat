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
    func viewDidLoad()
    func didTapComposeButton()
    func didGetUser(user:User)
    func getConversations()
    func getConversation(indexpath:IndexPath) -> Conversation
    func getConversationCount() -> Int
    func didSelectRow(at indexpath:IndexPath)
    func delete(at indexpath:IndexPath)

}

protocol PresenterToInteractorConversationsProtocol {
    var presenter:InteractorToPresenterConversationProtocol?{get set}
    var navigationController:UINavigationController?{get set}
    func didTapComposeButton()
    func didGetUser(user:User)
    func getConversations()
    func didSelectRow(conversation:Conversation)
    func delete(receiverId:String)
    func updateStatusOnline()
}


protocol InteractorToPresenterConversationProtocol {
    
    func didfetchConvervations(conversations:[Conversation])
}

protocol PresenterToViewConversationProtocol {
    func reloadData()
    func configureTableView()
    func configureBarButton()
    func style()

}


protocol PresenterToRouterConversationsProcol {
    static func createModule(ref:ConversationsViewController,navigationController:UINavigationController)
}
