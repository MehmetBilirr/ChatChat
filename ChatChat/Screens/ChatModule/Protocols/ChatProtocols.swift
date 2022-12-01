//
//  ChatProtocols.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 25.11.2022.
//

import Foundation
import UIKit
import MessageKit


protocol ViewToPresenterChatProtocol {
    var interactor:PresenterToInteractorChatProtocol?{get set}
    var view:PresenterToViewChatProtocol?{get set}
    func getChats(otherId:String)
    func viewDidLoad()
    func sendMessage(text:String,otherUserId:String,sender:SenderType)
    func chatForItem(at indexPath:IndexPath) -> Message
    func configureAvatarView(uid:String,avatarView:AvatarView)
    func numberOfSection()->Int
    func didFinishPickingMedia(receiverId:String,imageView:UIImageView,sender: SenderType)
    func configureChatStatusView(view:ChatStatusView)
    
    
}


protocol PresenterToInteractorChatProtocol {
    var presenter:InteractorToPresenterChatProtocol?{get set}
    var navigationController:UINavigationController? {get set}
    func sendMessage(text:String,otherUserId:String,sender:SenderType)
    func getChats(otherId:String)
    func getCurrentUser()
    func configureAvatarView(uid:String,avatarView:AvatarView)
    func didFinishPickingMedia(receiverId:String,imageView:UIImageView,sender: SenderType)
    func configureChatStatusView(view:ChatStatusView)
}

protocol InteractorToPresenterChatProtocol {
    
    func didFetchMessages(messages:[Message])
    func didSendMessage()
    func didFetchCurrentUser(user:User)
}


protocol PresenterToViewChatProtocol {
    var presenter:ViewToPresenterChatProtocol?{get set}
    func reloadData()
    func configureCollectionView()
    func messageArray(messageArray:[Message])
    func selfSender(sender:SenderType)
    func configureInputButton()
    func configureBarButton()

}

protocol PresenterToRouterChatPRocotol {
    
    static func createModule(ref:ChatViewController,navigationController:UINavigationController)
}
