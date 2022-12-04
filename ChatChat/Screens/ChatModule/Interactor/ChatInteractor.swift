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
import MapKit

class ChatInteractor:PresenterToInteractorChatProtocol {
    var navigationController: UINavigationController?
    var messages = [Message]()
    var presenter: InteractorToPresenterChatProtocol?
    var otherID :String?

    
    func getChats(otherId: String) {
        otherID = otherId
        DataBaseManager.shared.getChats(otherId: otherId) { [weak self] result in
            switch result {
                
            case .success(let messages):
                
                self?.presenter?.didFetchMessages(messages: messages)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    func configureChatStatusView(view: ChatStatusView) {
        guard let uid = otherID else {return}
        DataBaseManager.shared.fetchUserAddSnapshotListener(uuid: uid) { user in
            view.nameLbl.text = "\(user.firstName) \(user.lastName)"
            view.statusLbl.text = user.status.rawValue
            view.imageView.sd_setImage(with: URL(string: user.imageUrl))
        }
    }
    
    func getCurrentUser() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        DataBaseManager.shared.fetchUserAddSnapshotListener(uuid: uid) { [weak self] user in
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
        DataBaseManager.shared.fetchUserAddSnapshotListener(uuid: uid) { user in
            avatarView.sd_setImage(with: URL(string: user.imageUrl))
        }
    }
    
    func didFinishPickingMedia(receiverId: String, imageView: UIImageView, sender: SenderType) {
        DataBaseManager.shared.getImageUrl(imageView: imageView) { image in
            let placeHolder = UIImage(systemName: "plus")
            let imageUrl = URL(string: image)
            let media = Media(url: imageUrl, image: nil, placeholderImage: placeHolder!, size: .zero)
            let message = Message(sender: sender, messageId: receiverId, sentDate: Date(), kind: .photo(media))
            DataBaseManager.shared.createNewConversation(receiverUserId: receiverId, firstMessage: message) {  bool in
                if bool {
                    print("success")
                }
            }
        }
    }
    
    func sendLocationMessage(receiverId: String, sender: SenderType) {
        let vc = LocationViewController(coordinates: nil)
        vc.title = "Pick Location"
        vc.completion = { [weak self] selectedLocation in
            
            guard let strongSelf = self else {
                return
            }
            let longitude:Double = selectedLocation.longitude
            let latitude:Double = selectedLocation.latitude
            let location = Location(location:
                                        CLLocation(latitude: latitude, longitude: longitude),
                                    size: .zero)
            

            let message = Message(sender: sender,
                                  messageId: receiverId,
                                  sentDate: Date(),
                                  kind: .location(location))

            DataBaseManager.shared.createNewConversation(receiverUserId: receiverId, firstMessage: message) { bool in
                if bool {
                    print("success")
                }
            }
            
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

