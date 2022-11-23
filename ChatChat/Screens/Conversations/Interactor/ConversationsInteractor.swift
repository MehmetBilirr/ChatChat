//
//  ConversationsInteractor.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 20.11.2022.
//

import Foundation
import UIKit

class ConversationsInteractor:PresenterToInteractorConversationsProtocol {
    var presenter: InteractorToPresenterConversationProtocol?
    
    var navigationController: UINavigationController?
    
    
    func didTapComposeButton() {
        
        let vc = UINavigationController(rootViewController: NewConversationViewController())
        vc.modalPresentationStyle = .popover
        navigationController?.present(vc, animated: true)
    }
    
    func didGetUser(user: User) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            let vc = ChatViewController()
            vc.chosenUser = user
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func getConversations() {
        
        DataBaseManager.shared.getConversations { conservations in
            self.presenter?.didfetchConvervations(conversations: conservations)
        }
    }
}

