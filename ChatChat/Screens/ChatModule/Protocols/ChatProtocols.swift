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
    func numberOfSection()->Int
    
}


protocol PresenterToInteractorChatProtocol {
    var presenter:InteractorToPresenterChatProtocol?{get set}
    var navigationController:UINavigationController? {get set}
    func sendMessage(text:String,otherUserId:String,sender:SenderType)
    func getChats(otherId:String)
}

protocol InteractorToPresenterChatProtocol {
    
    func didFetchMessages(messages:[Message])
    func didSendMessage()
}


protocol PresenterToViewChatProtocol {
    var presenter:ViewToPresenterChatProtocol?{get set}
    func reloadData()
    func configureCollectionView()
    func messageArray(messageArray:[Message])

}

protocol PresenterToRouterChatPRocotol {
    
    static func createModule(ref:ChatViewController,navigationController:UINavigationController)
}
