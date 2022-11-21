//
//  ChatViewController.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 21.11.2022.
//

import Foundation
import MessageKit

class ChatViewController:MessagesViewController {
  
    
    private var messages = [Message]()
    private let selfSender = Sender(photoURL: "", senderId: "1", displayName: "Mehmet Bilir")

    override func viewDidLoad() {
        super.viewDidLoad()
        messages.append(.init(sender: selfSender, messageId: "1", sentDate: Date(), kind: .text("Hello World")))
        messages.append(.init(sender: selfSender, messageId: "1", sentDate: Date(), kind: .text("Hello Worlddddddddd")))
        setup()
        
    }
    
    
}

extension ChatViewController {
    
    private func setup(){
        configureCollectionView()
    }
    private func configureCollectionView(){
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDataSource = self
    }
    
}

extension ChatViewController:MessagesDataSource,MessagesLayoutDelegate,MessagesDisplayDelegate {
    func currentSender() -> SenderType {
        return selfSender
    }

    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        messages.count
    }
    
    
}
