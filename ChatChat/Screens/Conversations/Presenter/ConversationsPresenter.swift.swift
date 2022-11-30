//
//  ConversationsPresenter.swift.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 21.11.2022.
//

import Foundation

class ConversationsPresenter:ViewToPresenterConversationsProcotol {
    var view: PresenterToViewConversationProtocol?
    var conversationArray = [Conversation]()
    var interactor: PresenterToInteractorConversationsProtocol?
    
    func didTapComposeButton() {
        interactor?.didTapComposeButton()
    }
    
    func didGetUser(user: User) {
        interactor?.didGetUser(user: user)
    }
    
    func getConversations() {
        interactor?.getConversations()
    }
    
    func getConversation(indexpath: IndexPath) -> Conversation {
        
        return conversationArray[indexpath.row]
    }
    
    func getConversationCount() -> Int {
        conversationArray.count
    }
    
    func didSelectRow(at indexpath: IndexPath) {
        let conversation = conversationArray[indexpath.row]
        interactor?.didSelectRow(conversation: conversation)
    }
    func delete(at indexpath: IndexPath) {
        let receiverId = conversationArray[indexpath.row].user_id
        interactor?.delete(receiverId: receiverId)
    }
    func viewDidLoad() {
        view?.style()
        view?.configureTableView()
        view?.configureBarButton()
        interactor?.updateStatusOnline()
        
    }
}


extension ConversationsPresenter:InteractorToPresenterConversationProtocol{
    func didfetchConvervations(conversations: [Conversation]) {
        conversationArray = conversations
        view?.reloadData()
    }
    
    
}
