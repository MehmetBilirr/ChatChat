//
//  NewConversationProtocol.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 21.11.2022.
//

import Foundation
import UIKit

protocol ViewToPresenterNewConversationProtocol {
    var interactor:PresenterToInteractorNewConversationProtocol?{get set}
    var view:PresenterToViewNewConversationProtocol? {get set}
    func viewDidLoad()
    func fetchAllUser()
    func fetchFilterUser(text:String)
    func getChatUser(indexpath:IndexPath) -> User
    func getChatUserCount() -> Int
    func didSelectRow(at indexpath:IndexPath)
    
    
}


protocol PresenterToInteractorNewConversationProtocol {
    var presenter:InteractorToPresenterNewConversationProtocol? {get set}
    var navigationController:UINavigationController?{get set}
    func fetchAllUser()
    func fetchFilterUser(text:String)
    func didSelectRow(user:User)
}

protocol InteractorToPresenterNewConversationProtocol {
    func didFetchedAllUser(users:[User])
    func didFetchedFilteredUser(users:[User])
}

protocol PresenterToViewNewConversationProtocol {
    var presenter:ViewToPresenterNewConversationProtocol? {get set}
    var isActive: Bool {get}
    func configureTableView()
    func reloadData()
    
}


protocol PresenterToRouterNewConversationProtocol {
    
    static func createModule(ref:NewConversationViewController,navigationController:UINavigationController?)
}

