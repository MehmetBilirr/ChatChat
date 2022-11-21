//
//  NewConversationInteractor.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 21.11.2022.
//

import Foundation
import UIKit

class NewConversationInteractor:PresenterToInteractorNewConversationProtocol {
    var newConversationPresenter: InteractorToPresenterNewConversationProtocol?
    var navigationController: UINavigationController?
    var usersArray = [ChatUser]()
    var filteredUsers = [ChatUser]()
    func fetchAllUser() {
        
        DataBaseManager.shared.fetchUsers { [weak self] users in
            self?.usersArray = users
            self?.newConversationPresenter?.didFetchedAllUser(users: users)
        }
        
    }
    
    func fetchFilterUser(text: String) {
        
        filteredUsers = usersArray.filter({ user in
            if text != "" {
                
                let re =  user.firstName.lowercased().contains(text) || user.lastName.lowercased().contains(text)
                return re
            }else {
                return false
            }
            
        })
        newConversationPresenter?.didFetchedFilteredUser(users: filteredUsers)
        
    }
}

