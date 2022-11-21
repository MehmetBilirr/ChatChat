//
//  ConversationsPresenter.swift.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 21.11.2022.
//

import Foundation

class ConversationsPresenter:ViewToPresenterConversationsProcotol {
    var interactor: PresenterToInteractorConversationsProtocol?
    
    func didTapComposeButton() {
        interactor?.didTapComposeButton()
    }
    
    func didGetUser(user: ChatUser) {
        interactor?.didGetUser(user: user)
    }
}
