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

class ChatViewController:MessagesViewController {
    var isNewConversation = false
    private var messages = [Message]()
    private let selfSender : SenderType = {
        let auth = Auth.auth().currentUser
        guard let id = auth?.uid, let name = auth?.displayName, let imageUrl = auth?.photoURL?.absoluteString else {return Sender(photoURL: "", senderId: "", displayName: "")}
        let selfsender = Sender(photoURL: imageUrl, senderId: id, displayName: name)
        return selfsender
    }()
    var chosenUser:User?
    override func viewDidLoad() {
        super.viewDidLoad()
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
        messageInputBar.delegate = self
        self.navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = ("\(chosenUser!.firstName) \(chosenUser!.lastName)")
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

extension ChatViewController:InputBarAccessoryViewDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        guard !text.replacingOccurrences(of: " ", with: "").isEmpty else {return}
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let chosenUser = chosenUser else {return}
        let chosenUserId = chosenUser.uid
        let chosenUserName = "\(chosenUser.firstName) \(chosenUser.lastName)"
        let messageId = chosenUserId

        let message = Message(sender: selfSender, messageId: messageId, sentDate: Date(), kind: .text(text))
        if !isNewConversation {
            DataBaseManager.shared.createNewConversation(toUserId: chosenUserId, name: chosenUserName, firstMessage: message) { bool in
                print("")
            }
        }
    }
    
    
}
