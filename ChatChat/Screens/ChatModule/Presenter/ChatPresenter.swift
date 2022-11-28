//
//  ChatPresenter.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 25.11.2022.
//

import Foundation
import MessageKit


class ChatPresenter:ViewToPresenterChatProtocol {
    var interactor: PresenterToInteractorChatProtocol?
    var view: PresenterToViewChatProtocol?
    private var messageArray = [Message]()
    private var otherID = ""
    func getChats(otherId: String) {
        otherID = otherId
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
   
    func sendMessage(text: String, otherUserId: String, sender: SenderType) {
        interactor?.sendMessage(text: text, otherUserId: otherUserId, sender: sender)
    }
}


extension ChatPresenter:InteractorToPresenterChatProtocol {
    func didFetchMessages(messages: [Message]) {
        view?.messageArray(messageArray: messages)
        view?.reloadData()
        
    }

    func didSendMessage() {
        interactor?.getChats(otherId: otherID)
        
    }
}



