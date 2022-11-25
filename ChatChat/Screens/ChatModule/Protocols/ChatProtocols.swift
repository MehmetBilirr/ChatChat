//
//  ChatProtocols.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 25.11.2022.
//

import Foundation
import UIKit


protocol ViewToPresenterChatProtocol {
    var interactor:PresenterToInteractorChatProtocol?{get set}
    var view:PresenterToViewChatProtocol?{get set}
    func getChats(otherId:String)
    func viewDidLoad()
}


protocol PresenterToInteractorChatProtocol {
    var presenter:InteractorToPresenterChatProtocol?{get set}
    var navigationController:UINavigationController? {get set}
    func getChats(otherId:String)
}

protocol InteractorToPresenterChatProtocol {
    
    func didFetchChats(chats:[Chat])
}


protocol PresenterToViewChatProtocol {
    var presenter:ViewToPresenterChatProtocol?{get set}
    func reloadData()
    func configureCollectionView()
}

protocol PresenterToRouterChatPRocotol {
    
    static func createModule(ref:ChatViewController,navigationController:UINavigationController)
}
