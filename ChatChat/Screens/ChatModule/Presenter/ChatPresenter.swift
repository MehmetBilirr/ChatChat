//
//  ChatPresenter.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 25.11.2022.
//

import Foundation


class ChatPresenter:ViewToPresenterChatProtocol {
    var interactor: PresenterToInteractorChatProtocol?
    
    var view: PresenterToViewChatProtocol?
    
    func getChats(otherId: String) {
        
    }
    
    func viewDidLoad() {
        view?.configureCollectionView()
    }
    
    
}


extension ChatPresenter:InteractorToPresenterChatProtocol {
    func didFetchChats(chats: [Chat]) {
        
    }
    
    
}
