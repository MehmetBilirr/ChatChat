//
//  NewConversationProtocol.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 21.11.2022.
//

import Foundation
import UIKit

protocol ViewToPresenterNewConversationProtocol {
    var newConversationInteractor:PresenterToInteractorNewConversationProtocol?{get set}
    var newConversationView:PresenterToViewNewConversationProtocol? {get set}
    func viewDidLoad()
    func fetchAllUser()
    func fetchFilterUser(text:String)
    func getChatUser(indexpath:IndexPath) -> ChatUser
    func getChatUserCount() -> Int
    
    
}


protocol PresenterToInteractorNewConversationProtocol {
    var newConversationPresenter:InteractorToPresenterNewConversationProtocol? {get set}
    var navigationController:UINavigationController?{get set}
    func fetchAllUser()
    func fetchFilterUser(text:String)
}

protocol InteractorToPresenterNewConversationProtocol {
    func didFetchedAllUser(users:[ChatUser])
    func didFetchedFilteredUser(users:[ChatUser])
}

protocol PresenterToViewNewConversationProtocol {
    var isActive: Bool {get}
    func configureTableView()
    func reloadData()
    
}


protocol PresenterToRouterNewConversationProtocol {
    
    static func createModule(ref:NewConversationViewController,navigationController:UINavigationController)
}

