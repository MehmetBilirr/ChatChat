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
import ProgressHUD

class ChatInteractor:PresenterToInteractorChatProtocol {
    var navigationController: UINavigationController?
    var messages = [Message]()
    var presenter: InteractorToPresenterChatProtocol?

    
    func getChats(otherId: String) {
        print(otherId)
        DataBaseManager.shared.getChats(otherId: otherId) { [weak self] result in
            switch result {
                
            case .success(let messages):
                print(messages)
                self?.presenter?.didFetchMessages(messages: messages)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    func getCurrentUser() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        DataBaseManager.shared.fetchUser(uuid: uid) { [weak self] user in
            self?.presenter?.didFetchCurrentUser(user: user)
        }
    }
    
    func sendMessage(text: String, otherUserId: String, sender: SenderType) {
        let message = Message(sender: sender, messageId: otherUserId, sentDate: Date(), kind: .text(text))
        DataBaseManager.shared.createNewConversation(receiverUserId: otherUserId, firstMessage: message) { bool in
            self.presenter?.didSendMessage()
            }
    }
    
    func configureAvatarView(uid: String, avatarView: AvatarView) {
        DataBaseManager.shared.fetchUser(uuid: uid) { user in
            avatarView.sd_setImage(with: URL(string: user.imageUrl))
        }
    }
    
    func didFinishPickingMedia(receiverId: String, imageView: UIImageView, sender: SenderType) {
        DataBaseManager.shared.getImageUrl(imageView: imageView) { [weak self] image in
            let placeHolder = UIImage(systemName: "plus")
            let imageUrl = URL(string: image)
            let media = Media(url: imageUrl, image: nil, placeholderImage: placeHolder!, size: .zero)
            let message = Message(sender: sender, messageId: receiverId, sentDate: Date(), kind: .photo(media))
            DataBaseManager.shared.createNewConversation(receiverUserId: receiverId, firstMessage: message) { [weak self] bool in
                if bool {
                    print("succcess")
                }
            }
        
            
        }

    }
    
}

