//
//  NewConversationInteractor.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 21.11.2022.
//

import Foundation
import UIKit

class NewConversationInteractor:PresenterToInteractorNewConversationProtocol {
    var presenter: InteractorToPresenterNewConversationProtocol?
    var navigationController: UINavigationController?
    var usersArray = [User]()
    var filteredUsers = [User]()
    func fetchAllUser() {
        
        DataBaseManager.shared.fetchUsers { [weak self] users in
            self?.usersArray = users
            self?.presenter?.didFetchedAllUser(users: users)
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
        presenter?.didFetchedFilteredUser(users: filteredUsers)
        
    }
    
    func didSelectRow(user: User) {
        let userDataDict:[String: User] = ["user": user]
        NotificationCenter.default.post(name: .myNotification, object: nil, userInfo: userDataDict)
        navigationController?.dismiss(animated: true)
        
        
    }
    
    
}

