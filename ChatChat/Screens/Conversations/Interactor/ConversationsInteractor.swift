//
//  ConversationsInteractor.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 20.11.2022.
//

import Foundation
import UIKit

class ConversationsInteractor:PresenterToInteractorConversationsProtocol {
    var navigationController: UINavigationController?
    
    
    func didTapComposeButton() {
        
        navigationController?.pushViewController(NewConversationViewController(), animated: true)
    }
}
