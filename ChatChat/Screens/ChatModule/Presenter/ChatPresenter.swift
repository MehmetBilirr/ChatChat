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
        getCurrentUser()
        view?.configureInputButton()
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
    private func getCurrentUser() {
        interactor?.getCurrentUser()
    }
    
    func configureAvatarView(uid: String, avatarView: AvatarView) {
        interactor?.configureAvatarView(uid: uid, avatarView: avatarView)
    }

    func didFinishPickingMedia(receiverId: String, imageView: UIImageView, sender: SenderType) {
        interactor?.didFinishPickingMedia(receiverId: receiverId, imageView: imageView, sender: sender)
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
    func didFetchCurrentUser(user: User) {
        let sender = Sender(photoURL: user.imageUrl, senderId: user.uid, displayName: user.firstName + user.lastName)
        view?.selfSender(sender: sender)
    }
    
    
}



