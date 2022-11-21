//
//  NewConversationPresenter.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 21.11.2022.
//

import Foundation

class NewConversationPresenter:ViewToPresenterNewConversationProtocol {
    var view: PresenterToViewNewConversationProtocol?
    var interactor: PresenterToInteractorNewConversationProtocol?
    var userArray = [ChatUser]()
    var filteredUsers = [ChatUser]()
    
    func getChatUser(indexpath: IndexPath) -> ChatUser {
        if (view?.isActive)! {
            return filteredUsers[indexpath.row]
        }else {
            return userArray[indexpath.row]
        }
    }
   
    
    func getChatUserCount() -> Int {
        if (view?.isActive)! {
            return filteredUsers.count
        }else {
            return userArray.count
        }
    }
    
    func fetchAllUser() {
        interactor?.fetchAllUser()
    }
    func viewDidLoad() {
        view?.configureTableView()
        
    }
    func fetchFilterUser(text: String) {
        interactor?.fetchFilterUser(text: text)
    }
}

extension NewConversationPresenter:InteractorToPresenterNewConversationProtocol {
    func didFetchedAllUser(users: [ChatUser]) {
        userArray = users
        view?.reloadData()
    }
    func didFetchedFilteredUser(users: [ChatUser]) {
        filteredUsers = users
        view?.reloadData()
    }
    
    func didSelectRow(at indexpath: IndexPath) {
        
        if (view?.isActive)! {
            interactor?.didSelectRow(user: filteredUsers[indexpath.row])
        }else {
            interactor?.didSelectRow(user: userArray[indexpath.row])
        }
    }
}
