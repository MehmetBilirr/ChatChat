//
//  NewConversationPresenter.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 21.11.2022.
//

import Foundation

class NewConversationPresenter:ViewToPresenterNewConversationProtocol {
    var newConversationView: PresenterToViewNewConversationProtocol?
    var newConversationInteractor: PresenterToInteractorNewConversationProtocol?
    var userArray = [ChatUser]()
    var filteredUsers = [ChatUser]()
    
    func getChatUser(indexpath: IndexPath) -> ChatUser {
        if (newConversationView?.isActive)! {
            return filteredUsers[indexpath.row]
        }else {
            return userArray[indexpath.row]
        }
    }
   
    
    func getChatUserCount() -> Int {
        if (newConversationView?.isActive)! {
            return filteredUsers.count
        }else {
            return userArray.count
        }
    }
    
    func fetchAllUser() {
        newConversationInteractor?.fetchAllUser()
    }
    func viewDidLoad() {
        newConversationView?.configureTableView()
        
    }
    func fetchFilterUser(text: String) {
        newConversationInteractor?.fetchFilterUser(text: text)
    }
}

extension NewConversationPresenter:InteractorToPresenterNewConversationProtocol {
    func didFetchedAllUser(users: [ChatUser]) {
        userArray = users
        newConversationView?.reloadData()
    }
    func didFetchedFilteredUser(users: [ChatUser]) {
        filteredUsers = users
        newConversationView?.reloadData()
    }
    
}
