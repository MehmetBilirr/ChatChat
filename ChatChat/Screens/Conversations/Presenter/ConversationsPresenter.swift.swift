//
//  ConversationsPresenter.swift.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 21.11.2022.
//

import Foundation

class ConversationsPresenter:ViewToPresenterConversationsProcotol {
    var conversationsInteractor: PresenterToInteractorConversationsProtocol?
    
    func didTapComposeButton() {
        conversationsInteractor?.didTapComposeButton()
    }
}
