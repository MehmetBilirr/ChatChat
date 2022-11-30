//
//  ConversationsInteractor.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 20.11.2022.
//

import Foundation
import UIKit
import ProgressHUD

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
            self.pushNavigation(user: user)
        }
        
    }
    
    func getConversations() {
        
        DataBaseManager.shared.getConversations { conservations in
            self.presenter?.didfetchConvervations(conversations: conservations)
        }
    }
    
    func didSelectRow(conversation: Conversation) {
        self.pushNavigation(conversation:conversation)
        
    }
    func delete(receiverId: String) {
        
        DataBaseManager.shared.deleteConversations(otherId: receiverId) { bool in
            if bool {
               print("seccess")
            }
        }
    }
    
    private func pushNavigation(user:User?=nil,conversation:Conversation?=nil){
        let vc = ChatViewController()
        vc.chosenUser = user
        vc.chosenConversation = conversation
        navigationController?.pushViewController(vc, animated: true)
    }
}

