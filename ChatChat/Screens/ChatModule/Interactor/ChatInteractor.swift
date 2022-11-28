//
//  ChatInteractor.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 25.11.2022.
//

import Foundation
import UIKit
import FirebaseAuth
import MessageKit

class ChatInteractor:PresenterToInteractorChatProtocol {
    var navigationController: UINavigationController?
    var messages = [Message]()
    var presenter: InteractorToPresenterChatProtocol?
    
    func getChats(otherId: String) {
        

        DataBaseManager.shared.getChats(otherId: otherId) { [weak self] result in
            switch result {
                
            case .success(let chats):
                self?.messages.removeAll(keepingCapacity: false)
                chats.map { chat in
                    let sender = Sender(photoURL: "", senderId: chat.senderId, displayName: "")
                    let message = Message(sender: sender, messageId: chat.receiverId, sentDate: chat.date.convertToDate(), kind: .text(chat.content))
                    self?.messages.append(message)
        
                }
                self?.presenter?.didFetchMessages(messages: self!.messages)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
    }
    
    
    
    func sendMessage(text: String, otherUserId: String, sender: SenderType) {
        let message = Message(sender: sender, messageId: otherUserId, sentDate: Date(), kind: .text(text))
        DataBaseManager.shared.createNewConversation(receiverUserId: otherUserId, firstMessage: message) { bool in
            self.presenter?.didSendMessage()
            }
    }
    
    
}

