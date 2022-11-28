//
//  ChatViewController.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 21.11.2022.
//

import Foundation
import MessageKit
import InputBarAccessoryView
import FirebaseAuth
import SwiftUI

class ChatViewController:MessagesViewController {
    var isNewConversation = false
    var presenter: ViewToPresenterChatProtocol?
    private var messages = [Message]()
    private let selfSender : SenderType = {
        let auth = Auth.auth().currentUser
        guard let id = auth?.uid, let name = auth?.displayName, let imageUrl = auth?.photoURL?.absoluteString else {return Sender(photoURL: "", senderId: "", displayName: "")}
        let selfsender = Sender(photoURL: imageUrl, senderId: id, displayName: name)
        return selfsender
    }()
    var chosenUser:User?
    var chosenConversation:Conversation?
    override func viewDidLoad() {
        super.viewDidLoad()
        ChatRouter.createModule(ref: self, navigationController: navigationController!)
        presenter?.viewDidLoad()
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let otId = chosenConversation == nil ? chosenUser!.uid : chosenConversation!.user_id
        presenter?.getChats(otherId: otId)
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
        return messages.count
    }
    
    
}

extension ChatViewController:InputBarAccessoryViewDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        guard !text.replacingOccurrences(of: " ", with: "").isEmpty else {return}
 
        let messageId = (chosenUser == nil ? chosenConversation?.user_id : chosenUser?.uid)!
       
        presenter?.sendMessage(text: text, otherUserId: messageId, sender: selfSender)
    }
    
    
}


extension ChatViewController:PresenterToViewChatProtocol {
    func configureCollectionView() {
            messagesCollectionView.messagesDisplayDelegate = self
            messagesCollectionView.messagesLayoutDelegate = self
            messagesCollectionView.messagesDataSource = self
            messageInputBar.delegate = self
            self.navigationController?.navigationBar.prefersLargeTitles = false
            let title = chosenConversation == nil ? "\(chosenUser!.firstName) \(chosenUser!.lastName)" : chosenConversation?.user_name
            navigationItem.title = title
        
    }
    
    
    func reloadData() {
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToBottom(animated: true)
    }
    
    func messageArray(messageArray: [Message]) {
        messages = messageArray
        
        
    }
    
    
}
