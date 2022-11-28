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
    private var messageArray = [Message]()
    func getChats(otherId: String) {
        interactor?.getChats(otherId: otherId)
    }
    
    func viewDidLoad() {
        view?.configureCollectionView()
    }
    
    func chatForItem(at indexPath: IndexPath) -> Message {
       
        
        
        return messageArray[indexPath.row]
        
    }
    
    func numberOfSection() -> Int {
        return messageArray.count
    }
}


extension ChatPresenter:InteractorToPresenterChatProtocol {
    func didFetchMessages(messages: [Message]) {
        view?.messageArray(messageArray: messages)
        view?.reloadData()
    }

}



